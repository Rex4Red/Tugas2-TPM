import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/kelompok_model.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Hash password menggunakan SHA-256
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Register user baru
  Future<Map<String, dynamic>> register(String nim, String password) async {
    try {
      // 1. Cek apakah NIM ada di data_kelompok
      final kelompokData = await _supabase
          .from('data_kelompok')
          .select()
          .eq('nim', nim)
          .maybeSingle();

      if (kelompokData == null) {
        return {
          'success': false,
          'message': 'NIM tidak terdaftar dalam data kelompok!',
        };
      }

      // 2. Cek apakah NIM sudah punya akun
      final existingUser = await _supabase
          .from('users')
          .select()
          .eq('nim', nim)
          .maybeSingle();

      if (existingUser != null) {
        return {
          'success': false,
          'message': 'NIM sudah terdaftar! Silakan login.',
        };
      }

      // 3. Hash password dan insert ke tabel users
      final hashedPassword = _hashPassword(password);
      await _supabase.from('users').insert({
        'nim': nim,
        'password': hashedPassword,
      });

      return {
        'success': true,
        'message': 'Registrasi berhasil! Silakan login.',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: ${e.toString()}',
      };
    }
  }

  // Login user
  Future<Map<String, dynamic>> login(String nim, String password) async {
    try {
      // 1. Cek apakah NIM ada di data_kelompok
      final kelompokData = await _supabase
          .from('data_kelompok')
          .select()
          .eq('nim', nim)
          .maybeSingle();

      if (kelompokData == null) {
        return {
          'success': false,
          'message': 'NIM tidak terdaftar dalam data kelompok!',
        };
      }

      // 2. Cek apakah NIM sudah punya akun
      final userData = await _supabase
          .from('users')
          .select()
          .eq('nim', nim)
          .maybeSingle();

      if (userData == null) {
        return {
          'success': false,
          'message': 'Akun belum terdaftar! Silakan daftar terlebih dahulu.',
        };
      }

      // 3. Verifikasi password
      final hashedPassword = _hashPassword(password);
      if (userData['password'] != hashedPassword) {
        return {
          'success': false,
          'message': 'Password salah!',
        };
      }

      // 4. Simpan session
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('logged_in_nim', nim);
      await prefs.setString(
          'logged_in_nama', kelompokData['nama_lengkap'] as String);

      return {
        'success': true,
        'message': 'Login berhasil!',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: ${e.toString()}',
      };
    }
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('logged_in_nim');
    await prefs.remove('logged_in_nama');
  }

  // Cek apakah sudah login
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('logged_in_nim');
  }

  // Ambil data user yang login
  Future<Map<String, String>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final nim = prefs.getString('logged_in_nim');
    final nama = prefs.getString('logged_in_nama');

    if (nim == null || nama == null) return null;
    return {'nim': nim, 'nama': nama};
  }

  // Ambil semua data kelompok
  Future<List<KelompokModel>> getDataKelompok() async {
    final response = await _supabase
        .from('data_kelompok')
        .select()
        .order('nim', ascending: true);

    return (response as List)
        .map((json) => KelompokModel.fromJson(json))
        .toList();
  }
}

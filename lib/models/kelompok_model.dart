class KelompokModel {
  final int id;
  final String nim;
  final String namaLengkap;

  KelompokModel({
    required this.id,
    required this.nim,
    required this.namaLengkap,
  });

  factory KelompokModel.fromJson(Map<String, dynamic> json) {
    return KelompokModel(
      id: json['id'] as int,
      nim: json['nim'] as String,
      namaLengkap: json['nama_lengkap'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nim': nim,
      'nama_lengkap': namaLengkap,
    };
  }
}

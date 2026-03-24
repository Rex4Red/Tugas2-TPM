import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  final List<String> _laps = [];

  // ============================================================
  // CUSTOM START TIME — Edit nilai di bawah ini untuk mengatur
  // waktu mulai stopwatch (default: 00:00:00.00)
  // ============================================================
  static const int _startJam    = 0;   // 0-23
  static const int _startMenit  = 0;   // 0-59
  static const int _startDetik  = 0;   // 0-59
  static const int _startMs     = 0;   // 0-99
  // ============================================================

  // Konversi start time ke milliseconds
  int _offsetMilliseconds = (_startJam * 3600000) +
      (_startMenit * 60000) +
      (_startDetik * 1000) +
      (_startMs * 10);

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  void _stopTimer() {
    _stopwatch.stop();
    _timer?.cancel();
    setState(() {});
  }

  void _resetTimer() {
    _stopwatch.reset();
    _timer?.cancel();
    setState(() {
      _laps.clear();
      // Reset offset ke custom start time
      _offsetMilliseconds = (_startJam * 3600000) +
          (_startMenit * 60000) +
          (_startDetik * 1000) +
          (_startMs * 10);
    });
  }

  void _addLap() {
    setState(() {
      _laps.insert(
          0, _formatTime(_stopwatch.elapsedMilliseconds + _offsetMilliseconds));
    });
  }

  String _formatTime(int milliseconds) {
    int hours = milliseconds ~/ 3600000;
    int minutes = (milliseconds ~/ 60000) % 60;
    int seconds = (milliseconds ~/ 1000) % 60;
    int ms = (milliseconds % 1000) ~/ 10;

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}.'
        '${ms.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = _stopwatch.isRunning;
    final elapsed = _stopwatch.elapsedMilliseconds + _offsetMilliseconds;
    final hasStarted =
        _stopwatch.isRunning || _stopwatch.elapsedMilliseconds > 0;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Stopwatch'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Timer Display
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                Text(
                  _formatTime(elapsed),
                  style: const TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontFamily: 'monospace',
                    letterSpacing: 4,
                  ),
                ),
                if (_offsetMilliseconds > 0 && !hasStarted) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Start dari ${_formatTime(_offsetMilliseconds)}',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Control Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Reset Button
              _buildControlButton(
                icon: Icons.refresh_rounded,
                label: 'Reset',
                color: Colors.grey,
                onPressed: elapsed > 0 ? _resetTimer : null,
              ),
              const SizedBox(width: 24),

              // Start/Stop Button
              _buildControlButton(
                icon: isRunning
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
                label: isRunning ? 'Stop' : 'Start',
                color: isRunning ? Colors.red : Colors.teal,
                onPressed: isRunning ? _stopTimer : _startTimer,
                isLarge: true,
              ),
              const SizedBox(width: 24),

              // Lap Button
              _buildControlButton(
                icon: Icons.flag_rounded,
                label: 'Lap',
                color: Colors.orange,
                onPressed: isRunning ? _addLap : null,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Lap List
          if (_laps.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Text(
                    'Lap Records',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey[700],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: _laps.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Lap ${_laps.length - index}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey[600],
                          ),
                        ),
                        Text(
                          _laps[index],
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ] else
            const Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onPressed,
    bool isLarge = false,
  }) {
    final size = isLarge ? 72.0 : 56.0;
    return Column(
      children: [
        SizedBox(
          width: size,
          height: size,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: onPressed != null ? color : Colors.grey[300],
              foregroundColor: Colors.white,
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: onPressed != null ? 4 : 0,
            ),
            child: Icon(icon, size: isLarge ? 32 : 24),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

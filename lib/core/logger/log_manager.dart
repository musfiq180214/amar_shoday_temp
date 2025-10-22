import 'dart:async';
import 'package:logger/logger.dart';

/// Handles in-memory buffering and (future) backend sync of logs.
class LogManager {
  LogManager._();
  static final LogManager instance = LogManager._();

  final List<Map<String, dynamic>> _logBuffer = [];
  Timer? _batchTimer;
  bool _isProduction = false;

  void init({bool isProduction = false}) {
    _isProduction = isProduction;
    _batchTimer?.cancel();
    _batchTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      _flushLogs();
    });
  }

  void addLog({
    required Level level,
    required String message,
    String? error,
    String? stackTrace,
  }) {
    final logEntry = {
      'timestamp': DateTime.now().toIso8601String(),
      'level': level.toString(),
      'message': message,
      if (error != null) 'error': error,
      if (stackTrace != null) 'stack': stackTrace,
    };

    _logBuffer.add(logEntry);

    if (!_isProduction) {
      _flushLogs(); // show instantly in debug
    } else if (_logBuffer.length >= 50) {
      _flushLogs();
    }
  }

  void _flushLogs() {
    if (_logBuffer.isEmpty) return;

    // TODO: integrate your API call here later:
    // await sendLogsToBackend(_logBuffer);

    _logBuffer.clear();
  }

  void dispose() {
    _batchTimer?.cancel();
  }
}

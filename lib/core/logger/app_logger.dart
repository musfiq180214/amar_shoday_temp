import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:amar_shoday/core/logger/log_manager.dart';

/// Global, structured logger for the whole app.
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 6,
      lineLength: 100,
      colors: true,
      printEmojis: true,
      noBoxingByDefault: true,
    ),
  );

  final String tag;

  AppLogger({this.tag = ''});
  factory AppLogger.getLogger(String tag) => AppLogger(tag: tag);

  void _log(
    Level level,
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    final msg = tag.isNotEmpty ? '[$tag] $message' : message.toString();

    if (kDebugMode) {
      _logger.log(level, msg, error: error, stackTrace: stackTrace);
    }

    LogManager.instance.addLog(
      level: level,
      message: msg,
      error: error?.toString(),
      stackTrace: stackTrace?.toString(),
    );

    if (kReleaseMode) {
      developer.log(
        msg,
        name: tag,
        error: error,
        stackTrace: stackTrace,
        level: _toDevLevel(level),
      );
    }
  }

  void v(dynamic message) => _log(Level.verbose, message);
  void d(dynamic message) => _log(Level.debug, message);
  void i(dynamic message) => _log(Level.info, message);
  void w(dynamic message) => _log(Level.warning, message);
  void e(dynamic message, [Object? error, StackTrace? stackTrace]) =>
      _log(Level.error, message, error: error, stackTrace: stackTrace);
  void wtf(dynamic message) => _log(Level.wtf, message);

  static void init({bool isProduction = false}) {
    Logger.level = isProduction ? Level.warning : Level.verbose;
    LogManager.instance.init(isProduction: isProduction);
  }

  int _toDevLevel(Level level) {
    switch (level) {
      case Level.error:
        return 1000;
      case Level.warning:
        return 900;
      case Level.info:
        return 800;
      case Level.debug:
        return 700;
      case Level.verbose:
        return 600;
      default:
        return 500;
    }
  }
}

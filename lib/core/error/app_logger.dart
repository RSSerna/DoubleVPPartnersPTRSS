import 'package:logger/logger.dart';

class AppLogger {
  static final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
  );

  static void info(String message, [dynamic data]) {
    _logger.log(Level.info, message);
  }

  static void debug(String message, [dynamic data]) {
    _logger.log(Level.debug, message);
  }

  static void warning(String message, [dynamic data, StackTrace? stackTrace]) {
    _logger.log(Level.warning, message);
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.log(Level.error, message);
  }
}

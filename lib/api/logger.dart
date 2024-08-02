import 'dart:developer' as developer;

// Reset:   \x1B[0m
// Black:   \x1B[30m
// White:   \x1B[37m
// Red:     \x1B[31m
// Green:   \x1B[32m
// Yellow:  \x1B[33m
// Blue:    \x1B[34m
// Cyan:    \x1B[36m

abstract class Log {
// Blue text
  static void info(bool kReleaseMode, dynamic msg) {
    if (kReleaseMode) return;
    developer.log('\x1B[34m${msg.toString()}\x1B[0m');
  }

// Green text
  static void success(bool kReleaseMode, dynamic msg) {
    if (kReleaseMode) return;

    developer.log('\x1B[32m${msg.toString()}\x1B[0m');
  }

// Yellow text
  static void warning(bool kReleaseMode, dynamic msg) {
    if (kReleaseMode) return;
    developer.log('\x1B[33m${msg.toString()}\x1B[0m');
  }

// Red text
  static void error(bool kReleaseMode, dynamic msg) {
    if (kReleaseMode) return;
    final msgString = msg.toString();
    developer.log('\x1B[31m$msgString\x1B[0m');
  }
}

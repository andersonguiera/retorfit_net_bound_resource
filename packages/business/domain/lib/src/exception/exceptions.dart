abstract class DomainException implements Exception {
  /// Readable to final user
  String get fancyMessage;

  /// For logging purposes
  String get completeMessage;

  /// StackTrace for logging purposes
  StackTrace? get stackTrace;
}

/// Not authorized - We don't know who you are!
abstract class UnauthorisedException implements DomainException {}

/// Forbidden - We know who you are but your credentials not allowed you do what
/// you want.
abstract class ForbiddenException implements DomainException {}

/// Not Found - Sorry but we don't find the resource you are looking for.
abstract class NotFoundException implements DomainException {}

/// Something went wrong when we tried read/write data
abstract class IOException extends DomainException {}

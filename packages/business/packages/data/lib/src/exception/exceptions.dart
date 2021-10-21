import 'package:domain/exceptions.dart' as domain;

abstract class DataException implements domain.DomainException {
  final String _prefix;
  final String _message;
  final StackTrace? _stackTrace;

  DataException(this._prefix, [this._message = '', this._stackTrace]);

  @override
  String toString() {
    return "$_prefix:\n$_message";
  }

  @override
  String get fancyMessage => _prefix;

  @override
  String get completeMessage => '$_prefix: $_message';

  @override
  StackTrace? get stackTrace => _stackTrace;
}

/// Error code 400
class BadRequestException extends DataException implements domain.IOException {
  BadRequestException([String? message, StackTrace? stackTrace])
      : super('Something went wrong when we tried send data to server.',
            message ?? '', stackTrace);
}

/// Error code 401
class UnauthorisedException extends DataException
    implements domain.UnauthorisedException {
  UnauthorisedException([String? message, StackTrace? stackTrace])
      : super('You are not authorized to do this operation. Try login first.',
            message ?? '', stackTrace);
}

/// Error code 403
class ForbiddenException extends DataException
    implements domain.ForbiddenException {
  ForbiddenException([String? message, StackTrace? stackTrace])
      : super('You are not allowed to perform this operation.', message ?? '',
            stackTrace);
}

/// Error code 404
class NotFoundException extends DataException
    implements domain.NotFoundException {
  NotFoundException([String? message, StackTrace? stackTrace])
      : super('This resource doesn' 't exist', message ?? '', stackTrace);
}

/// Error code default
class FetchDataException extends DataException implements domain.IOException {
  FetchDataException([String? message, StackTrace? stackTrace])
      : super('Sorry but we can not read this data from server.', message ?? '',
            stackTrace);
}

class DataException implements Exception {
  final String? _message;
  final String _prefix;

  DataException(this._prefix, [this._message]);

  @override
  String toString() {
    return "$_prefix:\n$_message";
  }

  String get fancyError => _prefix;
}

/// Error code 400
class BadRequestException extends DataException {
  BadRequestException([message])
      : super('Requisição inválida',message);
}

/// Error code 401
class UnauthorisedException extends DataException {
  UnauthorisedException([message]) : super("Não autorizado.", message);
}

/// Error code 403
class ForbiddenException extends DataException {
  ForbiddenException([message])
      : super("Você não possui privilégios para executar essa operação.",
            message);
}

/// Error code 404
class NotFoundException extends DataException {
  NotFoundException([message])
      : super("O recurso não foi encontrado.",
      message);
}

/// Error code default
class FetchDataException extends DataException {
  FetchDataException([String? message])
      : super('Erro durante a comunicação', message);
}

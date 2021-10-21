import 'package:equatable/equatable.dart';

class User extends Equatable{
  const User(this.id, this.name, this.email, this.gender, this.status);

  final dynamic id;
  final String name;
  final String email;
  final String gender;
  final String status;

  static const empty = User('','','','', '');

  User copyWith(
          {String? name,
          String? email,
          String? gender,
          String? status,
          }) =>
      User(
          id,
          name ?? this.name,
          email ?? this.email,
          gender ?? this.gender,
          status ?? this.status,);

  @override
  List<Object?> get props => [id, name, email];
}

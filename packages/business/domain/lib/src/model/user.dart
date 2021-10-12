
class User {
  const User(this.id, this.name, this.email, this.gender, this.status);

  final dynamic id;
  final String name;
  final String email;
  final String gender;
  final String status;

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
}

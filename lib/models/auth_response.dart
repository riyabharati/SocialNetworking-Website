import 'dart:convert';

class AuthResponse {
  final bool? success;
  final User? user;
  final String? token;
  AuthResponse({
    this.success,
    this.user,
    this.token,
  });

  AuthResponse copyWith({
    bool? success,
    User? user,
    String? token,
  }) {
    return AuthResponse(
      success: success ?? this.success,
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'user': user?.toMap(),
      'token': token,
    };
  }

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      success: map['success'],
      user: map['user'] != null ? User.fromMap(map['user']) : null,
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponse.fromJson(String source) =>
      AuthResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'AuthResponse(success: $success, user: $user, token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthResponse &&
        other.success == success &&
        other.user == user &&
        other.token == token;
  }

  @override
  int get hashCode => success.hashCode ^ user.hashCode ^ token.hashCode;
}

class User {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? dob;
  final String? gender;
  final String? password;
  final String? profilePicture;
  User({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.dob,
    this.gender,
    this.profilePicture,
  });

  User copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? dob,
    String? password,
    String? gender,
    String? profilePicture,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      dob: dob ?? this.dob,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  Map<String, dynamic> toMap() {
    return {'email': email, 'password': password};
  }

  Map<String, dynamic> passwordMap() {
    return {'password': password};
  }

  Map<String, dynamic> profileMap() {
    return {
      'firstName': firstName,
      "lastName": lastName,
      "dob": dob,
      "gender": gender
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      dob: map['dob'],
      gender: map['gender'],
      profilePicture: map['profilePicture'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, email: $email, dob: $dob, gender: $gender, profilePicture: $profilePicture)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.dob == dob &&
        other.gender == gender &&
        other.profilePicture == profilePicture;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        dob.hashCode ^
        gender.hashCode ^
        profilePicture.hashCode;
  }
}

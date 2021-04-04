class SignupBody {
  String email;
  String password;
  String cPassword;
  String firstname;
  String lastname;

  SignupBody({
    required this.email,
    required this.password,
    required this.cPassword,
    required this.firstname,
    required this.lastname,
  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["email"] = email;
    map["password"] = password;
    map["cPassword"] = cPassword;
    map["firstname"] = firstname;
    map["lastname"] = lastname;
    return map;
  }

  SignupBody copyWith({
    String? email,
    String? password,
    String? cPassword,
    String? firstname,
    String? lastname,
  }) {
    return new SignupBody(
      email: email ?? this.email,
      password: password ?? this.password,
      cPassword: cPassword ?? this.cPassword,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
    );
  }
}

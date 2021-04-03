class SignupBody {
  late final String email;
  late final String password;
  late final String cPassword;
  late final String firstname;
  late final String lastname;

  SignupBody({
    required this.email,
    required this.password,
    required this.cPassword,
    required this.firstname,
    required this.lastname,
  });

  SignupBody.fromJson(dynamic json) {
    email = json["email"];
    password = json["password"];
    cPassword = json["cPassword"];
    firstname = json["firstname"];
    lastname = json["lastname"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["email"] = email;
    map["password"] = password;
    map["cPassword"] = cPassword;
    map["firstname"] = firstname;
    map["lastname"] = lastname;
    return map;
  }
}

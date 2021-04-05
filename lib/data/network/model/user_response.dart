import 'package:equatable/equatable.dart';

class UserResponse extends Equatable {
  late final String id;
  late final String email;
  late final String firstname;
  late final String lastname;
  late final String createdAt;
  late final String updatedAt;

  UserResponse({
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.createdAt,
    required this.updatedAt,
  });

  UserResponse.fromJson(dynamic json) {
    id = json["_id"] ?? json['userId'];
    email = json["email"];
    firstname = json["firstname"];
    lastname = json["lastname"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["_id"] = id;
    map["email"] = email;
    map["firstname"] = firstname;
    map["lastname"] = lastname;
    map["createdAt"] = createdAt;
    map["updatedAt"] = updatedAt;
    return map;
  }

  @override
  List<Object?> get props => [id];

  UserResponse copyWith({
    String? id,
    String? email,
    String? firstname,
    String? lastname,
    String? createdAt,
    String? updatedAt,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (email == null || identical(email, this.email)) &&
        (firstname == null || identical(firstname, this.firstname)) &&
        (lastname == null || identical(lastname, this.lastname)) &&
        (createdAt == null || identical(createdAt, this.createdAt)) &&
        (updatedAt == null || identical(updatedAt, this.updatedAt))) {
      return this;
    }

    return new UserResponse(
      id: id ?? this.id,
      email: email ?? this.email,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

UserResponse getDummyUser() {
  return UserResponse(
      id: 'id',
      email: 'email',
      firstname: 'firstname',
      lastname: 'lastname',
      createdAt: 'createdAt',
      updatedAt: 'updatedAt');
}

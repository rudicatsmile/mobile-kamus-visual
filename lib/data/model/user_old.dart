class UserOld {
  UserOld({
    this.idUser,
    this.name,
    this.email,
    this.password,
    this.level,
    this.createdAt,
    this.updatedAt,
  });


  int? idUser;
  String? name;
  String? email;
  String? password;
  String? level;
  String? createdAt;
  String? updatedAt;

  factory UserOld.fromJson(Map<String, dynamic> json) => UserOld(
        idUser: json["id_user"] != null
            ? int.parse(json["id_user"].toString())
            : null,
        name: json["name"],
        email: json["email"],
        password: json["password"],
        level: json["level"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "name": name,
        "email": email,
        "password": password,
        "level": level,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

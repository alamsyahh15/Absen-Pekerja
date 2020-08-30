// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.status,
        this.message,
        this.user,
    });

    int status;
    String message;
    User user;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "user": user == null ? null : user.toJson(),
    };
}

class User {
    User({
        this.idUser,
        this.fullnameUser,
        this.emailUser,
        this.usernameUser,
        this.passwordUser,
        this.roleId,
        this.idRole,
        this.nameRole,
    });

    String idUser;
    String fullnameUser;
    String emailUser;
    String usernameUser;
    String passwordUser;
    String roleId;
    String idRole;
    String nameRole;

    factory User.fromJson(Map<String, dynamic> json) => User(
        idUser: json["id_user"] == null ? null : json["id_user"],
        fullnameUser: json["fullname_user"] == null ? null : json["fullname_user"],
        emailUser: json["email_user"] == null ? null : json["email_user"],
        usernameUser: json["username_user"] == null ? null : json["username_user"],
        passwordUser: json["password_user"] == null ? null : json["password_user"],
        roleId: json["role_id"] == null ? null : json["role_id"],
        idRole: json["id_role"] == null ? null : json["id_role"],
        nameRole: json["name_role"] == null ? null : json["name_role"],
    );

    Map<String, dynamic> toJson() => {
        "id_user": idUser == null ? null : idUser,
        "fullname_user": fullnameUser == null ? null : fullnameUser,
        "email_user": emailUser == null ? null : emailUser,
        "username_user": usernameUser == null ? null : usernameUser,
        "password_user": passwordUser == null ? null : passwordUser,
        "role_id": roleId == null ? null : roleId,
        "id_role": idRole == null ? null : idRole,
        "name_role": nameRole == null ? null : nameRole,
    };
}

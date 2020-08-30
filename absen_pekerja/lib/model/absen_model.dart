// To parse this JSON data, do
//
//     final absenModel = absenModelFromJson(jsonString);

import 'dart:convert';

AbsenModel absenModelFromJson(String str) => AbsenModel.fromJson(json.decode(str));

String absenModelToJson(AbsenModel data) => json.encode(data.toJson());

class AbsenModel {
    AbsenModel({
        this.status,
        this.message,
        this.absen,
    });

    int status;
    String message;
    List<Absen> absen;

    factory AbsenModel.fromJson(Map<String, dynamic> json) => AbsenModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        absen: json["absen"] == null ? null : List<Absen>.from(json["absen"].map((x) => Absen.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "absen": absen == null ? null : List<dynamic>.from(absen.map((x) => x.toJson())),
    };
}

class Absen {
    Absen({
        this.idUser,
        this.fullnameUser,
        this.emailUser,
        this.usernameUser,
        this.passwordUser,
        this.roleId,
        this.nameRole,
        this.idAbsen,
        this.checkIn,
        this.checkOut,
        this.place,
    });

    String idUser;
    String fullnameUser;
    String emailUser;
    String usernameUser;
    String passwordUser;
    String roleId;
    String nameRole;
    dynamic idAbsen;
    dynamic checkIn;
    dynamic checkOut;
    dynamic place;

    factory Absen.fromJson(Map<String, dynamic> json) => Absen(
        idUser: json["id_user"] == null ? null : json["id_user"],
        fullnameUser: json["fullname_user"] == null ? null : json["fullname_user"],
        emailUser: json["email_user"] == null ? null : json["email_user"],
        usernameUser: json["username_user"] == null ? null : json["username_user"],
        passwordUser: json["password_user"] == null ? null : json["password_user"],
        roleId: json["role_id"] == null ? null : json["role_id"],
        nameRole: json["name_role"] == null ? null : json["name_role"],
        idAbsen: json["id_absen"],
        checkIn: json["check_in"],
        checkOut: json["check_out"],
        place: json["place"],
    );

    Map<String, dynamic> toJson() => {
        "id_user": idUser == null ? null : idUser,
        "fullname_user": fullnameUser == null ? null : fullnameUser,
        "email_user": emailUser == null ? null : emailUser,
        "username_user": usernameUser == null ? null : usernameUser,
        "password_user": passwordUser == null ? null : passwordUser,
        "role_id": roleId == null ? null : roleId,
        "name_role": nameRole == null ? null : nameRole,
        "id_absen": idAbsen,
        "check_in": checkIn,
        "check_out": checkOut,
        "place": place,
    };
}

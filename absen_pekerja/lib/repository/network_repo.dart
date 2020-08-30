import 'dart:convert';
import 'dart:io';
import 'package:absen_pekerja/model/history_model.dart';
import 'package:async/async.dart';
import 'package:absen_pekerja/model/absen_model.dart';
import 'package:absen_pekerja/model/role_modle.dart';
import 'package:absen_pekerja/model/user_model.dart';
import 'package:absen_pekerja/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NetworkRepo {
  Future getHistory() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var idUser = prefs.get("iduser");
      final response = await http.post(baseUrl + "getHistory", body: {
        'iduser': idUser,
      });
      if (response.statusCode == 200) {
        if (historyModelFromJson(response.body).status == 200) {
          return historyModelFromJson(response.body).dataHistory;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future updateImage(File image) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var idUser = prefs.get("iduser");
      var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
      var length = await image.length();
      var request =
          http.MultipartRequest('POST', Uri.parse(baseUrl + "updatePhoto"));
      var multipart =
          http.MultipartFile('image', stream, length, filename: image.path);
      request.fields['iduser'] = idUser;
      request.files.add(multipart);
      var response = await request.send();
      if (response.statusCode == 200) {
        print("Successfuly Update Image");
      } else {
        print("Failed Update Image");
      }
    } catch (e) {
      return null;
    }
  }

  Future updateProfile(name, email, username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idUser = prefs.get("iduser");
    try {
      final response = await http.post(baseUrl + "updateProfile", body: {
        'iduser': idUser,
        'fullname': name,
        'email': email,
        'username': username,
      });

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future checkIn(Absen dataCheckin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var checkinby = prefs.get("iduser");
    try {
      final response = await http.post(baseUrl + "checkIn", body: {
        'place': dataCheckin.place,
        'checkin_by': checkinby,
        'iduser': dataCheckin.idUser,
      });
      print("Response ${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future checkOut(Absen dataCheckin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var checkoutby = prefs.get("iduser");
    try {
      final response = await http.post(baseUrl + "checkOut", body: {
        'id_absen': dataCheckin.idAbsen,
        'checkout_by': checkoutby,
        'iduser': dataCheckin.idUser,
        'jam_kerja': "08:00"
      });
      print("Response ${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List> getAbsen(String idUser) async {
    try {
      final response = await http.post(baseUrl + "getAbsen", body: {
        'iduser': idUser,
      });
      if (response.statusCode == 200) {
        return absenModelFromJson(response.body).absen;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future getRole() async {
    try {
      final response = await http.get(baseUrl + "getRole");
      if (response.statusCode == 200) {
        return roleModelFromJson(response.body).dataRole;
      } else {
        return null;
      }
    } catch (e) {
      print("Exception $e");
      return null;
    }
  }

  Future loginUser(User dataUser) async {
    try {
      final response = await http.post(baseUrl + "loginUser", body: {
        'password': dataUser.passwordUser,
        'email': dataUser.emailUser,
      });

      print("Response ${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        return userModelFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Exception Login $e");
      return null;
    }
  }

  Future registerUser(User dataUser) async {
    try {
      final response = await http.post(baseUrl + "registerUser", body: {
        'username': dataUser.usernameUser,
        'password': dataUser.passwordUser,
        'email': dataUser.emailUser,
        'fullname': dataUser.fullnameUser,
        'role': dataUser.roleId,
      });

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Exception $e");
      return null;
    }
  }
}

final networkRepo = NetworkRepo();

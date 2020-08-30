import 'package:absen_pekerja/screen/home/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  Future getSesi(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var statusLogin = prefs.getBool("statusLogin");
    var fullname = prefs.getString("fullname");
    var email = prefs.getString("email");
    print("Status Login $statusLogin");
    if (statusLogin == true && fullname != null && email != null) {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => DashboardPage()));
    } else {
      print("Stay Login Page");
    }
  }

  Future clearSesi()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}

final sessionManager = SessionManager();

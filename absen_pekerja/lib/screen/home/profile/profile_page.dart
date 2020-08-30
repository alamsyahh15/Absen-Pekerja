import 'package:absen_pekerja/model/absen_model.dart';
import 'package:absen_pekerja/screen/home/profile/history_page.dart';
import 'package:absen_pekerja/screen/home/profile/listuser_page.dart';
import 'package:absen_pekerja/screen/home/profile/update_profile.dart';
import 'package:absen_pekerja/screen/login_page.dart';
import 'package:absen_pekerja/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final Absen dataAbsen;
  final String fromPage;

  ProfilePage({this.dataAbsen, this.fromPage});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String namefull, role, email, phone, username, idUser;

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      namefull = prefs.get("fullname");
      email = prefs.get("email");
      role = prefs.get("role");
      username = prefs.get("username");
      idUser = prefs.get('iduser');
    });
  }

  void logout() async {
    await sessionManager.clearSesi();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (conttext) => LoginPage()),
        (route) => false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.green,
              height: MediaQuery.of(context).size.height / 2.5,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateProfile(
                                      name: namefull,
                                      role: role,
                                      email: email,
                                      username: username,
                                    ))).then((value) {
                          getUser();
                        });
                      },
                    ),
                  ),
                  ClipOval(
                    child: Container(
                      color: Colors.white,
                      width: 120,
                      height: 120,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Text(
                        widget?.dataAbsen?.fullnameUser ?? namefull ?? "-",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                  Text(
                    widget?.dataAbsen?.nameRole ?? role ?? "-",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.email,
                          color: Colors.blue,
                        ),
                        title: Text(
                          widget?.dataAbsen?.emailUser ?? email ?? "-",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.phone,
                          color: Colors.green,
                        ),
                        title: Text(
                          "Value Phone",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistoryPage()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.history,
                            color: Colors.blue,
                          ),
                          title: Text(
                            "History",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  widget?.fromPage != null
                      ? Center()
                      : Visibility(
                          visible: role?.toLowerCase() == "admin",
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ListUserPage()));
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 16),
                              child: Card(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.supervised_user_circle,
                                    color: Colors.green,
                                  ),
                                  title: Text(
                                    "List User",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                  widget?.fromPage != null
                      ? Center()
                      : Container(
                          margin: EdgeInsets.only(top: 16),
                          child: InkWell(
                            onTap: () {
                              logout();
                            },
                            child: Card(
                              child: ListTile(
                                leading: Icon(
                                  Icons.exit_to_app,
                                  color: Colors.red,
                                ),
                                title: Text(
                                  "Logout",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

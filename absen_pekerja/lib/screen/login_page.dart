import 'package:absen_pekerja/model/user_model.dart';
import 'package:absen_pekerja/repository/network_repo.dart';
import 'package:absen_pekerja/screen/home/dashboard_page.dart';
import 'package:absen_pekerja/screen/register_page.dart';
import 'package:absen_pekerja/utils/constant.dart';
import 'package:absen_pekerja/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  User dataUser = User();

  void showSnackbar(String title) {
    final snackbar = SnackBar(
      content: Text("$title"),
      duration: Duration(seconds: 2),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void validateForm() {
    if (formKey.currentState.validate()) {
      login();
    } else {
      showSnackbar("Please Check your form !!");
    }
  }

  void login() {
    progressDialog(context);
    networkRepo.loginUser(dataUser).then((value) async{
      Navigator.pop(context);
      if (value != null) {
        UserModel response = value;
        if (response.status == 200) {
          showSnackbar(response.message);
          await saveSesi(true, response.user);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => DashboardPage()));
        } else {
          showSnackbar(response.message);
        }
      } else {
        showSnackbar("Please Check your connection");
      }
    });
  }

  Future saveSesi(bool statusLogin, User valUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("statusLogin", statusLogin);
    prefs.setString("fullname", valUser.fullnameUser);
    prefs.setString("email", valUser.emailUser);
    prefs.setString("password", valUser.passwordUser);
    prefs.setString("iduser", valUser.idUser);
    prefs.setString("role", valUser.nameRole);
    prefs.setString("username", valUser.usernameUser);
    prefs.commit();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // sessionManager.clearSesi();
    sessionManager.getSesi(context);
  }

  @override
  Widget build(BuildContext context) {
    double hScreen = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Center(
          child: ListView(
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    height: hScreen,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/bg.png'),
                            fit: BoxFit.cover)),
                  ),
                  Form(
                    key: formKey,
                    child: Container(
                      margin: EdgeInsets.only(top: 120),
                      child: Column(
                        children: <Widget>[
                          Image.asset('assets/logo.png'),

                          /// Email Address
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: TextFormField(
                              autovalidate: true,
                              style: TextStyle(color: Colors.white),
                              initialValue: dataUser?.emailUser ?? "",
                              validator: (val) =>
                                  val.isEmpty ? "Field can\'t Blank" : null,
                              decoration: InputDecoration(
                                  hintText: "Email Address",
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(100))),
                              onChanged: (value) {
                                setState(() => dataUser.emailUser = value);
                              },
                            ),
                          ),

                          /// Email Password
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: TextFormField(
                              autovalidate: true,
                              style: TextStyle(color: Colors.white),
                              initialValue: dataUser?.passwordUser ?? "",
                              validator: (val) =>
                                  val.length < 6 ? "Password to Short" : null,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(100))),
                              onChanged: (value) {
                                setState(() => dataUser?.passwordUser = value);
                              },
                            ),
                          ),

                          /// Button Action
                          Container(
                            width: double.infinity,
                            height: 50,
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 24),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              textColor: Colors.blue,
                              color: Colors.white,
                              child: Text("Login"),
                              onPressed: () {
                                validateForm();
                              },
                            ),
                          ),
                          FlatButton(
                            textColor: Colors.white,
                            child: Text("I don\'t have an account ?"),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text("Version 1.1",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

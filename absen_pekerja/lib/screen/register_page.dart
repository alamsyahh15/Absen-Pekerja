import 'package:absen_pekerja/model/role_modle.dart';
import 'package:absen_pekerja/model/user_model.dart';
import 'package:absen_pekerja/repository/network_repo.dart';
import 'package:absen_pekerja/utils/constant.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  User userData = User();
  List<DataRole> listRole = [];
  DataRole valueRole;

  void validate() {
    if (formKey.currentState.validate()) {
      register();
    } else {
      showSnackbar("Please check your form");
    }
  }

  void register() {
    progressDialog(context);
    networkRepo.registerUser(userData).then((value){
      Navigator.pop(context);
      if(value != null && value['status'] == 200){
        Navigator.pop(context);
      }else{
        showSnackbar("${value['message']}");
      }
    });
  }

  void showSnackbar(String title) {
    final snackbar = SnackBar(
      content: Text("$title"),
      duration: Duration(seconds: 2),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    networkRepo.getRole().then((value) {
      setState(() {
        if (value != null) {
          listRole = value;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg.png'), fit: BoxFit.cover)),
      child: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.only(top: 30),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/logo.png'),
                    Container(
                      padding: EdgeInsets.only(top: 24),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Full Name",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                            hintStyle:
                                TextStyle(color: Colors.white.withOpacity(0.5)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100))),
                        onChanged: (value) {
                          setState(() => userData.fullnameUser = value);
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "Email",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                            hintStyle:
                                TextStyle(color: Colors.white.withOpacity(0.5)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100))),
                        onChanged: (value) {
                          setState(() => userData.emailUser = value);
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Username",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                            hintStyle:
                                TextStyle(color: Colors.white.withOpacity(0.5)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100))),
                        onChanged: (value) {
                          setState(() => userData.usernameUser = value);
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        autovalidate: true,
                        validator: (val) =>
                            val.length < 6 ? "Password to short" : null,
                        decoration: InputDecoration(
                            hintText: "Password",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                            hintStyle:
                                TextStyle(color: Colors.white.withOpacity(0.5)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100))),
                        onChanged: (value) {
                          setState(() => userData.passwordUser = value);
                        },
                      ),
                    ),
                    DropdownButtonHideUnderline(
                      child: Container(
                        margin: EdgeInsets.only(top: 16),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black87.withOpacity(0.25)),
                            borderRadius: BorderRadius.circular(100)),
                        child: DropdownButton(
                          isExpanded: true,
                          value: valueRole,
                          items: listRole.map((e) {
                            return DropdownMenuItem(
                              child: Text("${e.nameRole}"),
                              value: e,
                            );
                          }).toList(),
                          onChanged: (DataRole value) {
                            setState(() {
                              userData.roleId = value.idRole;
                              valueRole = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      height: 50,
                      width: double.infinity,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        color: Colors.white,
                        textColor: Colors.black87,
                        child: Text("Register"),
                        onPressed: () {
                          validate();
                        },
                      ),
                    ),
                    FlatButton(
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("I have an Account"))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

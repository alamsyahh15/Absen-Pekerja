import 'dart:io';

import 'package:absen_pekerja/repository/network_repo.dart';
import 'package:absen_pekerja/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfile extends StatefulWidget {
  String name, role, email, username;
  UpdateProfile({this.name, this.role, this.email, this.username});
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  File _image;
  var imagePick = ImagePicker();
  void getPicture() async {
    var tempFile = await imagePick.getImage(source: ImageSource.camera);
    if (tempFile != null) {
      setState(() => _image = File(tempFile.path));
    }
  }

  void update() {
    progressDialog(context);
    networkRepo.updateImage(_image).then((val) {
      networkRepo
          .updateProfile(widget.name, widget.email, widget.username)
          .then((value) async {
        Navigator.pop(context);
        if (value != null) {
          Navigator.pop(context);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          setState(() {
            prefs.setString("fullname", widget.name);
            prefs.setString("email", widget.email);
            prefs.setString("username", widget.username);
          });
        } else {
          print("Gagal");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () {
                  getPicture();
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: Stack(
                    children: <Widget>[
                      ClipOval(
                          child: _image != null
                              ? Image.file(_image,
                                  height: 80, width: 80, fit: BoxFit.fill)
                              : Image.network(
                                  "https://www.fairtravel4u.org/wp-content/uploads/2018/06/sample-profile-pic.png",
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.fill,
                                )),
                      Positioned(
                          bottom: 4,
                          right: 4,
                          child:
                              Icon(Icons.camera_enhance, color: Colors.green))
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text("Nama",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600)),
                    ),
                    TextFormField(
                      initialValue: widget?.name ?? "",
                      onChanged: (value) {
                        setState(() => widget.name = value);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 8),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text("Role",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600)),
                    ),
                    TextFormField(
                      initialValue: widget?.role ?? "",
                      onChanged: (value) {
                        setState(() => widget.role = value);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 8),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text("Email",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600)),
                    ),
                    TextFormField(
                      initialValue: widget?.email ?? "",
                      onChanged: (value) {
                        setState(() => widget.email = value);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 8),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text("Username",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600)),
                    ),
                    TextFormField(
                      initialValue: widget?.username ?? "",
                      onChanged: (value) {
                        setState(() => widget.username = value);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                height: 45,
                width: double.infinity,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  textColor: Colors.white,
                  child: Text("Simpan"),
                  color: Colors.green,
                  onPressed: () {
                    update();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

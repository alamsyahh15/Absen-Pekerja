import 'package:absen_pekerja/model/absen_model.dart';
import 'package:absen_pekerja/repository/network_repo.dart';
import 'package:absen_pekerja/screen/home/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListUserPage extends StatefulWidget {
  @override
  _ListUserPageState createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  String email;

  void getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.get("email");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(8),
          child: FutureBuilder(
            future: networkRepo.getAbsen(""),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              } else {
                List<Absen> listData = snapshot.data;
                if (listData != null || email != null) {
                  listData?.removeWhere((e) {
                    if (e != null) {
                      return e.emailUser == email;
                    } else {
                      return false;
                    }
                  });
                }

                return !snapshot.hasData
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: listData?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          Absen data = listData[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfilePage(
                                            dataAbsen: data,
                                            fromPage: "listuser",
                                          )));
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 4),
                              child: Card(
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  child: ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                        "https://www.fairtravel4u.org/wp-content/uploads/2018/06/sample-profile-pic.png",
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    title: Text(data?.fullnameUser ?? ""),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
              }
            },
          ),
        ),
      ),
    );
  }
}

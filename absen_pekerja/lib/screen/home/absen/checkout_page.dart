import 'package:absen_pekerja/model/absen_model.dart';
import 'package:absen_pekerja/repository/network_repo.dart';
import 'package:absen_pekerja/screen/home/absen/detail_user.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: networkRepo.getAbsen(""),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          } else {
            List<Absen> listAbsen = snapshot.data;
            if (listAbsen != null) {
              listAbsen = listAbsen.where((e) {
                if (e?.checkOut == null)
                  return true;
                else
                  return false;
              }).toList();
            }
            return !snapshot.hasData
                ? Center(child: CircularProgressIndicator())
                : Container(
                    padding: EdgeInsets.all(8),
                    child: GridView.builder(
                      itemCount: listAbsen.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 1.0,
                          crossAxisSpacing: 3,
                          childAspectRatio: 0.65),
                      itemBuilder: (BuildContext context, int index) {
                        Absen data = listAbsen[index];
                        return InkWell(
                          onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailUser(dataUser:data)));
                            },
                          child: Card(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 16),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    height: 100,
                                    child: ClipOval(
                                      child: Image.network(
                                        "https://www.fairtravel4u.org/wp-content/uploads/2018/06/sample-profile-pic.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: Text(
                                      data.fullnameUser ?? "",
                                      softWrap: false,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      data.nameRole ?? "",
                                      softWrap: false,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4)),
                                      textColor: Colors.white,
                                      color: Colors.green,
                                      child: Text("Checkout"),
                                      onPressed: () {
                                        networkRepo.checkOut(data);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
          }
        },
      ),
    );
  }
}

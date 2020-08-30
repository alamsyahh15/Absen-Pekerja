import 'package:absen_pekerja/model/history_model.dart';
import 'package:absen_pekerja/repository/network_repo.dart';
import 'package:absen_pekerja/utils/constant.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: FutureBuilder(
          future: networkRepo.getHistory(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            } else {
              List<DataHistory> listData = snapshot.data;
              return !snapshot.hasData
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: listData?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        DataHistory data = listData[index];
                        return Card(
                          elevation: 5,
                          child: Container(
                            margin: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Checkin",
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 12),
                                ),
                                SizedBox(height: 8),
                                Text(dateFormat(data?.checkIn) ?? "-",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(height: 16),
                                Text(
                                  "Check Out",
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 12),
                                ),
                                SizedBox(height: 8),
                                Text(dateFormat(data?.checkOut) ?? "-",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                    );
            }
          },
        ),
      ),
    );
  }
}

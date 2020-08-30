import 'package:absen_pekerja/screen/home/absen/checkin_page.dart';
import 'package:absen_pekerja/screen/home/absen/checkout_page.dart';
import 'package:flutter/material.dart';

class DashboardAbsen extends StatefulWidget {
  @override
  _DashboardAbsenState createState() => _DashboardAbsenState();
}

class _DashboardAbsenState extends State<DashboardAbsen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        bottom: TabBar(
          controller: tabController,
          tabs: <Widget>[
            Tab(child: Text("Check In")),
            Tab(child: Text("Check Out")),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: tabController,
          children: [
            CheckinPage(),
            CheckoutPage(),
          ],
        ),
      ),
    );
  }
}

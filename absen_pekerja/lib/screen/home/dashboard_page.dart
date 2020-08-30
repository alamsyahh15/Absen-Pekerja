import 'package:absen_pekerja/screen/home/profile/profile_page.dart';
import 'package:flutter/material.dart';

import 'absen/dashboard_absen.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
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
      body: SafeArea(
        child: TabBarView(
          controller: tabController,
          children: [
            DashboardAbsen(),
            ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        color: Colors.green,
          child: TabBar(
        controller: tabController,
        tabs: <Widget>[
          Tab(icon: Icon(Icons.home)),
          Tab(icon: Icon(Icons.person))
        ],
      )),
    );
  }
}

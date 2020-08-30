import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String baseUrl = "http://192.168.10.232/server_absen/index.php/Api/";

String dateFormat(DateTime date) {
  if (date != null) {
    return DateFormat("dd/MM/yy hh:mm:ss").format(date);
  } else {
    return "-";
  }
}

progressDialog(BuildContext context) {
  showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black45.withOpacity(0.65),
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) => Center(
            child: CircularProgressIndicator(),
          ));
}

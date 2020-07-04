import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DBservices {
  static FirebaseDatabase database = FirebaseDatabase.instance;
  final DatabaseReference _db = database.reference().child('covid-19');
  DateTime now = DateTime.now();

  Future<DataSnapshot> getTodayWilaya(int numwilaya) {
    String path = DateFormat('yyyy/MM/dd').format(DateTime.now());
    path = "${path}/${numwilaya.toString().padLeft(2, "0")}";
    return _db.child(path).once();
  }

  Future<DataSnapshot> getByDaytWilaya(int numwilaya, String date) {
    //String path = DateFormat('yyyy/MM/dd').format(DateTime.now());
    String path = "$date/${numwilaya.toString().padLeft(2, "0")}";
    return _db.child(path).once();
  }

  Future<Map> gettotalswilayas(int numwilaya) async {
    Map map = {
      "cas": 0,
      "morts": 0,
      "gueris": 0,
    };

    dynamic data = await _db.once();
    Map anmap = data.value;
    anmap.forEach((key, value) {
      Map moismap = value;
      moismap.forEach((key, value) {
        Map jourmap = value;
        jourmap.forEach((key, value) {
          map["cas"] =
              map["cas"] + value[numwilaya.toString().padLeft(2, "0")]["cas"];
          map["morts"] = map["morts"] +
              value[numwilaya.toString().padLeft(2, "0")]["morts"];
          map["gueris"] = map["gueris"] +
              value[numwilaya.toString().padLeft(2, "0")]["gueris"];
        });
      });
    });

    return map;
  }
}

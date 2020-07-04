import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Wilaya {
  String nom_fr;
  String nom_ar;
  int code;
  List polygon = [];
  String type;
  List<Wilaya> multiple = [];

  Wilaya.fromjson(Map data) {
    nom_fr = data["properties"]["name"];
    nom_ar = data["properties"]["name_ar"];
    code = int.parse(data["properties"]["city_code"].toString());
    type = data["geometry"]["type"];
    if (type == "MultiPolygon") {
      List inter = data["geometry"]["coordinates"];
      int i = 0;
      inter.forEach((element) {
        Wilaya wilmul = Wilaya.empty();
        wilmul.nom_fr = "${data["properties"]["name"]}${i}";
        i++;
        wilmul.nom_ar = data["properties"]["name_ar"];
        wilmul.code = int.parse(data["properties"]["city_code"].toString());
        List inter3 = element[0];
        inter3.forEach((element) {
          wilmul.polygon.add(element);
        });
        multiple.add(wilmul);
      });
    } else {
      polygon = data["geometry"]["coordinates"][0];
    }
  }
  Wilaya.empty();

  Set<Polygon> getmultiplepoly(Color _wilayacolor) {
    Set<Polygon> _polygons = {};
    multiple.forEach((element) {
      List<LatLng> _points = [];
      //Wilaya element = _wilayas[30];
      element.polygon.forEach((element) {
        if (!(element[0] is int) && !(element[1] is int)) {
          _points.add(LatLng(element[1], element[0]));
        }
      });
      //print("\n \n \n \n \n \ntaille des points= ${_points.length}\n\n\n\n\n\n");
      _polygons.add(Polygon(
        visible: true,
        polygonId: PolygonId(element.nom_fr),
        points: _points,
        fillColor: _wilayacolor,
        strokeWidth: 1,
      ));
    });
    return (_polygons);
  }
}

Future<List<Wilaya>> getWilayas(BuildContext context) async {
  var _jsonmapdz = null;
  await DefaultAssetBundle.of(context)
      .loadString("assets/geoData.geojson")
      .then((value) => _jsonmapdz = value);
  Map _mapdz = json.decode(_jsonmapdz);
  List _jsonwilayas = _mapdz["features"];
  List<Wilaya> _wilayas = [];
  Set<Polygon> _polygons = {};

  _jsonwilayas.forEach((element) {
    Wilaya wil = Wilaya.fromjson(element);
    _wilayas.add(wil);
  });

  _wilayas.sort((wil1, wil2) {
    //print("wil=${wil1.code} wil2=${wil2.code}");
    return (wil1.code.compareTo(wil2.code));
  });
  return _wilayas;
}

Future<Set> getpolygons(BuildContext context) async {
  var _jsonmapdz =
      await DefaultAssetBundle.of(context).loadString("assets/geoData.geojson");
  Map _mapdz = json.decode(_jsonmapdz);
  List _jsonwilayas = _mapdz["features"];
  List<Wilaya> _wilayas = [];
  Set<Polygon> _polygons = {};

  _jsonwilayas.forEach((element) {
    Wilaya wil = Wilaya.fromjson(element);
    _wilayas.add(wil);
  });

  _wilayas.sort((wil1, wil2) {
    //print("wil=${wil1.code} wil2=${wil2.code}");
    return (wil1.code.compareTo(wil2.code));
  });
  //print(_wilayas[57].code);
  _wilayas.forEach((element) {
    // Wilaya element = _wilayas[30];
    if (element.type == "Polygon") {
      List<LatLng> _points = [];

      element.polygon.forEach((element) {
        if (!(element[0] is int) && !(element[1] is int)) {
          _points.add(LatLng(element[1], element[0]));
        }
      });
      //print("\n \n \n \n \n \ntaille des points= ${_points.length}\n\n\n\n\n\n");
      _polygons.add(Polygon(
        polygonId: PolygonId(element.nom_fr),
        points: _points,
        fillColor: Colors.red,
        strokeWidth: 1,
      ));
    } else {
      _polygons.addAll(element.getmultiplepoly(Colors.red));
    }
  });
  return (_polygons);
}

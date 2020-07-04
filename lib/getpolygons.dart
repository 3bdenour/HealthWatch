import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_test/Models/Wilaya.dart';
import 'package:map_test/Elements/DBservices.dart';

class GeoPolygons {
  static DBservices _db = DBservices();
  Function callback;
  String _typemap;
  Set<Polygon> _polygans = {};
  List<Wilaya> _wilayas;

  GeoPolygons(BuildContext context, Function callbackf, String _date,
      Function initmap) {
    //_onLoading(context);
    getWilayas(context).then((value) {
      _wilayas = value;
      //callbackf();
      mapcas(context, _date).then((value) {
        Navigator.of(context).pop();
        callback();
      });
      callback = callbackf;
      //initmap();
    });
  }
  Set<Polygon> getpoly() {
    return _polygans;
  }

  Color getColorsbycas(int cas) {
    Color couleur;
    if (cas == 0) {
      couleur = Colors.white;
    }
    if ((0 < cas) && (cas < 10)) {
      couleur = Color(0xffffc4b7);
    } else {
      if ((9 < cas) && (cas < 40)) {
        couleur = Color(0xfffba38c);
      } else {
        if ((39 < cas) && (cas < 100)) {
          couleur = Color(0xffed6052);
        } else {
          if ((99 < cas) && (cas < 200)) {
            couleur = Color(0xfff01a48);
          } else {
            if ((199 < cas) && (cas < 500)) {
              couleur = Color(0xffAB7178);
            } else {
              if ((500 < cas) && (cas < 1000)) {
                couleur = Color(0xff87353f);
              } else {
                if ((999 < cas) && (cas < 10000)) {
                  couleur = Color(0xff630606);
                } else {
                  if (cas > 9999) {
                    couleur = Colors.black38;
                  }
                }
              }
            }
          }
        }
      }
    }
    return couleur;
  }

  Future<void> mapcas(context, String date) async {
    //_onLoading(context);
    Set<Polygon> _polygons;
    List<Map> _wilayasinfos = [];
    Map<String, Color> _wilayascolors;
    _wilayascolors = {};
    for (int i = 1; i < 59; i++) {
      Map map = {};
      DataSnapshot data = await _db.getByDaytWilaya(i, date);
      if ((data.value) != null) {
        map.addAll(data.value);
      } else {
        map["cas"] = 0;
      }

      _wilayasinfos.add(map);
      _wilayascolors[i.toString()] = getColorsbycas(map["cas"]);
      if (i == 1) {
        print("\n\n\n\n ${map["cas"]}");
        print(" " + _wilayascolors[i.toString()].toString() + "\n\n\n\n");
      }
      if (i == 58) {
        _polygans =
            getpoylgons(_wilayascolors, _wilayas, _wilayasinfos, context);
        callback();
      }
      //print("\n \n \n test2=" + _polygans.length.toString() + "\n \n \n");

      //_wilayascolors.putIfAbsent(i.toString(),
      //  () => map.isEmpty ? Color(255) : getColorsbycas(map["cas"]));
    }
    //Navigator.pop(context);
  }

  Set<Polygon> getpoylgons(Map<String, Color> _wilayascolors,
      List<Wilaya> _wilayas, List _wilayasinfos, BuildContext context) {
    Set<Polygon> _polygons = {};
    if (_wilayas != null) {
      _wilayas.forEach((wilaya) {
        // Wilaya element = _wilayas[30];
        if (wilaya.type == "Polygon") {
          List<LatLng> _points = [];

          wilaya.polygon.forEach((element) {
            if (!(element[0] is int) && !(element[1] is int)) {
              _points.add(LatLng(element[1], element[0]));
            }
          });
          //print("\n \n \n \n \n \ntaille des points= ${_points.length}\n\n\n\n\n\n");

          _polygons.add(Polygon(
              consumeTapEvents: true,
              polygonId: PolygonId(wilaya.nom_fr),
              points: _points,
              fillColor: _wilayascolors[wilaya.code.toString()],
              strokeWidth: 1,
              onTap: () {
                print("\n\n\n\n yooooooo \n\n\n\n");
                details(context, _wilayasinfos[wilaya.code - 1], wilaya.nom_fr,
                    wilaya.code);
              }));
        } else {
          _polygons.addAll(
              wilaya.getmultiplepoly(_wilayascolors[wilaya.code.toString()]));
        }
      });
    }

    return _polygons;
  }

  details(BuildContext context, Map map, String _wilaya, int numwilaya) async {
    Map maptotal = await _db.gettotalswilayas(numwilaya);
    showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              backgroundColor: Colors.blue[200],
              contentPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * (43 / 375)),
              content: Builder(
                builder: (_) {
                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;

                  return Container(
                    height: height * (450 / 812),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: height * (50 / 812),
                          alignment: Alignment.center,
                          child: Text(
                            _wilaya,
                            style: TextStyle(fontSize: 22),
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                            left: BorderSide(color: Colors.black26, width: 3),
                            right: BorderSide(color: Colors.black26, width: 3),
                            top: BorderSide(color: Colors.black26, width: 3),
                          )),
                        ),
                        Container(
                          width: width * (375 / 375),
                          height: height * (100 / 812),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Container(
                                  width: width * (36 / 375),
                                  height: width * (40 / 375),
                                  child: Image.asset(
                                    "assets/patient.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Nombre de cas",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          maptotal["cas"].toString(),
                                          style: TextStyle(
                                            fontSize: 19,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 4),
                                          child: Text(
                                            "+" + map["cas"].toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26, width: 3),
                          ),
                        ),
                        Container(
                          width: width * (375 / 375),
                          height: height * (100 / 812),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Container(
                                  width: width * (36 / 375),
                                  height: width * (40 / 375),
                                  child: Image.asset(
                                    "assets/death.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Nombre de morts",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          maptotal["morts"].toString(),
                                          style: TextStyle(
                                            fontSize: 19,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 4),
                                          child: Text(
                                            "+" + map["morts"].toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(color: Colors.black26, width: 3),
                              right:
                                  BorderSide(color: Colors.black26, width: 3),
                              bottom:
                                  BorderSide(color: Colors.black26, width: 3),
                            ),
                          ),
                        ),
                        Container(
                          width: width * (375 / 375),
                          height: height * (100 / 812),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Container(
                                  width: width * (36 / 375),
                                  height: width * (40 / 375),
                                  child: Image.asset(
                                    "assets/heart.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Guérison",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          maptotal["gueris"].toString(),
                                          style: TextStyle(
                                            fontSize: 19,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 4),
                                          child: Text(
                                            "+" + map["gueris"].toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(color: Colors.black26, width: 3),
                              right:
                                  BorderSide(color: Colors.black26, width: 3),
                              bottom:
                                  BorderSide(color: Colors.black26, width: 3),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: width * (375 / 375),
                          height: height * (100 / 812),
                          child: map["couvfeu"]["debut"] != ""
                              ? Text("Couvre feu:  " +
                                  map["couvfeu"]["debut"] +
                                  "-" +
                                  map["couvfeu"]["fin"])
                              : Text("Pas de couvre feu établie"),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(color: Colors.black26, width: 3),
                              right:
                                  BorderSide(color: Colors.black26, width: 3),
                              bottom:
                                  BorderSide(color: Colors.black26, width: 3),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ));
  }
}

void _onLoading(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new CircularProgressIndicator(),
            new Text("Loading"),
          ],
        ),
      );
    },
  );
}

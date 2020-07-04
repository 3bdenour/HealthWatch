import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:map_test/Elements/DBservices.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  Map map;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {
              test(context);
            }),
      ),
    );
  }

  test(context) {
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
                            "Boumerdes",
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
                                          "6",
                                          style: TextStyle(
                                            fontSize: 19,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 4),
                                          child: Text(
                                            "+2",
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
                                          "6",
                                          style: TextStyle(
                                            fontSize: 19,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 4),
                                          child: Text(
                                            "+2",
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
                                          "6",
                                          style: TextStyle(
                                            fontSize: 19,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 4),
                                          child: Text(
                                            "+2",
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
                          child: Text("Pas de couvre feu établie"),
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

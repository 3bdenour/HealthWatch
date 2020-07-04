import 'dart:async';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:map_test/getpolygons.dart';
import 'package:flutter/services.dart' show rootBundle;

class Maptest extends StatefulWidget {
  @override
  _MaptestState createState() => _MaptestState();
}

class _MaptestState extends State<Maptest> {
  GoogleMapController _controller;
  String _mapStyle;
  Set<Polygon> _polygons = {};
  GeoPolygons _geoPolygons;
  String _date = "2020/06/30";
  DateTime _initialdate = DateTime(2020, 6, 30);

  void callback() {
    setState(() {});
  }

  void initmap() {
    _geoPolygons.mapcas(context, _date);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    SchedulerBinding.instance.addPostFrameCallback((_) => _onLoading(context));
    _geoPolygons = GeoPolygons(context, callback, _date, initmap);
    //_geoPolygons.mapcas(context, _date);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_geoPolygons != null) {
      _polygons = _geoPolygons.getpoly();
      print("\n \n \n test=" + _polygons.length.toString() + "\n \n \n");
      // setState(() {});
    } else {}
    //print("\n \n \n \n \n \ntaille de poly= ${_polygons.length}\n\n\n\n\n\n");
    //if (_geoPolygons != null) {
    //_polygons = _geoPolygons.mapcas();
    //}
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.none,
            cameraTargetBounds: CameraTargetBounds(LatLngBounds(
              southwest: LatLng(15.950799, -8.789778),
              northeast: LatLng(33.495912, 6.916741),
            )),
            buildingsEnabled: false,
            minMaxZoomPreference: MinMaxZoomPreference(4.8, 8),
            initialCameraPosition:
                CameraPosition(target: LatLng(30.863928, 3.528008), zoom: 4.8),
            polygons: _polygons,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            myLocationButtonEnabled: false,
            onMapCreated: (controller) {
              controller.setMapStyle(_mapStyle);
              // setState(() {});
              _controller = controller;
              //_controller.setMapStyle(mapStyle)
            },
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40, left: 10),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: _initialdate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2021),
                      ).then((value) async {
                        if ((value) != null) {
                          _initialdate = value;
                          _date = DateFormat('yyyy/MM/dd').format(value);
                          _onLoading(context);
                          await _geoPolygons.mapcas(context, _date);
                          Navigator.of(context).pop();
                          setState(() {});
                        }
                      });
                    })),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(_date),
            ),
          )
        ],
      ),
      // Text(_polygons.first == null ? "salut" : _polygons.first.polygonId),
    );
  }
}

void _onLoading(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return new Container(
        child: new Stack(
          children: <Widget>[
            new Container(
              alignment: AlignmentDirectional.center,
              decoration: new BoxDecoration(
                color: Colors.white70,
              ),
              child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: new BorderRadius.circular(10.0)),
                width: 300.0,
                height: 200.0,
                alignment: AlignmentDirectional.center,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Center(
                      child: new SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: new CircularProgressIndicator(
                          value: null,
                          strokeWidth: 7.0,
                        ),
                      ),
                    ),
                    new Container(
                      margin: const EdgeInsets.only(top: 25.0),
                      child: new Center(
                        child: new Text(
                          "loading.. wait...",
                          style:
                              new TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

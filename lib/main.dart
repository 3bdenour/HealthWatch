import 'package:flutter/material.dart';
import './main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (BuildContext context) => AlertPage(),
        '/Map': (BuildContext context) => null,
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    double ScreenW = MediaQuery.of(context).size.width;
    double ScreenH = MediaQuery.of(context).size.height;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: IndexedStack(
          index: _index,
          children: <Widget>[
            AlertPage(),
            Scaffold(), ////// remplaciha b widget ta3ek fi plasset scafold hadi

            //rouji's map zidha hnaaa
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 40, right: 40, bottom: 10),
          child: Container(
              height: ScreenH * 0.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: BottomNavigationBar(
                backgroundColor: Color.fromRGBO(93, 173, 226, 1),
                type: BottomNavigationBarType.fixed,
                iconSize: 30,
                currentIndex: _index,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.report_problem), title: Text('Acceuil')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.map), title: Text('Carte'))
                ],
                onTap: (index) {
                  setState(() {
                    _index = index;
                  });
                },
              )),
        ));
  }
}

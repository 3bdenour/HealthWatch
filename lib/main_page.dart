import 'package:flutter/material.dart';

class AlertPage extends StatefulWidget {
  @override
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  int _index = 0;
  List<Widget> _pages = [
    PageContent(),
    PageContent2(),
    PageContent3()
  ]; ///// les alertes ici !! PageContent()

  List<Widget> _pageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _pages.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 150,
      ),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24 : 16.0,
      decoration: BoxDecoration(
          color: isActive ? Colors.black : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: _pages.length != 0 ? 2 : 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _pages.length != 0
                ? <Widget>[
                    Spacer(),
                    Expanded(
                      flex: 5,
                      child: PageView(
                        children: _pages,
                        controller: _pageController,
                        physics: ClampingScrollPhysics(),
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _pageIndicator(),
                        )),
                  ]
                : [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: <Widget>[
                        Image.asset(
                          "images/nothing.png",
                          height: 130,
                          width: 130,
                        ),
                        Text("Restez en bonne santé!"),
                      ]),
                    ),
                  ],
          ),
        ),
        _pages.length == 0
            ? Expanded(
                child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    MyArticle(),
                    MyArticle(),
                    MyArticle(),
                    MyArticle(),
                    MyArticle(),
                    MyArticle(),
                  ],
                ),
              ))
            : Container(),
        Text(
          "Les anciens épidémies",
          style: TextStyle(color: Colors.white),
        ),
        Expanded(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              MyCard(),
              MyCard2(),
              MyCard(),
              MyCard2(),
            ],
          ),
        ))
      ],
    );
  }
}

class MyCard extends StatelessWidget {
  const MyCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color.fromRGBO(93, 173, 226, 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Image.asset("images/covid.png"),
            Text("Corona", style: TextStyle(color: Color(0xffDA1111))),
          ],
        ),
      ),
    );
  }
}

class MyCard2 extends StatelessWidget {
  const MyCard2({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color.fromRGBO(93, 173, 226, 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Image.asset("images/peste.png"),
            Text(
              "La peste",
              style: TextStyle(color: Color(0xffDA1111)),
            ),
          ],
        ),
      ),
    );
  }
}

class MyArticle extends StatelessWidget {
  const MyArticle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color.fromRGBO(93, 173, 226, 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Image.asset(
                  "images/covid.png",
                )),
            Expanded(
                flex: 2,
                child: Text("Pourquoi manger 5 fruits et légumes par jour ")),
          ],
        ),
      ),
    );
  }
}

class PageContent extends StatelessWidget {
  /* final String title;
  final String subtitle;
  final String imagePath;

  const PageContent({this.title, this.subtitle, this.imagePath});*/

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Image(
            image: AssetImage('images/covid.png'),
            width: 200,
            height: 200,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              Text(
                "Qu'est ce que le COVID-19 ?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "La COVID-19 est la maladie \n infectieuse causée par le dernier \ncoronavirus qui a été découvert.",
                style: TextStyle(fontSize: 15, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class PageContent3 extends StatelessWidget {
  /* final String title;
  final String subtitle;
  final String imagePath;

  const PageContent({this.title, this.subtitle, this.imagePath});*/

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Image(
            image: AssetImage('images/comb.png'),
            width: 130,
            height: 130,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              Text(
                "Quelles sont les procédures\nbarrières ?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Port de la bavette Distance de sécurité (1m) \nEviter les regroupements \nSortir qu'en cas d'urgence ",
                style: TextStyle(fontSize: 14, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class PageContent2 extends StatelessWidget {
  /* final String title;
  final String subtitle;
  final String imagePath;

  const PageContent({this.title, this.subtitle, this.imagePath});*/

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Image(
            image: AssetImage('images/symp.png'),
            width: 200,
            height: 200,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              Text(
                "Quels sont les symptômes ?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Toux sèche\nMaux de tête\nDifficultés respiratoires\nFatigue musculaire",
                style: TextStyle(fontSize: 15, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }
}

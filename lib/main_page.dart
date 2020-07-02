import 'package:flutter/material.dart';

class AlertPage extends StatefulWidget {
  @override
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List<Widget> _pages = []; ///// les alertes ici !! PageContent()

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
                          height: 150,
                          width: 150,
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
        Expanded(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              MyCard(),
              MyCard(),
              MyCard(),
              MyCard(),
              MyCard(),
              MyCard(),
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
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: <Widget>[
            Image.asset("images/covid.png"),
            Text("Corona"),
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
        height: 150,
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10)),
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
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Image(
              image: AssetImage('images/covid.png'),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Text(
                  'Test Test Test',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sollicitudin nibh magna, ac luctus ex aliquet ac. Donec est enim.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

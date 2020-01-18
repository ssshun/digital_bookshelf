import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ja', 'JP'),
      ],
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
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownValue = '評価の高い順';

  final List<IconData> icons = [
    Icons.access_alarm,
    Icons.arrow_back_ios,
    Icons.account_balance_wallet,
    Icons.center_focus_weak,
    Icons.blur_on,
    Icons.dashboard,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Bookshelf'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _headerArea(),
            GridView.count(
              primary: false,
              shrinkWrap: true,
              padding: const EdgeInsets.all(30),
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              crossAxisCount: 2,
              children: <Widget>[
                _content(),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('Heed not the rabble'),
                  color: Colors.teal[200],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('Sound of screams but the'),
                  color: Colors.teal[300],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('Who scream'),
                  color: Colors.teal[400],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('Revolution is coming...'),
                  color: Colors.teal[500],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text('Revolution, they...'),
                  color: Colors.teal[600],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _content() {
    return Card(
      elevation: 4.0,
      child: Container(
        padding:
            EdgeInsets.only(top: 10.0, right: 50.0, bottom: 10.0, left: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _titleArea(),
            _authorArea(),
            _starArea(),
            _imageArea(),
            _readerArea(),
          ],
        ),
      ),
    );
  }

  Widget _titleArea() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Text(
            '説明の順番',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _authorArea() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Text(
            '田中耕比古',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _starArea() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const <Widget>[
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 30.0,
          ),
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 30.0,
          ),
          Icon(
            Icons.star_border,
            size: 30.0,
          ),
          Icon(
            Icons.star_border,
            size: 30.0,
          ),
          Icon(
            Icons.star_border,
            size: 30.0,
          ),
        ],
      ),
    );
  }

  Widget _imageArea() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: CachedNetworkImage(
        imageUrl: "https://picsum.photos/249",
        height: 150.0,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Widget _readerArea() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage('images/droid.jpg'),
          ),
          CircleAvatar(
            backgroundImage: AssetImage('images/gopher.jpg'),
          ),
          CircleAvatar(
            backgroundColor: Colors.brown,
            child: Text('AH'),
          ),
        ],
      ),
    );
  }

  Widget _headerArea() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    "今月のランキング",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(40.0),
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>['評価の高い順', 'レビューの多い順']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Image.asset('images/service_icon.png'),
        ],
      ),
    );
  }
}

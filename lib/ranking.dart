import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:badges/badges.dart';
import 'package:digital_book_shelf/book_list_tile.dart';

class Ranking extends StatefulWidget {
  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _headerArea(),
          _resultArea(),
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

  Widget _resultArea() {
    return Expanded(
      child: StreamBuilder(
        stream: Firestore.instance.collection('books').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('Loading...');
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) {
              String title = snapshot.data.documents[index]['title'];
              String author = snapshot.data.documents[index]['author'];
              String publishDate =
                  snapshot.data.documents[index]['publish_date'];
              String imageURL = snapshot.data.documents[index]['image_url'];
              double rate = snapshot.data.documents[index]['rate'].toDouble();
              String overview = snapshot.data.documents[index]['overview'];

              return Badge(
                badgeContent: Text(
                  "${index + 1}",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                  ),
                ),
                badgeColor: Colors.cyan[800],
                padding: EdgeInsets.all(8.0),
                position: BadgePosition.topLeft(top: 0.0, left: 14.0),
                child: BookListTile(
                  title: title,
                  author: author,
                  publishDate: publishDate,
                  imageURL: imageURL,
                  rate: rate,
                  overview: overview,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

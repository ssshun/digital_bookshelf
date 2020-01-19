import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_book_shelf/book_list_tile.dart';

class SearchResult extends StatefulWidget {
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('検索結果'),
      ),
      body: Column(
        children: <Widget>[
          _headerArea(),
          _resultArea(),
        ],
      ),
    );
  }

  Widget _headerArea() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        children: <Widget>[
          Text(
            '検索結果',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Text(
            '6件がヒットしました。',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
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

              return BookListTile(
                title: title,
                author: author,
                publishDate: publishDate,
                imageURL: imageURL,
                rate: rate,
              );
            },
          );
        },
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
              return _resultCard(context, snapshot.data.documents[index]);
            },
          );
        },
      ),
    );
  }

  Widget _resultCard(BuildContext context, DocumentSnapshot document) {
    return SizedBox(
      width: double.infinity,
      height: 200.0,
      child: Card(
        elevation: 2.0,
        margin:
            EdgeInsets.only(top: 10.0, right: 30.0, bottom: 10.0, left: 30.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _imageArea(document['image_url']),
            _descriptionArea(document),
          ],
        ),
      ),
    );
  }

  Widget _imageArea(String url) {
    return SizedBox(
      width: 200.0,
      child: Center(
        child: CachedNetworkImage(
          imageUrl: url,
          height: 150.0,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _descriptionArea(DocumentSnapshot document) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              document['title'],
              style: TextStyle(fontSize: 24.0),
            ),
            Text(
              "${document['author']}   |   ${document['publish_date']}",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey[600],
              ),
            ),
            _starArea(document['rate'].toDouble()),
          ],
        ),
      ),
    );
  }

  Widget _starArea(double rate) {
    int _starCount = rate.floor();
    int _halfStarCount = rate - rate.floor() - 0.5 >= 0 ? 1 : 0;

    List<Widget> _stars = List.generate(
      _starCount,
      (_) => Icon(
        Icons.star,
        color: Colors.orange,
        size: 30.0,
      ),
    );

    if (_halfStarCount == 1) {
      _stars.add(
        Icon(
          Icons.star_half,
          color: Colors.orange,
          size: 30.0,
        ),
      );
    }

    List<Widget> _noStars = List.generate(
      5 - _starCount - _halfStarCount,
      (_) => Icon(
        Icons.star_border,
        color: Colors.orange,
        size: 30.0,
      ),
    );

    _stars.addAll(_noStars);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: _stars,
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
            '7件がヒットしました。',
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
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return _resultCard(index);
        },
      ),
    );
  }

  Widget _resultCard(int index) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.only(top: 10.0, right: 30.0, bottom: 10.0, left: 30.0),
      child: SizedBox(
        width: double.infinity,
        height: 200.0,
        child: Text(
          '$index',
          style: TextStyle(fontSize: 22.0),
        ),
      ),
    );
  }
}

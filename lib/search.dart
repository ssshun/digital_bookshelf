import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  final _controller4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('検索'),
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 2.0,
          margin: EdgeInsets.only(
              top: 300.0, right: 50.0, bottom: 300.0, left: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _titleArea(),
              _formArea(),
              _buttonArea(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleArea() {
    return Padding(
      padding: EdgeInsets.all(50.0),
      child: Row(
        children: <Widget>[
          Text(
            '検索',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _formArea() {
    return Column(
      children: <Widget>[
        _formRowArea1(),
        _formRowArea2(),
        _formRowArea3(),
      ],
    );
  }

  Widget _formRowArea1() {
    return Padding(
      padding:
          EdgeInsets.only(top: 10.0, right: 100.0, bottom: 10.0, left: 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 530,
            child: TextField(
              onSubmitted: getSearchedArticles,
              controller: _controller1,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 5.0),
                labelText: "書籍タイトル",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formRowArea2() {
    return Padding(
      padding:
          EdgeInsets.only(top: 10.0, right: 100.0, bottom: 10.0, left: 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 530,
            child: TextField(
              onSubmitted: getSearchedArticles,
              controller: _controller2,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 5.0),
                labelText: "著者名",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formRowArea3() {
    return Padding(
      padding:
          EdgeInsets.only(top: 10.0, right: 100.0, bottom: 10.0, left: 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 250,
            child: TextField(
              onSubmitted: getSearchedArticles,
              controller: _controller3,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 5.0),
                labelText: "ジャンル",
              ),
            ),
          ),
          Container(
            width: 250,
            child: TextField(
              onSubmitted: getSearchedArticles,
              controller: _controller4,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 5.0),
                labelText: "キーワード",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future getSearchedArticles(String keywords) async {}

  Widget _buttonArea() {
    return Padding(
      padding: EdgeInsets.all(50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            child: Text("クリア"),
            color: Colors.grey[300],
            shape: StadiumBorder(),
            onPressed: () {},
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          FlatButton(
            child: Text("検索"),
            color: Colors.orange,
            shape: StadiumBorder(),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

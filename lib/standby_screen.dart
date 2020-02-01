import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:digital_book_shelf/home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StandbyScreen extends StatefulWidget {
  @override
  _StandbyScreenState createState() => _StandbyScreenState();
}

class _StandbyScreenState extends State<StandbyScreen> {
  List<String> _imageURLs = [];
  String _imageURL = "";

  @override
  void initState() {
    super.initState();
    _rotateImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            );
          },
          child: Container(
            constraints: BoxConstraints.expand(),
            child: CachedNetworkImage(
              imageUrl: _imageURL,
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  _rotateImages() {
    Firestore.instance.collection('books').limit(6).snapshots().listen((data) {
      List _list = data.documents.map((doc) => doc["image_url"]).toList();
      _imageURLs = _list;
      _imageURL = _imageURLs[0];

      Timer.periodic(
        Duration(seconds: 60),
        _changeImage,
      );
    });
  }

  _changeImage(Timer timer) {
    final _now = DateTime.now();
    int index = _now.minute % 6;

    setState(() {
      _imageURL = _imageURLs[index];
    });
  }
}

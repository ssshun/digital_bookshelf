import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:digital_book_shelf/home.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StandbyScreen extends StatefulWidget {
  @override
  _StandbyScreenState createState() => _StandbyScreenState();
}

class _StandbyScreenState extends State<StandbyScreen> {
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
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/digital-bookshelf-9da55.appspot.com/o/book_image%2F1.jpg?alt=media&token=faa961c8-4272-4515-b0d7-e32a8e6578d2',
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

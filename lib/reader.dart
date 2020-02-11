import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:digital_book_shelf/reputation_list_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Reader extends StatelessWidget {
//  Reader({
//    Key key,
//    this.title,
//    this.author,
//    this.publishDate,
//    this.imageURL,
//    this.rate,
//    this.overview,
//  }) : super(key: key);
//
//  final String title;
//  final String author;
//  final String publishDate;
//  final String imageURL;
//  final double rate;
//  final String overview;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('書籍リーダー'),
      ),
      body: Center(
        child: Text('center'),
      ),
    );
  }
}

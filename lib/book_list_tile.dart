import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BookListTile extends StatelessWidget {
  BookListTile({
    Key key,
    this.title,
    this.author,
    this.publishDate,
    this.imageURL,
    this.rate,
  }) : super(key: key);

  final String title;
  final String author;
  final String publishDate;
  final String imageURL;
  final double rate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200.0,
      child: Card(
        elevation: 2.0,
        margin:
            EdgeInsets.only(top: 20.0, right: 30.0, bottom: 0.0, left: 30.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _imageArea(imageURL),
            _descriptionArea(title, author, publishDate, rate),
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

  Widget _descriptionArea(
      String title, String author, String publishDate, double rate) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 24.0),
            ),
            Text(
              "$author   |   $publishDate",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey[600],
              ),
            ),
            _starArea(rate),
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

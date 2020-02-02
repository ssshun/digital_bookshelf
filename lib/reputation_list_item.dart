import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ReputationListItem extends StatelessWidget {
  ReputationListItem({
    this.name,
    this.department,
    this.position,
    this.thumbnail,
    this.rate,
  });

  final String name;
  final String department;
  final String position;
  final String thumbnail;
  final double rate;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal[50],
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(thumbnail),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: _UserDescription(
                  name: name,
                  department: department,
                  position: position,
                  rate: rate,
                ),
              ),
            ],
          ),
          Expanded(
            child: _starArea(rate),
          ),
        ],
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: _stars,
      ),
    );
  }
}

class _UserDescription extends StatelessWidget {
  _UserDescription({
    Key key,
    this.name,
    this.department,
    this.position,
    this.rate,
  }) : super(key: key);

  final String name;
  final String department;
  final String position;
  final double rate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            department,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            position,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

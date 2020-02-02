import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:digital_book_shelf/reputation_list_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BookDetail extends StatelessWidget {
  BookDetail({
    Key key,
    this.title,
    this.author,
    this.publishDate,
    this.imageURL,
    this.rate,
    this.overview,
  }) : super(key: key);

  final String title;
  final String author;
  final String publishDate;
  final String imageURL;
  final double rate;
  final String overview;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('書籍詳細'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _bookDetailArea(context),
          Expanded(
            child: Container(
              height: double.infinity,
              child: _reputationArea(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookDetailArea(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _imageArea(),
            _descriptionArea(),
          ],
        ),
        _divider(),
        _overviewArea(context),
        _divider(),
      ],
    );
  }

  Widget _imageArea() {
    return SizedBox(
      width: 300.0,
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: CachedNetworkImage(
          imageUrl: imageURL,
          height: 300.0,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _descriptionArea() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 36.0),
            ),
            Text(
              author,
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.grey[600],
              ),
            ),
            Text(
              publishDate,
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _overviewArea(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            '概要',
            style: TextStyle(
              fontSize: 28,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            overview,
            style: TextStyle(
              fontSize: 20,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: FlatButton(
              child: Text(
                "続きを読む",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              color: Colors.orange[300],
              shape: StadiumBorder(),
              onPressed: () {
                _showOverview(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  _showOverview(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("概要"),
          content: Text(
            overview,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "閉じる",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              color: Colors.grey[300],
              shape: StadiumBorder(),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Widget _reputationArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'レビュー',
            style: TextStyle(
              fontSize: 28,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: <Widget>[
              _starArea(rate),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  '$rate点',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            height: double.infinity,
            child: StaggeredGridView.count(
              padding: EdgeInsets.all(20.0),
              crossAxisCount: 6,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
              children: <Widget>[
                ReputationListItem(
                  name: '山田 太郎',
                  department: '経営',
                  position: 'CEO',
                  thumbnail: 'https://randomuser.me/api/portraits/men/3.jpg',
                  rate: 4.6,
                ),
                ReputationListItem(
                  name: '小早川 省吾',
                  department: '営業本部',
                  position: 'セールス',
                  thumbnail: 'https://randomuser.me/api/portraits/men/4.jpg',
                  rate: 4.3,
                ),
                ReputationListItem(
                  name: '本澤 聖一',
                  department: '開発本部',
                  position: 'カスタマーサクセス',
                  thumbnail: 'https://randomuser.me/api/portraits/men/5.jpg',
                  rate: 3.7,
                ),
                ReputationListItem(
                  name: '森上 敦夫',
                  department: '営業本部',
                  position: 'フィールドセールス',
                  thumbnail: 'https://randomuser.me/api/portraits/men/8.jpg',
                  rate: 3.2,
                ),
                ReputationListItem(
                  name: '森内 しずか',
                  department: '開発本部',
                  position: 'デザイナー',
                  thumbnail: 'https://randomuser.me/api/portraits/women/1.jpg',
                  rate: 3.0,
                ),
                ReputationListItem(
                  name: '権東 東一郎',
                  department: '開発本部',
                  position: 'エンジニア',
                  thumbnail: 'https://randomuser.me/api/portraits/men/6.jpg',
                  rate: 1.5,
                ),
              ],
              staggeredTiles: <StaggeredTile>[
                StaggeredTile.count(2, 1.5),
                StaggeredTile.count(2, 1.5),
                StaggeredTile.count(2, 1.5),
                StaggeredTile.count(2, 1.5),
                StaggeredTile.count(2, 1.5),
                StaggeredTile.count(2, 1.5),
              ],
            ),
          ),
        ),
      ],
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

  Widget _divider() {
    return Divider(
      color: Colors.grey[400],
      indent: 20.0,
      endIndent: 20.0,
    );
  }
}

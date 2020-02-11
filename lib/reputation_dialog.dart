import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ReputationDialog extends StatelessWidget {
  ReputationDialog({
    this.name,
    this.department,
    this.position,
    this.thumbnail,
    this.reputationDescription,
  });

  final String name, department, position, thumbnail, reputationDescription;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: _dialogContent(context),
    );
  }

  _dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        _bottomCard(context),
        _userImage(),
      ],
    );
  }

  Widget _bottomCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: Consts.avatarRadius + Consts.padding,
        bottom: Consts.padding,
        left: Consts.padding,
        right: Consts.padding,
      ),
      margin: EdgeInsets.only(top: Consts.avatarRadius),
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(Consts.padding),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.grey,
            ),
          ),
          Text(
            '$department $position',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            reputationDescription,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).pop(); // To close the dialog
              },
              child: Text('閉じる'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _userImage() {
    return Positioned(
      left: Consts.padding,
      right: Consts.padding,
      child: CircleAvatar(
        child: ClipOval(
          child: Image.network(thumbnail),
        ),
        radius: Consts.avatarRadius,
      ),
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

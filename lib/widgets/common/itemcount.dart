import 'package:flutter/material.dart';

class ItemBadgeIcon extends StatelessWidget {
  final String count;

  ItemBadgeIcon({required this.count});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
     ImageIcon(   AssetImage("assets/bag.png"),size: 23,),
        Positioned(
          top: 0,
          right: 0,
          child: count == "0"
              ? Container()
              : Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: BoxConstraints(
              minWidth: 12,
              minHeight: 12,
            ),
            child: Text(
              count,
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

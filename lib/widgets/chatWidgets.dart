import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

//class DayViewer extends StatelessWidget {
//  final String day;
//
//  DayViewer({this.day});
//
//  @override
//  Widget build(BuildContext context) {
//    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
//    double px = 1 / pixelRatio;
//    return Bubble(
//      alignment: Alignment.center,
//      color: Color.fromARGB(255, 212, 234, 244),
//      elevation: 1 * px,
//      margin: BubbleEdges.only(top: 8.0),
//      child: Text(
//        day,
//        style: TextStyle(
//          color: Colors.black,
//          fontSize: 10.0,
//          fontFamily: 'beINNormal',
//        ),
//      ),
//    );
//  }
//}

//------------------------------------------------------------------------------
class MessageViewer extends StatelessWidget {
  final String type;
  final String content;
  final String date;

  MessageViewer({this.content, this.type, this.date});

  @override
  Widget build(BuildContext context) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double px = 1 / pixelRatio;

    BubbleStyle styleMe = BubbleStyle(
      nip: BubbleNip.rightTop,
      color: Color.fromARGB(255, 225, 255, 199),
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, left: 50.0),
      alignment: Alignment.topRight,
    );
    BubbleStyle styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Colors.white,
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, right: 50.0),
      alignment: Alignment.topLeft,
    );
    return type == 'me'
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Bubble(
                elevation: 3.0,
                style: styleMe,
                child: Text(
                  content,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontFamily: 'beINNormal',
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                  fontFamily: 'beINNormal',
                ),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Bubble(
                elevation: 3.0,
                style: styleSomebody,
                child: Text(
                  content,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontFamily: 'beINNormal',
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                  fontFamily: 'beINNormal',
                ),
              ),
            ],
          );
  }
}

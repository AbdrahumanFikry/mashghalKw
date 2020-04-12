import 'package:flutter/material.dart';

class GeneralDialog extends StatelessWidget {
  final String content;
  final Function toDOFunction;

  GeneralDialog({@required this.content, @required this.toDOFunction});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      contentPadding: const EdgeInsets.all(0.0),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(104, 57, 120, 10),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
              ),
              child: Text(
                '! اخطار',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'beINNormal',
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            //---------------------------Body-----------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: Text(
                content,
                style: TextStyle(
                  color: Color.fromRGBO(104, 57, 120, 10),
                  fontFamily: 'beINNormal',
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            //--------------------------ratingBar-------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                    toDOFunction();
                  },
                  child: Text(
                    'نعم',
                    style: TextStyle(
                      color: Color.fromRGBO(104, 57, 120, 10),
                      fontFamily: 'beINNormal',
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'لا',
                    style: TextStyle(
                      color: Color.fromRGBO(104, 57, 120, 10),
                      fontFamily: 'beINNormal',
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

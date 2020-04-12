import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackwardWidget extends StatelessWidget {
  final bool check;

  const BackwardWidget({Key key, this.check = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      width: double.infinity,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 45.0,
              ),
              onPressed: () {
                if(check)
                  SharedPreferences.getInstance().then((p){
                    p.clear();
                    Navigator.of(context).pop();
                  });
                else
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }
}

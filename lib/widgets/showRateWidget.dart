import 'package:flutter/material.dart';
import 'package:mashghal_co/widgets/loader.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../providers/notificationProvider.dart';

class ShowRateWidget extends StatefulWidget {
  final int id;

  ShowRateWidget({this.id});

  @override
  _ShowRateWidgetState createState() => _ShowRateWidgetState();
}

class _ShowRateWidgetState extends State<ShowRateWidget> {
  //-------------------------------variables------------------------------------
  var rating = 0.0;
  bool _isLoading = false;

  //-------------------------------methods--------------------------------------
   void _addRate() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Notifications>(context, listen: false)
        .addRate(widget.id, rating);
    Navigator.of(context).pop();
    setState(() {
      _isLoading = false;
    });
  }

  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    print(':::::::::::::::::::::::::::::::rateScreen');

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
                'تقييم الخدمة',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'beINNormal',
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            //--------------------------ratingBar-------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: SmoothStarRating(
                  allowHalfRating: true,
                  onRatingChanged: (v) {
                    rating = v;
                    setState(() {});
                  },
                  starCount: 5,
                  rating: rating,
                  size: 40.0,
                  color: Color.fromRGBO(104, 57, 120, 10),
                  borderColor: Color.fromRGBO(104, 57, 120, 10),
                  spacing: 0.0,
                ),
              ),
            ),
            //------------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 75.0,
              ),
              child: _isLoading
                  ? Center(
                      child: ColorLoader(
                        radius: 9.0,
                        dotRadius: 2.0,
                      ),
                    )
                  : FlatButton(
                      onPressed: _addRate,
                      child: Text(
                        'تقييم',
                        style: TextStyle(
                          color: Color.fromRGBO(104, 57, 120, 10),
                          fontFamily: 'beINNormal',
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

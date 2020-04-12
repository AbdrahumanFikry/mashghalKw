import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String isOffer;
  final String title;
  final String image;

  CategoryItem({this.isOffer, this.title, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 150,
      margin: const EdgeInsets.only(
          top: 15.0, bottom: 15.0, left: 15.0, right: 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: isOffer == 'yes'
              ? AssetImage('assets/images/offer.jpg')
              : NetworkImage('https://mashghllkw.com/cdn/' + image),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 30.0,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0)),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontFamily: 'beINNormal',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

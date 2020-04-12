import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final String userName;
  final String date;
  final String time;
  final String serviceName;
  final String image;

  OrderCard(
      {this.userName, this.date, this.serviceName, this.image, this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.0,
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 5.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          15.0,
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(5.0, 5.0),
            blurRadius: 20.0,
            spreadRadius: 3.0,
          ),
        ],
      ),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 40.0,
            backgroundImage:
                NetworkImage('https://mashghllkw.com/cdn/' + image),
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                userName,
                style: TextStyle(
                  color: Color.fromRGBO(104, 57, 120, 10),
                  fontSize: 16.0,
                  fontFamily: 'beINNormal',
                ),
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                    color: Color.fromRGBO(104, 57, 120, 10),
                    size: 16.0,
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                      fontFamily: 'beINNormal',
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Icon(
                    Icons.watch_later,
                    color: Color.fromRGBO(104, 57, 120, 10),
                    size: 16.0,
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                      fontFamily: 'beINNormal',
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.credit_card,
                    color: Color.fromRGBO(104, 57, 120, 10),
                    size: 16.0,
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  Text(
                    serviceName,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                      fontFamily: 'beINNormal',
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/orderModel.dart';

class OrderRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final service = Provider.of<Services>(context).userService;
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 6.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                service.type,
                style: TextStyle(
                  color: Color.fromRGBO(104, 57, 120, 10),
                  fontSize: 20.0,
                  fontFamily: 'beINNormal',
                ),
              ),
              SizedBox(
                width: 25.0,
              ),
              Image.asset(
                'assets/icons/funds.png',
                fit: BoxFit.cover,
                color: Color.fromRGBO(104, 57, 120, 10),
              ),
              SizedBox(
                width: 10.0,
              ),
              service.status == 0
                  ? Text(
                      service.price,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.0,
                        fontFamily: 'beINNormal',
                      ),
                    )
                  : Text(
                      service.offer,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.0,
                        fontFamily: 'beINNormal',
                      ),
                    ),
            ],
          ),
          //--------------------------------------------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.calendar_today,
                color: Color.fromRGBO(104, 57, 120, 10),
                size: 20.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                service.createdAt.split(' ')[0],
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18.0,
                  fontFamily: 'beINNormal',
                ),
              ),
            ],
          ),
          //--------------------------------------------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.alarm,
                color: Color.fromRGBO(104, 57, 120, 10),
                size: 20.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                service.createdAt.split(' ')[1],
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18.0,
                  fontFamily: 'beINNormal',
                ),
              ),
            ],
          ),
          //--------------------------------------------------------------------
          Container(
            color: Colors.grey[200],
            height: 1.0,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}

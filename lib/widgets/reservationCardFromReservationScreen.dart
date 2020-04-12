import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/generalAlertDialog.dart';
import '../providers/reservationsProvider.dart';
import '../widgets/showRateWidget.dart';

class ReservationCard extends StatelessWidget {
  final int id;
  final String type;
  final String title;
  final String image;
  final String dateTime;
  final String price;

  ReservationCard(
      {this.id, this.title, this.image, this.dateTime, this.price, this.type});

  //------------------------------methods---------------------------------------
  Future<void> _showRate(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ShowRateWidget(id: id,);
        });
  }

  void _deleteReservation(BuildContext context) async {
    await Provider.of<Reservations>(context, listen: false)
        .deleteReservation(id, type);
    await Provider.of<Reservations>(context).fetchReservations('');
  }

  Future<void> _showConfirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return GeneralDialog(
            content: 'هل بالفعل تريد حذف هذا الحجز ؟',
            toDOFunction: () => _deleteReservation(context),
          );
        });
  }

  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    print(':::::::::::::::::::::::::::::::rescardScreen');

    return Container(
      width: double.infinity,
      height: 105,
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 2.5,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 3.0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 90,
            height: 90,
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage('https://mashghllkw.com/cdn/' + image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: Color.fromRGBO(104, 57, 120, 10),
                  fontSize: 12.0,
                  fontFamily: 'beINNormal',
                ),
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.alarm,
                    size: 16.0,
                    color: Color.fromRGBO(104, 57, 120, 10),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    dateTime,
                    style: TextStyle(
                      color: Color.fromRGBO(104, 57, 120, 10),
                      fontSize: 12.0,
                      fontFamily: 'beINNormal',
                    ),
                  ),
//                  SizedBox(
//                    width: 5.0,
//                  ),
//                  Text(
//                    '9:30 pm',
//                    style: TextStyle(
//                      color: Color.fromRGBO(104, 57, 120, 10),
//                      fontSize: 12.0,
//                      fontFamily: 'beINNormal',
//                    ),
//                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.attach_money,
                    size: 16.0,
                    color: Color.fromRGBO(104, 57, 120, 10),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    price,
                    style: TextStyle(
                      color: Color.fromRGBO(104, 57, 120, 10),
                      fontSize: 12.0,
                      fontFamily: 'beINNormal',
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Column(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.cancel,
                  size: 16.0,
                  color: Color.fromRGBO(104, 57, 120, 10),
                ),
                onPressed: () => _showConfirmDialog(context),
              ),
              type == 'finished'
                  ? InkWell(
                      onTap: () => _showRate(context),
                      child: Text(
                        'تقييم',
                        style: TextStyle(
                          color: Color.fromRGBO(104, 57, 120, 10),
                          fontSize: 16.0,
                          fontFamily: 'beINNormal',
                        ),
                      ),
                    )
                  : Container(),
            ],
          )
        ],
      ),
    );
  }
}

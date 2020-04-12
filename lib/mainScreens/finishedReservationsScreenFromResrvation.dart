import 'package:flutter/material.dart';
import '../widgets/reservationCardFromReservationScreen.dart';
import 'package:provider/provider.dart';
import '../providers/reservationsProvider.dart';

class FinishedReservations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 10.0,
        ),
        height: double.infinity,
        color: Colors.white,
        child: Consumer<Reservations>(
          builder: (context, res, child) => res.finishedOrders.isEmpty
              ? Center(
                  child: Text(
                    'لا يوجد لديك اى حجوزات منتهيه',
                    style: TextStyle(
                      fontFamily: 'beINNormal',
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: res.finishedOrders.length + 1,
                  itemBuilder: (context, index) {
                    return index != res.finishedOrders.length
                        ? ReservationCard(
                            id: res.finishedOrders[index].id,
                            title: res.finishedOrders[index].username,
                            image: res.finishedOrders[index].userImage,
                            dateTime: res.finishedOrders[index].createdAt.date
                                .split(' ')[0],
                            price: res.finishedOrders[index].totalPrice,
                            type: 'finished',
                          )
                        : SizedBox(
                            height: 90.0,
                          );
                  },
                ),
        ),
      ),
    );
  }
}

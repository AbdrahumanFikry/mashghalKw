import 'package:flutter/material.dart';
import 'package:mashghal_co/providers/reservationsProvider.dart';
import 'package:provider/provider.dart';
import '../widgets/reservationCardFromReservationScreen.dart';

class CurrentReservationScreen extends StatelessWidget {
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
          builder: (context, res, child) => res.initOrders.isEmpty
              ? Center(
                  child: Text(
                    'لا يوجد لديك اى حجوزات حاليه',
                    style: TextStyle(
                      fontFamily: 'beINNormal',
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: res.initOrders.length + 1,
                  itemBuilder: (context, index) {
                    return index != res.initOrders.length
                        ? ReservationCard(
                            id: res.initOrders[index].id,
                            title: res.initOrders[index].username,
                            image: res.initOrders[index].userImage,
                            dateTime: res.initOrders[index].createdAt.date.split(' ')[0],
                            price: res.initOrders[index].totalPrice,
                      type: 'init',
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

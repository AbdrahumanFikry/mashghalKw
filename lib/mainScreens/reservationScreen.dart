import 'package:flutter/material.dart';
import 'package:mashghal_co/widgets/loader.dart';
import 'package:provider/provider.dart';
import '../mainScreens/currentReservationsScreenFromReservation.dart';
import '../mainScreens/finishedReservationsScreenFromResrvation.dart';
import '../providers/reservationsProvider.dart';

class ReservationScreen extends StatelessWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'reservationScreen';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(235, 218, 241, 10),
          title: Text(
            'الحجوزات',
            style: TextStyle(
              color: Color.fromRGBO(104, 57, 120, 10),
              fontSize: 20.0,
              fontFamily: 'beINNormal',
            ),
          ),
          leading: new Container(),
        ),
        body: DefaultTabController(
          length: 2,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 65,
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 10.0,
                  ),
                  decoration: new BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: new TabBar(
                    tabs: [
                      new Tab(
                        child: Text(
                          'الحجوزات الحالية',
                          style: TextStyle(
                            color: Color.fromRGBO(104, 57, 120, 10),
                            fontSize: width < 350 ? 16.0 : 18.0,
                            fontFamily: 'beINNormal',
                          ),
                        ),
                      ),
                      new Tab(
                        child: Text(
                          'الحجوزات المنتهية',
                          style: TextStyle(
                            color: Color.fromRGBO(104, 57, 120, 10),
                            fontSize: width < 350 ? 14.0 : 16.0,
                            fontFamily: 'beINNormal',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //--------------------------TabsView----------------------------
                FutureBuilder(
                  future: Provider.of<Reservations>(context, listen: false)
                      .fetchReservations(''),
                  builder: (context, dataSnapShot) {
                    if (dataSnapShot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: ColorLoader(
                          radius: 15.0,
                          dotRadius: 5.0,
                        ),
                      );
                    } else {
                      if (dataSnapShot.error != null) {
                        return Center(
                          child: Text(
                            'تحقق من اتصالك بالانترنت' ,
                            style: TextStyle(
                              fontFamily: 'beINNormal',
                              color: Colors.grey,
                              fontSize: 16.0,
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          height: MediaQuery.of(context).size.height - 180,
                          child: TabBarView(
                            children: <Widget>[
                              //--------------------الحجوزات الحالية------------
                              CurrentReservationScreen(),
                              //-------------------الحجوزات المنتهية------------
                              FinishedReservations(),
                            ],
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mashghal_co/widgets/loader.dart';
import 'package:provider/provider.dart';
import '../widgets/categoryViewFromDateTimeScreen.dart';
import '../widgets/showBillWidget.dart';
import '../providers/reservationsProvider.dart';
import '../models/serviceModel.dart';

class DateTimeScreen extends StatefulWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'dateandtimeScreen';

  @override
  _DateTimeScreenState createState() => _DateTimeScreenState();
}

class _DateTimeScreenState extends State<DateTimeScreen> {
   Future<void> _showBill(var total, List arr, List<ServicesIds> ids,int ownerId) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ShowBillWidget(total: total, list: arr,ids: ids,ownerId: ownerId);
        });
  }

  //-------------------------------build-----------------------------------------
  @override
  Widget build(BuildContext context) {
    print(':::::::::::::::::::::::::::::::dateTimeScreen');

    final item = ModalRoute
        .of(context)
        .settings
        .arguments as Map;
    final ids = item['ids'];
    List<ServicesIds> orderIds = [...ids];
    final type = item['type'];
    final total = item['total'];
    final list = item['list'];
    List arr = [...list];
    final id = item['id'];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(235, 218, 241, 10),
          title: Text(
            'الوقت والتاريخ',
            style: TextStyle(
              color: Color.fromRGBO(104, 57, 120, 10),
              fontSize: 20.0,
              fontFamily: 'beINNormal',
            ),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color.fromRGBO(104, 57, 120, 10),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: FutureBuilder(
          future:
          Provider.of<Reservations>(context, listen: false).fetchDays(id),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: ColorLoader(
                  radius: 15.0,
                  dotRadius: 5.0,
                ),
              );
            } else {
              if (snapShot.error != null) {
                return Center(
                  child: Text(
                    'تحقق من اتصالك بالانترنت',
                    style: TextStyle(
                      fontFamily: 'beINNormal',
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                );
              }
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return CategoryViewWidget(
                            index: index,
                            title: list[index].type,
                            price: type != 'offer'
                                ? list[index].price
                                : list[index].offer,
                          );
                        },
                      ),
                    ),
                  ),
                  //------------------------Reserve$Save------------------------------
                  GestureDetector(
                    onTap: () => _showBill(total, arr, orderIds,id),
                    child: Container(
                      height: 70,
                      width: double.infinity,
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(104, 57, 120, 10),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Center(
                          child: Text(
                            'مجموع المبلغ  ' +
                                total.toString() +
                                '  القيام بالحجز',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'beINNormal',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

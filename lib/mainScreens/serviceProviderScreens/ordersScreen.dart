import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../serviceProviderScreens/newOrdersScreen.dart';
import '../serviceProviderScreens/confirmedOrdersScreen.dart';
import '../serviceProviderScreens/finishedOrdersScreen.dart';
import '../../providers/ordersProvider.dart';
import '../../models/httpException.dart';
import '../../widgets/loader.dart';

class OrderScreen extends StatefulWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'ordersScreen';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  //-----------------------------variables--------------------------------------
  List<Object> _pages;
  int nIndex = 0;
  DateTime selectedDate = DateTime.now() ;

  //------------------------------methods---------------------------------------
  void initState() {
    _pages = [
      /*******Screens*******/
      NewOrdersScreen(),
      ConfirmedOrdersScreen(),
      FinishedOrdersScreen(),
    ];
    super.initState();
  }

  Future<void> _selectDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    try {
//      await Provider.of<OrdersProvider>(context)
//          .dateFilter(selectedDate.toString().split(' ')[0]);
    } on HttpException catch (error) {
      var errorMessage = 'لا يوجد طلبات لهذا التاريخ';
      if (error.toString().contains('not found')) {
        errorMessage = 'ا يوجد طلبات لهذا التاريخ';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'لا يوجد طلبات لهذا التاريخ';
      _showErrorDialog(errorMessage);
    }
  }

  //---------------------------errorDialog--------------------------------------
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
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
                  '! اخطار',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'beINNormal',
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              //---------------------------Body-----------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'beINNormal',
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              //--------------------------ratingBar-------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'حاول مره اخرى',
                      style: TextStyle(
                        color: Color.fromRGBO(104, 57, 120, 10),
                        fontFamily: 'beINNormal',
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    double containerSize = MediaQuery.of(context).size.width * 0.25;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(235, 218, 241, 10),
          title: Text(
            'الطلبات',
            style: TextStyle(
              color: Color.fromRGBO(104, 57, 120, 10),
              fontSize: 20.0,
              fontFamily: 'beINNormal',
            ),
          ),
          leading: new Container(),
          actions: <Widget>[
            IconButton(
              icon: Image.asset(
                'assets/icons/calendar.png',
                fit: BoxFit.cover,
              ),
              onPressed: _selectDate,
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 80,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          nIndex = 0;
                        });
                      },
                      child: Container(
                        width: containerSize,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            40.0,
                          ),
                          border: Border.all(
                            width: 1.0,
                            color: Color.fromRGBO(104, 57, 120, 10),
                          ),
                          color: nIndex != 0
                              ? Colors.white
                              : Color.fromRGBO(104, 57, 120, 10),
                        ),
                        child: Center(
                          child: Text(
                            'الجديده',
                            style: TextStyle(
                              color: nIndex == 0
                                  ? Colors.white
                                  : Color.fromRGBO(104, 57, 120, 10),
                              fontSize: 16.0,
                              fontFamily: 'beINNormal',
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          nIndex = 1;
                        });
                      },
                      child: Container(
                        width: containerSize,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            40.0,
                          ),
                          border: Border.all(
                            width: 1.0,
                            color: Color.fromRGBO(104, 57, 120, 10),
                          ),
                          color: nIndex != 1
                              ? Colors.white
                              : Color.fromRGBO(104, 57, 120, 10),
                        ),
                        child: Center(
                          child: Text(
                            'المؤكده',
                            style: TextStyle(
                              color: nIndex == 1
                                  ? Colors.white
                                  : Color.fromRGBO(104, 57, 120, 10),
                              fontSize: 16.0,
                              fontFamily: 'beINNormal',
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          nIndex = 2;
                        });
                      },
                      child: Container(
                        width: containerSize,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            40.0,
                          ),
                          border: Border.all(
                            width: 1.0,
                            color: Color.fromRGBO(104, 57, 120, 10),
                          ),
                          color: nIndex != 2
                              ? Colors.white
                              : Color.fromRGBO(104, 57, 120, 10),
                        ),
                        child: Center(
                          child: Text(
                            'المنتهيه',
                            style: TextStyle(
                              color: nIndex == 2
                                  ? Colors.white
                                  : Color.fromRGBO(104, 57, 120, 10),
                              fontSize: 16.0,
                              fontFamily: 'beINNormal',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: Provider.of<OrdersProvider>(context, listen: false)
                          .fetchAdvertiserInitOrders(
                      selectedDate),
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
                            'تحقق من اتصالك بالانترنت',
                            style: TextStyle(
                              fontFamily: 'beINNormal',
                              color: Colors.grey,
                              fontSize: 16.0,
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          color: Colors.white,
                          child: _pages[nIndex],
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

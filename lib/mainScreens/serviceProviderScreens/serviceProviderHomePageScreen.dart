import 'package:flutter/material.dart';
import '../myWorksScreenFromDetails.dart';
import '../serviceProviderScreens/offersScreenFromSPHomePage.dart';
import '../serviceProviderScreens/serviceScreenFromSPHomePage.dart';

class ServiceProviderHomePageScreen extends StatefulWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'serviceProviderHomePageScreen';

  @override
  _ServiceProviderHomePageScreenState createState() =>
      _ServiceProviderHomePageScreenState();
}

class _ServiceProviderHomePageScreenState
    extends State<ServiceProviderHomePageScreen> {
  //----------------------------variables---------------------------------------
  List<Object> _pages;
  int nIndex = 0;

  //------------------------------methods---------------------------------------
  void initState() {
    _pages = [
      /*******Screens*******/
      ServicesScreenFromSPHomePage(),
      MyWorksScreenFromDetails(),
      OffersScreenFromSPHomePage(),
    ];
    super.initState();
  }

  //----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    double containerSize = MediaQuery.of(context).size.width * 0.25;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height - 240,
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
                          'الخدمات',
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
                          'اعمالى',
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
                          'العروض',
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
              child: Container(
                color: Colors.white,
                child: _pages[nIndex],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

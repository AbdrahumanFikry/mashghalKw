import 'package:flutter/material.dart';
import 'package:mashghal_co/authScreens/termsConditionsScreen.dart';
import 'package:mashghal_co/mainScreens/bottomNavigationbarScreen.dart';
import '../widgets/appLogo.dart';
import '../widgets/ServiceSelectionWidget.dart';

class ServiceSelectionScreen extends StatefulWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'serviceSelection';

  @override
  _ServiceSelectionScreenState createState() => _ServiceSelectionScreenState();
}

class _ServiceSelectionScreenState extends State<ServiceSelectionScreen> {
  void _firstOptionSelected() {
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(
        builder: (context) => TermsAndConditionsScreen(
          type: 'user',
        ),
      ),
    );
  }

  void _secondOptionSelected() {
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(
        builder: (context) => TermsAndConditionsScreen(
          type: 'advertiser',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/authBackgroundImage.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppLogoWidget(),
            ServiceSelectionWidget(
              widgetTitle: 'مستخدم',
              widgetImage: 'assets/images/authCategoryImage.jpeg',
              textAlign: TextAlign.end,
              onTab: _firstOptionSelected,
            ),
            ServiceSelectionWidget(
              widgetTitle: 'مزود خدمة',
              widgetImage: 'assets/images/authCaregoryImage2.jpeg',
              textAlign: TextAlign.start,
              onTab: _secondOptionSelected,
            ),
            Container(
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavigationBarScreen(
                              type: 'user',
                              isAuth: false,
                            ))),
                child: Text(
                  'تخطي',
                  style:
                      TextStyle(color: Colors.white, fontFamily: 'beINNormal'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

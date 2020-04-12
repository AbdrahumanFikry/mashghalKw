import 'package:flutter/material.dart';
import 'package:mashghal_co/authScreens/daysSelectionScreen.dart';
import 'package:mashghal_co/authScreens/userSignUpScreen.dart';
import 'package:provider/provider.dart';
import '../widgets/generalAlertDialog.dart';
import '../widgets/appLogo.dart';
import '../providers/moreScreenProvider.dart';
import '../widgets/loader.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'termsConditionsScreen';
  final String type;

  TermsAndConditionsScreen({this.type});


  void _goToApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => GeneralDialog(
          content: 'هل توافق عللى هذه المعاهده؟',
          toDOFunction: () {
            type == 'user'
                ? Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserSignupScreen(),
                    ),
                  )
                : Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DaysSelectionScreen(),
                    ),
                  );
          }),
    );
  }

  //----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/authBackgroundImage.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: const EdgeInsets.only(
                  bottom: 40.0,
                  left: 15.0,
                  right: 15.0,
                  top: 200.0,
                ),
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                  left: 10.0,
                  right: 10.0,
                  top: 70.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    20.0,
                  ),
                  color: Colors.white,
                ),
                child: FutureBuilder(
                  future: Provider.of<More>(context, listen: false)
                      .fetchTerms(type),
                  builder: (context, dataSnapShot) {
                    if (dataSnapShot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: ColorLoader(
                          radius: 20.0,
                          dotRadius: 5.0,
                        ),
                      );
                    } else {
                      if (dataSnapShot.error != null) {
                        return Center(
                          child: Text('An error occurred !'),
                        );
                      } else {
                        return Consumer<More>(
                          builder: (context, terms, child) => ListView(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'المعاهده',
                                    style: TextStyle(
                                      color: Color.fromRGBO(104, 57, 120, 10),
                                      fontSize: 20.0,
                                      fontFamily: 'beINNormal',
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                terms.terms.data.role,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                  fontFamily: 'beINNormal',
                                ),
                                softWrap: true,
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
              Positioned(
                right: (MediaQuery.of(context).size.width - 160) / 2,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 80.0,
                  ),
                  child: AppLogoWidget(),
                ),
              ),
              Positioned(
                bottom: 15.0,
                right: (MediaQuery.of(context).size.width - 50) / 2,
                child: GestureDetector(
                  onTap: ()=>_goToApp(context),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/icons/arrow-point-to-dowen.png',
                    ),
                    radius: 25.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

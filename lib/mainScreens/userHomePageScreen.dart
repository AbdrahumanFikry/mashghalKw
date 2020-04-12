import 'package:flutter/material.dart';
import '../mainScreens/homeCategories.dart';
import '../mainScreens/offersCategories.dart';
import '../mainScreens/salonCategories.dart';
import '../providers/homePageProvider.dart';
import 'package:provider/provider.dart';
import '../widgets/loader.dart';

class UserHomePageScreen extends StatelessWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'userHomePageScreen';

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Provider.of<HomePage>(context).userHomePageModel == null
          ? FutureBuilder(
              future: Provider.of<HomePage>(context, listen: false)
                  .fetchUserHomePage(),
              builder: (context, dataSnapShot) {
                if (dataSnapShot.connectionState == ConnectionState.waiting) {
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
                        'تحقق من اتصالك بالانترنت' +
                            dataSnapShot.error.toString(),
                        style: TextStyle(
                          fontFamily: 'beINNormal',
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                    );
                  } else {
                    return ListView(
                      children: <Widget>[
                        HomeCategory(),
                        SalonCategory(),
                        OffersCategory(),
                        SizedBox(
                          height: 80.0,
                        ),
                      ],
                    );
                  }
                }
              },
            )
          : ListView(
              children: <Widget>[
                HomeCategory(),
                SalonCategory(),
                OffersCategory(),
                SizedBox(
                  height: 80.0,
                ),
              ],
            ),
    );
  }
}

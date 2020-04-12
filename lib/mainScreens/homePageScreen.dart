import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mashghal_co/widgets/loader.dart';
import 'package:provider/provider.dart';
import '../mainScreens/userHomePageScreen.dart';
import '../mainScreens/searchScreen.dart';
import '../mainScreens/serviceProviderScreens/serviceProviderHomePageScreen.dart';
import '../mainScreens/notificationsScreen.dart';
import '../widgets/badge.dart';
import '../providers/homePageProvider.dart';
import '../providers/notificationProvider.dart';

class HomePageScreen extends StatelessWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'homePageScreen';
  final bool isAuth;
  final String type;

  HomePageScreen({@required this.type, this.isAuth});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              AppBar(type, isAuth),
              type == 'user'
                  ? UserHomePageScreen()
                  : ServiceProviderHomePageScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

//--------------------------------AppBar----------------------------------------
class AppBar extends StatelessWidget {
  final String type;
  final bool isAuth;
  AppBar(this.type, this.isAuth);

  Future<void> _fetch(BuildContext context) async {
    await Provider.of<Notifications>(context, listen: false)
        .fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    void _notification() {
      _fetch(context);
      Navigator.of(context).pushNamed(NotificationsScreen.routeName);
    }

    void _search() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SearchList(
            isAuth: isAuth,
            type: type,
          ),
        ),
      );
    }

    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 200,
          color: Colors.white,
        ),
        Container(
          height: 100,
          width: double.infinity,
          color: Color.fromRGBO(235, 218, 241, 10),
          padding: const EdgeInsets.only(
            left: 10.0,
            top: 10.0,
            right: 20.0,
            bottom: 50,
          ),
          child: Row(
            children: <Widget>[
              Text(
                'الرئيسية',
                style: TextStyle(
                  color: Color.fromRGBO(104, 57, 120, 10),
                  fontSize: 20.0,
                  fontFamily: 'beINNormal',
                ),
              ),
              Spacer(),
              IconButton(
                icon: Image.asset(
                  'assets/icons/search.png',
                  fit: BoxFit.cover,
                ),
                onPressed: _search,
              ),
              Consumer<Notifications>(
                builder: (context, notification, child) => IconButton(
                  icon: notification.notifications.isEmpty
                      ? Image.asset(
                          'assets/icons/notification_1.png',
                          fit: BoxFit.cover,
                        )
                      : Badge(
                          child: Image.asset(
                            'assets/icons/notification_1.png',
                            fit: BoxFit.cover,
                          ),
                          color: Colors.red,
                          value: notification.notifications.length.toString(),
                        ),
                  onPressed: _notification,
                ),
              ),
            ],
          ),
        ),
        //---------------------ImageSlider--------------------------------------
        Positioned(
          top: 50,
          left: 0,
          right: 0,
          bottom: 0,
          child: Provider.of<HomePage>(context, listen: false).ads == null
              ? FutureBuilder(
                  future:
                      Provider.of<HomePage>(context, listen: false).fetchAds(),
                  builder: (context, snapShot) {
                    if (snapShot.connectionState == ConnectionState.waiting) {
                      return Container(
                        height: 120,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 40.0,
                          vertical: 15.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[200],
                        ),
                        child: Center(
                          child: ColorLoader(
                            radius: 12.0,
                            dotRadius: 5.0,
                          ),
                        ),
                      );
                    }
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
                    return Consumer<HomePage>(
                      builder: (context, data, child) => CarouselSlider(
                        autoPlay: true,
                        height: 130.0,
                        items: data.ads.data.ads.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                height: 120,
                                width: MediaQuery.of(context).size.width > 400
                                    ? 400
                                    : double.infinity,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 7.0,
                                  vertical: 8.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[200],
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://mashghllkw.com/cdn/' +
                                            i.image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    );
                  },
                )
              : Consumer<HomePage>(
                  builder: (context, data, child) => CarouselSlider(
                    autoPlay: true,
                    height: 130.0,
                    items: data.ads.data.ads.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width > 400
                                ? 400
                                : double.infinity,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 7.0,
                              vertical: 8.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[200],
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://mashghllkw.com/cdn/' + i.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
        ),
      ],
    );
  }
}

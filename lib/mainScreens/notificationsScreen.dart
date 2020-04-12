import 'package:flutter/material.dart';
import 'package:mashghal_co/widgets/loader.dart';
import '../widgets/notificationCardFromNotificationScreen.dart';
import '../providers/notificationProvider.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'notificationsScreen';

  Future<void> onRefresh(BuildContext context) async {
    await Provider.of<Notifications>(context, listen: false)
        .fetchNotifications();
  }

  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(235, 218, 241, 10),
            title: Text(
              'الاشعارات',
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
              future: Provider.of<Notifications>(context, listen: false)
                  .fetchNotifications(),
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: ColorLoader(
                      radius: 20.0,
                      dotRadius: 5.0,
                    ),
                  );
                } else {
                  if (snapShot.error != null) {
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
                    return RefreshIndicator(
                      onRefresh: () => onRefresh(context),
                      child: Consumer<Notifications>(
                        builder: (context, notification, child) => Column(
                          children: <Widget>[
                            notification.notifications
                                    .isEmpty
                                ? Expanded(
                                    child: Center(
                                      child: Text(
                                        'ليس لديك اى اشعارات',
                                        style: TextStyle(
                                          fontFamily: 'beINNormal',
                                          color: Colors.grey,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                      itemCount: notification.notifications.length,
                                      itemBuilder: (context, index) {
                                        return NotificationCard(
                                          id: notification.notifications[index].id,
                                          title: notification.notifications[index].notification.title,
                                          content: notification
                                              .notifications[index].notification
                                              .content,
                                        );
                                      },
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    );
                  }
                }
              }),
        ));
  }
}

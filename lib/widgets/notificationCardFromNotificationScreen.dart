import 'package:flutter/material.dart';
import '../widgets/generalAlertDialog.dart';
import 'package:provider/provider.dart';
import '../providers/notificationProvider.dart';

class NotificationCard extends StatelessWidget {
  final int id;
  final String title;
  final String content;

  NotificationCard({this.id, this.title, this.content});

  Future<void> _showConfirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return GeneralDialog(
            content: 'هل بالفعل تريد حذف هذا الحجز ؟',
            toDOFunction: () => _deleteNotify(context),
          );
        });
  }

  void _deleteNotify(BuildContext context) async {
    await Provider.of<Notifications>(context, listen: false)
        .deleteNotifications(id);
    await Provider.of<Notifications>(context, listen: false)
        .fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5.0,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: 70.0,
            width: 70.0,
            margin: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/images/user.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: Color.fromRGBO(104, 57, 120, 10),
                  fontSize: 16.0,
                  fontFamily: 'beINNormal',
                ),
              ),
              Text(
                content,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12.0,
                  fontFamily: 'beINNormal',
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.cancel,
                  size: 16.0,
                  color: Color.fromRGBO(104, 57, 120, 10),
                ),
                onPressed: () => _showConfirmDialog(context),
              ),
            ],
          )
        ],
      ),
    );
  }
}

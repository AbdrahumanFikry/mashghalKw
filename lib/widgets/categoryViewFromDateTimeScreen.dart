import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/dateTimeWifgetFromDateTimeScreen.dart';
import '../providers/reservationsProvider.dart';

class CategoryViewWidget extends StatelessWidget {
  final int index;
  final String title;
  final String price;

  CategoryViewWidget({
    @required this.index,
    @required this.title,
    @required this.price,
  });

  //-------------------------------methods--------------------------------------
//  void _removeItem(BuildContext context) {
//    Provider.of<Reservations>(context).order.removeAt(index);
//  }

  //-----------------------------AlertDialogMethod-----------------------------
//  Future<void> _confirmDeleting(BuildContext context) {
//    return showDialog(
//      context: context,
//      builder: (context) => GeneralDialog(
//        content: 'هل بالفعل تريد ازالة هذا المنتج؟',
//        toDOFunction: _removeItem,
//      ),
//    );
//  }

  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    List<String> days = [];
    List<String> hours = [];

    Provider.of<Reservations>(context).dayHourModel.days.forEach((i) {
      days.add(i.day);
      hours.add('${i.startTime.split(':')[0]} to ${i.endTime.split(':')[0]}');
    });

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.grey[500],
          width: 1.0,
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  '  الخدمه  ${index + 1}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'beINNormal',
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
          Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[500],
          ),
          Container(
            height: 75,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: 75,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            title,
                            style: TextStyle(
                              fontFamily: 'beINNormal',
                              fontSize: 14.0,
                              color: Colors.deepPurple,
                            ),
                          ),
                          Text(
                            ' : (' + price + ')',
                            style: TextStyle(
                              fontFamily: 'beINNormal',
                              fontSize: 14.0,
                              color: Colors.deepPurple,
                            ),
                          ),
                          Spacer(),
//                          IconButton(
//                            icon: Icon(
//                              Icons.cancel,
//                              color: Colors.deepPurple,
//                              size: 15.0,
//                            ),
//                            onPressed: () => _confirmDeleting(context),
//                          ),
                        ],
                      ),
                      DateTimeWidget(
                        days: days,
                        hours: hours,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

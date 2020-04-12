import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mashghal_co/widgets/loader.dart';
import 'package:provider/provider.dart';
import '../models/serviceModel.dart';
import '../providers/reservationsProvider.dart';

class ShowBillWidget extends StatefulWidget {
  final total;
  final int ownerId;
  final List list;
  final List<ServicesIds> ids;

  ShowBillWidget({this.total, this.list, this.ids, this.ownerId});

  @override
  _ShowBillWidgetState createState() => _ShowBillWidgetState();
}

class _ShowBillWidgetState extends State<ShowBillWidget> {
  bool _isLoading = false;

  void _addOrder(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Reservations>(context)
        .addOrder(json.encode({'services': widget.ids}),widget.ownerId);
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  Widget _serviceName(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.deepPurple,
        fontFamily: 'beINNormal',
        fontSize: 14.0,
      ),
      textAlign: TextAlign.start,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
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
                  "تفاصيل الطلب",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'beINNormal',
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 170,
                      child: ListView.builder(
                        itemCount: widget.list.length,
                        itemBuilder: (context, index) {
                          return _serviceName(widget.list[index].type);
                        },
                      ),
                    ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      children: <Widget>[
//                        Text(
//                          'الوقت',
//                          style: TextStyle(
//                            color: Colors.deepPurple,
//                            fontFamily: 'beINNormal',
//                            fontSize: 14.0,
//                          ),
//                        ),
//                        SizedBox(
//                          width: 20.0,
//                        ),
//                        Text(
//                          '5:30 مساء',
//                          style: TextStyle(
//                            color: Colors.deepPurple,
//                            fontFamily: 'beINNormal',
//                            fontSize: 14.0,
//                          ),
//                          textAlign: TextAlign.start,
//                        ),
//                      ],
//                    ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      children: <Widget>[
//                        Text(
//                          'التاريخ',
//                          style: TextStyle(
//                            color: Colors.deepPurple,
//                            fontFamily: 'beINNormal',
//                            fontSize: 14.0,
//                          ),
//                        ),
//                        SizedBox(
//                          width: 20.0,
//                        ),
//                        Text(
//                          'ابريل - 18 - 2019',
//                          style: TextStyle(
//                            color: Colors.deepPurple,
//                            fontFamily: 'beINNormal',
//                            fontSize: 14.0,
//                          ),
//                          textAlign: TextAlign.start,
//                        ),
//                      ],
//                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'الفاتورة',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontFamily: 'beINNormal',
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          '${widget.total}  ريال  ',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontFamily: 'beINNormal',
                            fontSize: 14.0,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _isLoading
                  ? Container(
                      height: 40.0,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 75.0,
                      ),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(104, 57, 120, 10),
                          borderRadius: BorderRadius.circular(35.0)),
                      child: Center(
                        child: ColorLoader(radius: 15.0, dotRadius: 5.0),
                      ),
                    )
                  : InkWell(
                      onTap: () => _addOrder(context),
                      child: Container(
                        height: 40.0,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 75.0,
                        ),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(104, 57, 120, 10),
                            borderRadius: BorderRadius.circular(35.0)),
                        child: Center(
                          child: Text(
                            'تأكيد',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'beINNormal',
                                fontSize: 18.0),
                            textAlign: TextAlign.center,
                          ),
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

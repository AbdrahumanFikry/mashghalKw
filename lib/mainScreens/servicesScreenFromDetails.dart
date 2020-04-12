import 'package:flutter/material.dart';
import 'package:mashghal_co/authScreens/serviceSelectionScreen.dart';
import 'package:mashghal_co/models/serviceModel.dart';
import 'package:mashghal_co/widgets/generalAlertDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../mainScreens/dateandtimeScreen.dart';
import '../providers/reservationsProvider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ServicesScreenFromDetails extends StatefulWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'servicesScreenFromDetails';
  final int id;
  bool isAuth;

  ServicesScreenFromDetails({
    this.id,
  });

  @override
  _ServicesScreenFromDetailsState createState() =>
      _ServicesScreenFromDetailsState();
}

class _ServicesScreenFromDetailsState extends State<ServicesScreenFromDetails> {
  var total = 0;

  void _reserve(BuildContext context, provider) async {
    Navigator.of(context).pushNamed(DateTimeScreen.routeName, arguments: {
      'ids': provider.ordersId,
      'type': 'price',
      'list': provider.order,
      'total': total,
      'id': widget.id
    });
  }


  @override
  void initState() {
    SharedPreferences.getInstance().then((p) {
      widget.isAuth = p.getBool('isAuth');
    });
    Provider.of<Reservations>(context, listen: false).order.clear();
    Provider.of<Reservations>(context, listen: false).ordersId.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Reservations>(
      builder: (_, provider, child) => provider
              .coiffeurDetails.data.services.isEmpty
          ? Center(
              child: Text(
                'لا يوجد خدمات لهذا المشغل',
                style: TextStyle(
                  fontFamily: 'beINNormal',
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
              ),
            )
          : Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.coiffeurDetails.data.services.length,
                    itemBuilder: (context, outerIndex) {
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
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    provider.coiffeurDetails.data
                                        .services[outerIndex].serviceName,
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
                              height: 80.0 *
                                  provider.coiffeurDetails.data
                                      .services[outerIndex].details.length,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: provider.coiffeurDetails.data
                                    .services[outerIndex].details.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Row(
                                      children: <Widget>[
                                        Text(
                                          provider
                                              .coiffeurDetails
                                              .data
                                              .services[outerIndex]
                                              .details[index]
                                              .type,
                                          style: TextStyle(
                                            fontFamily: 'beINNormal',
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          '(' +
                                              provider
                                                  .coiffeurDetails
                                                  .data
                                                  .services[outerIndex]
                                                  .details[index]
                                                  .price +
                                              '  ريال)',
                                          style: TextStyle(
                                            fontFamily: 'beINNormal',
                                            color: Colors.grey,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: Row(
                                      children: <Widget>[
                                        SmoothStarRating(
                                          allowHalfRating: true,
                                          starCount: 5,
                                          rating: provider
                                                      .coiffeurDetails
                                                      .data
                                                      .services[outerIndex]
                                                      .details[index]
                                                      .rate ==
                                                  null
                                              ? 0
                                              : provider
                                                  .coiffeurDetails
                                                  .data
                                                  .services[outerIndex]
                                                  .details[index]
                                                  .rate,
                                          size: 10.0,
                                          color: Colors.yellow,
                                          borderColor: Colors.yellow,
                                          spacing: 0.0,
                                        ),
                                        SizedBox(
                                          width: 7.0,
                                        ),
                                        Text(
                                          '${provider.coiffeurDetails.data.services[outerIndex].users}   مستخدم ',
                                          style: TextStyle(
                                              fontFamily: 'beINNormal'),
                                        )
                                      ],
                                    ),
                                    trailing: GestureDetector(
                                      onTap: () {
                                        provider.order.add(provider
                                            .coiffeurDetails
                                            .data
                                            .services[outerIndex]
                                            .details[index]);
                                        provider.ordersId.add(ServicesIds(
                                          serviceId: provider
                                              .coiffeurDetails
                                              .data
                                              .services[outerIndex]
                                              .details[index]
                                              .id,
                                        ));
                                        setState(() {
                                          total = total +
                                              int.parse(provider
                                                  .coiffeurDetails
                                                  .data
                                                  .services[outerIndex]
                                                  .details[index]
                                                  .price);
                                        });
                                        Scaffold.of(context)
                                            .hideCurrentSnackBar();
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Row(
                                            children: <Widget>[
                                              Text(
                                                'تم الاضافه للفاتورة',
                                                style: TextStyle(
                                                  fontFamily: 'beINNormal',
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                provider
                                                    .coiffeurDetails
                                                    .data
                                                    .services[outerIndex]
                                                    .details[index]
                                                    .price,
                                                style: TextStyle(
                                                  fontFamily: 'beINNormal',
                                                ),
                                              ),
                                            ],
                                          ),
                                          duration: Duration(seconds: 1),
                                        ));
                                      },
                                      child: Container(
                                        height: 20.0,
                                        width: 50.0,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 9.0, horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(104, 57, 120, 10),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Center(
                                          child: FittedBox(
                                            child: Text(
                                              'اختيار',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'beINNormal',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (widget.isAuth)
                      _reserve(context, provider);
                    else
                      showDialog(
                          context: context,
                          builder: (context) => GeneralDialog(
                              content: 'يرجي تسجيل الدخول',
                              toDOFunction: () =>
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    ServiceSelectionScreen.routeName,
                                    (Route<dynamic> route) => false,
                                  )));
                  },
                  child: Container(
                    height: 30,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(104, 57, 120, 10),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Center(
                      child: Text(
                        'مجموع المبلغ  (' +
                            total.toString() +
                            ') ريال  القيام بالحجز',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'beINNormal',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

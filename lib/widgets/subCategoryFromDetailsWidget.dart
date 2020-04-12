import 'package:flutter/material.dart';
import 'package:mashghal_co/providers/reservationsProvider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SubCategoryFromDetailsWidget extends StatelessWidget {
  final String title;
  final int listIndex;
  final String type;

  SubCategoryFromDetailsWidget(
      {@required this.title, @required this.listIndex, @required this.type});

  @override
  Widget build(BuildContext context) {
    int total;
    return Consumer<Reservations>(
      builder: (context, service, child) => Container(
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
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    title,
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
              height: type == 'services'
                  ? 72.0 *
                      service.coiffeurDetails.data.services[listIndex].details
                          .length
                  : 72.0 *
                      service.coiffeurDetails.data.offers[listIndex].details
                          .length,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: type == 'services'
                    ? service
                        .coiffeurDetails.data.services[listIndex].details.length
                    : service
                        .coiffeurDetails.data.offers[listIndex].details.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: type == 'services'
                        ? Row(
                            children: <Widget>[
                              Text(
                                service.coiffeurDetails.data.services[listIndex]
                                    .details[index].type,
                                style: TextStyle(
                                  fontFamily: 'beINNormal',
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                service.coiffeurDetails.data.services[listIndex]
                                        .details[index].price +
                                    '  ريال',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 14.0,
                                  fontFamily: 'beINNormal',
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: <Widget>[
                              Text(
                                service.coiffeurDetails.data.offers[listIndex]
                                    .details[index].type,
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
                                    service
                                        .coiffeurDetails
                                        .data
                                        .offers[listIndex]
                                        .details[index]
                                        .price +
                                    '  ريال)',
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontFamily: 'beINNormal',
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                service.coiffeurDetails.data.offers[listIndex]
                                        .details[index].offer +
                                    '  ريال',
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 14.0,
                                  fontFamily: 'beINNormal',
                                ),
                              ),
                            ],
                          ),
                    subtitle: Row(
                      children: <Widget>[
                        SmoothStarRating(
                          allowHalfRating: true,
                          starCount: 5,
                          rating: type == 'services'
                              ? service.coiffeurDetails.data.services[listIndex]
                                  .details[index].rate
                                  .toDouble()
                              : service.coiffeurDetails.data.offers[listIndex]
                                  .details[index].rate
                                  .toDouble(),
                          size: 10.0,
                          color: Colors.yellow,
                          borderColor: Colors.yellow,
                          spacing: 0.0,
                        ),
                        SizedBox(
                          width: 7.0,
                        ),
                        Text(
                          '25 مستخدم',
                          style: TextStyle(fontFamily: 'beINNormal'),
                        )
                      ],
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        total = total +
                            int.parse(service.coiffeurDetails.data
                                .services[listIndex].details[index].price);
                      },
                      child: Container(
                        height: 20.0,
                        width: 50.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 9.0, horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(104, 57, 120, 10),
                          borderRadius: BorderRadius.circular(20.0),
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mashghal_co/mainScreens/offerReview.dart';
import 'package:mashghal_co/widgets/categoryItem.dart';
import '../mainScreens/moreCategoriesScreen.dart';
import '../providers/homePageProvider.dart';
import 'package:provider/provider.dart';

class OffersCategory extends StatelessWidget {
  void _moreItems(BuildContext context) {
    Navigator.of(context)
        .pushNamed(MoreCategoriesScreen.routeName, arguments: 'offers');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'العروض',
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'beINNormal',
                  fontSize: 18.0,
                ),
              ),
              Spacer(),
              GestureDetector(
                child: Text(
                  'المزيد',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'beINNormal',
                    fontSize: 14.0,
                  ),
                ),
                onTap: () => _moreItems(context),
              ),
            ],
          ),
          SizedBox(
            height: 140,
            child: Consumer<HomePage>(
              builder: (context, data, child) =>
                  data.userHomePageModel.data.offers.isEmpty
                      ? Center(
                          child: Text(
                            'لا يوجد عروض حتى الان',
                            style: TextStyle(
                              fontFamily: 'beINNormal',
                              color: Colors.grey,
                              fontSize: 16.0,
                            ),
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => OfferReviewScreen(
                                      id: data.userHomePageModel.data
                                          .offers[index].userId,
                                    ),
                                  ),
                                );
                              },
                              child: CategoryItem(
                                isOffer: 'yes',
                                title: data
                                    .userHomePageModel.data.offers[index].type,
                                image: '',
                              ),
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}

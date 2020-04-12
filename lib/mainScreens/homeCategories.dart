import 'package:flutter/material.dart';
import 'package:mashghal_co/mainScreens/coiffeurDetails.dart';
import 'package:mashghal_co/widgets/categoryItem.dart';
import '../mainScreens/moreCategoriesScreen.dart';
import '../providers/homePageProvider.dart';
import 'package:provider/provider.dart';

class HomeCategory extends StatelessWidget {
  void _moreItems(BuildContext context) {
    Navigator.of(context)
        .pushNamed(MoreCategoriesScreen.routeName, arguments: 'homes');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePage>(
      builder: (context, data, child) => Container(
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
                  'المنزل',
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
              child: data.userHomePageModel.data.homes.isEmpty
                  ? Center(
                      child: Text(
                        'لا يوجد منازل حتى الان',
                        style: TextStyle(
                          fontFamily: 'beINNormal',
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.userHomePageModel.data.homes.length,
                      itemBuilder: (context, index) {
//                        print(':::::::::::::' +
//                            data.userHomePageModel.data.homes.length
//                                .toString());
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CoiffeurDetailsScreen(
                                  id: data
                                      .userHomePageModel.data.homes[index].id,
                                ),
                              ),
                            );
                          },
                          child: CategoryItem(
                            isOffer: 'no',
                            title:
                                data.userHomePageModel.data.homes[index].name,
                            image:
                                data.userHomePageModel.data.homes[index].image,
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/favouriteCard.dart';
import '../providers/moreScreenProvider.dart';
import '../widgets/loader.dart';

class FavouriteScreen extends StatelessWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'favouriteScreen';

  Future<void> _onRefresh(BuildContext context) async {
    await Provider.of<More>(context, listen: false).fetchFavourite();
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
            'المفضله',
            style: TextStyle(
              color: Color.fromRGBO(104, 57, 120, 10),
              fontSize: 20.0,
              fontFamily: 'beINNormal',
            ),
          ),
          leading: new Container(),
        ),
        body: FutureBuilder(
          future: Provider.of<More>(context, listen: false).fetchFavourite(),
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
                    'تحقق من اتصالك بالانترنت',
                    style: TextStyle(
                      fontFamily: 'beINNormal',
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                );
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Consumer<More>(
                    builder: (context, fav, child) => fav
                            .favourites.data.advertisers.isEmpty
                        ? Center(
                            child: Text(
                              'المفضله فارغه',
                              style: TextStyle(
                                fontFamily: 'beINNormal',
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () => _onRefresh(context),
                            child: ListView.builder(
                              itemCount:
                                  fav.favourites.data.advertisers.length + 1,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: index !=
                                          fav.favourites.data.advertisers.length
                                      ? FavouriteCard(
                                          id: fav.favourites.data
                                              .advertisers[index].advertiserId,
                                          favId: fav.favourites.data
                                              .advertisers[index].id,
                                          title: fav
                                              .favourites
                                              .data
                                              .advertisers[index]
                                              .advertiser
                                              .name,
                                          image: fav
                                              .favourites
                                              .data
                                              .advertisers[index]
                                              .advertiser
                                              .image,
                                          rate: fav
                                              .favourites
                                              .data
                                              .advertisers[index]
                                              .advertiser
                                              .rate,
                                        )
                                      : SizedBox(
                                          height: 90.0,
                                        ),
                                );
                              },
                            ),
                          ),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mashghal_co/widgets/categoryItem.dart';
import '../mainScreens/searchScreen.dart';
import '../mainScreens/coiffeurDetails.dart';
import 'package:provider/provider.dart';
import '../providers/homePageProvider.dart';
import '../mainScreens/offerReview.dart';

class MoreCategoriesScreen extends StatefulWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'moreCategoriesScreen';

  @override
  _MoreCategoriesScreenState createState() => _MoreCategoriesScreenState();
}

class _MoreCategoriesScreenState extends State<MoreCategoriesScreen> {
  //-------------------------------methods--------------------------------------
  void _search() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchList(
          type: 'user',
        ),
      ),
    );
  }

  void _viewDetails(int id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CoiffeurDetailsScreen(
          id: id,
        ),
      ),
    );
  }

  void _viewOfferDetails(int id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OfferReviewScreen(
          id: id,
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final type = ModalRoute.of(context).settings.arguments;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(235, 218, 241, 10),
          title: Text(
            'المزيد',
            style: TextStyle(
              color: Color.fromRGBO(104, 57, 120, 10),
              fontSize: 20.0,
              fontFamily: 'beINNormal',
            ),
          ),
          actions: <Widget>[
            type == 'offers'
                ? Container()
                : IconButton(
                    icon: Image.asset(
                      'assets/icons/search.png',
                      fit: BoxFit.cover,
                    ),
                    onPressed: _search,
                  ),
            SizedBox(
              width: 10.0,
            ),
          ],
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color.fromRGBO(104, 57, 120, 10),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Consumer<HomePage>(
            builder: (context, data, child) => GridView.builder(
              padding: const EdgeInsets.all(5.0),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: type == 'salons'
                  ? data.userHomePageModel.data.salons.length
                  : type == 'offers'
                      ? data.userHomePageModel.data.offers.length
                      : data.userHomePageModel.data.homes.length,
              itemBuilder: (context, index) {
                return type == 'salons'
                    ? GestureDetector(
                        onTap: () => _viewDetails(
                            data.userHomePageModel.data.salons[index].id),
                        child: CategoryItem(
                          isOffer: 'no',
                          title: data.userHomePageModel.data.salons[index].name,
                          image:
                              data.userHomePageModel.data.salons[index].image,
                        ),
                      )
                    : type == 'offers'
                        ? GestureDetector(
                            onTap: () => _viewOfferDetails(data
                                .userHomePageModel.data.offers[index].userId),
                            child: CategoryItem(
                                isOffer: 'yes',
                                title: data
                                    .userHomePageModel.data.offers[index].type,
                                image: ''),
                          )
                        : GestureDetector(
                            onTap: () => _viewDetails(
                                data.userHomePageModel.data.homes[index].id),
                            child: CategoryItem(
                              isOffer: 'no',
                              title:
                                  data.userHomePageModel.data.homes[index].name,
                              image: data
                                  .userHomePageModel.data.homes[index].image,
                            ),
                          );
              },
            ),
          ),
        ),
      ),
    );
  }
}

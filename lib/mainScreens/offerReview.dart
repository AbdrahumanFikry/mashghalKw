import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../mainScreens/chatScreen.dart';
import '../mainScreens/offerScreenFromDetails.dart';
import '../providers/reservationsProvider.dart';
import '../widgets/loader.dart';
import '../providers/moreScreenProvider.dart';

class OfferReviewScreen extends StatefulWidget {
  final int id;

  OfferReviewScreen({this.id});

  @override
  _OfferReviewScreenState createState() => _OfferReviewScreenState();
}

class _OfferReviewScreenState extends State<OfferReviewScreen> {
  //-----------------------------variables--------------------------------------
  int _isFav = 0;

  //-------------------------------methods--------------------------------------

  void _share() {
    // TODO --------------------------------------------------------------
  }

  Future<void> _favouriteIconPressed(int id) async {
    if (_isFav == 0) {
      setState(() {
        _isFav = 1;
      });
      await Provider.of<Reservations>(context, listen: false)
          .makeFav(widget.id);
    } else {
      setState(() {
        _isFav = 0;
      });
      await Provider.of<More>(context, listen: false).deleteFav(id);
    }
  }

  void _contactIconPressed() {
    Navigator.of(context).pushNamed(ChatScreen.routeName);
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
            'اسم المشغل',
            style: TextStyle(
              color: Color.fromRGBO(104, 57, 120, 10),
              fontSize: 20.0,
              fontFamily: 'beINNormal',
            ),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.share,
                  color: Color.fromRGBO(104, 57, 120, 10),
                ),
                onPressed: _share),
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
        body: FutureBuilder(
          future: Provider.of<Reservations>(context, listen: false)
              .fetchCoiffeurDetails(widget.id),
          builder: (context, dataSnapShot) {
            if (dataSnapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: ColorLoader(
                  radius: 20.0,
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
                _isFav =
                    Provider
                        .of<Reservations>(context)
                        .coiffeurDetails
                        .data
                        .fav;
                return Consumer<Reservations>(
                  builder: (context, detail, child) => Column(
                    children: <Widget>[
                      //----------------------ClientDetails-----------------------------
                      Container(
                        height: 120,
                        width: double.infinity,
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: Colors.grey[300],
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                'https://mashghllkw.com/cdn/' +
                                    detail.coiffeurDetails.data.advertiserImage,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                detail.coiffeurDetails.data.advertiserName,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'beINNormal',
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                  icon: _isFav == 1
                                      ? Image.asset(
                                          'assets/icons/fav.png',
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'assets/icons/favore.png',
                                          fit: BoxFit.cover,
                                        ),
                                  onPressed: () => _favouriteIconPressed(
                                      detail.coiffeurDetails.data.favId),
                                ),
                                IconButton(
                                  icon: Image.asset(
                                    'assets/icons/speech-bubble.png',
                                    fit: BoxFit.cover,
                                  ),
                                  onPressed: _contactIconPressed,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //------------------------------TabBar----------------------------
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: 80,
                                color: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 10.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.60,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            40.0,
                                          ),
                                          border: Border.all(
                                            width: 1.0,
                                            color: Color.fromRGBO(
                                                104, 57, 120, 10),
                                          ),
                                          color: Colors.white),
                                      child: Center(
                                        child: Text(
                                          'العروض المتاحه',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                104, 57, 120, 10),
                                            fontSize: 16.0,
                                            fontFamily: 'beINNormal',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.white,
                                  child: OfferScreenFromDetails(
                                    id: widget.id,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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

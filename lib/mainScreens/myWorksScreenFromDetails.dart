import 'package:flutter/material.dart';
import 'package:mashghal_co/mainScreens/videoViewer.dart';
import 'package:mashghal_co/widgets/loader.dart';
import '../providers/homePageProvider.dart';
import 'package:provider/provider.dart';

class MyWorksScreenFromDetails extends StatelessWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'myWorksScreenFromDetails';

  void _playVideo(BuildContext context, String imageUrl) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(videoURl: imageUrl),
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    await Provider.of<HomePage>(context, listen: false).fetchAdvertiserWorks();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<HomePage>(context, listen: false).fetchAdvertiserWorks(),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: ColorLoader(
              radius: 20.0,
              dotRadius: 5.0,
            ),
          );
        } else {
          if (snapShot.error != null) {
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
              width: double.infinity,
              child: Consumer<HomePage>(
                builder: (context, works, child) => works
                            .advertiserWorks.data.works.length ==
                        0
                    ? Center(
                        child: Text(
                          'اضف صور و فيديوهات من اعمالك ',
                          style: TextStyle(
                            fontFamily: 'beINNormal',
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () => _onRefresh(context),
                        backgroundColor: Color.fromRGBO(104, 57, 120, 10),
                        color: Color.fromRGBO(235, 218, 241, 10),
                        child: GridView.builder(
                          padding: const EdgeInsets.only(
                            right: 15.0,
                            left: 15.0,
                            top: 15.0,
                            bottom: 60.0,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                MediaQuery.of(context).size.width * 0.5,
                            crossAxisSpacing: 20.0,
                            mainAxisSpacing: 20.0,
                          ),
                          itemCount: works.advertiserWorks.data.works.length,
                          itemBuilder: (context, index) {
                            return works.advertiserWorks.data.works[index].media
                                        .contains('mp') ||
                                    works
                                        .advertiserWorks.data.works[index].media
                                        .contains('WEBM') ||
                                    works
                                        .advertiserWorks.data.works[index].media
                                        .contains('WMV') ||
                                    works
                                        .advertiserWorks.data.works[index].media
                                        .contains('AVI') ||
                                    works
                                        .advertiserWorks.data.works[index].media
                                        .contains('MOV') ||
                                    works
                                        .advertiserWorks.data.works[index].media
                                        .contains('AVCHD') ||
                                    works
                                        .advertiserWorks.data.works[index].media
                                        .contains('FLV') ||
                                    works
                                        .advertiserWorks.data.works[index].media
                                        .contains('SWF') ||
                                    works
                                        .advertiserWorks.data.works[index].media
                                        .contains('QT')
                                ? GestureDetector(
                                    onTap: () => _playVideo(
                                        context,
                                        works.advertiserWorks.data.works[index]
                                            .media),
                                    child: Container(
                                      height: 70,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/videoImage.png',
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 70,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[100],
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          'https://mashghllkw.com/cdn/' +
                                              works.advertiserWorks.data
                                                  .works[index].media,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
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
    );
  }
}

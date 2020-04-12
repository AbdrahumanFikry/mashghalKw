import 'package:flutter/material.dart';
import 'package:mashghal_co/mainScreens/videoViewer.dart';
import 'package:mashghal_co/providers/reservationsProvider.dart';
import 'package:provider/provider.dart';

class WorksScreenFromDetails extends StatelessWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'myWorksScreenFromDetails';

  void _playVideo(BuildContext context, String imageUrl) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(videoURl: imageUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Reservations>(
      builder: (context, works, child) => works
              .coiffeurDetails.data.works.isEmpty
          ? Center(
              child: Text(
                'لا يوجد اعمال لعرضها',
                style: TextStyle(
                  fontFamily: 'beINNormal',
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.only(
                right: 15.0,
                left: 15.0,
                top: 15.0,
                bottom: 60.0,
              ),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
              ),
              itemCount: works.coiffeurDetails.data.works.length,
              itemBuilder: (context, index) {
                return works.coiffeurDetails.data.works[index].media
                            .contains('mp') ||
                        works.coiffeurDetails.data.works[index].media
                            .contains('WEBM') ||
                        works.coiffeurDetails.data.works[index].media
                            .contains('WMV') ||
                        works.coiffeurDetails.data.works[index].media
                            .contains('AVI') ||
                        works.coiffeurDetails.data.works[index].media
                            .contains('MOV') ||
                        works.coiffeurDetails.data.works[index].media
                            .contains('AVCHD') ||
                        works.coiffeurDetails.data.works[index].media
                            .contains('FLV') ||
                        works.coiffeurDetails.data.works[index].media
                            .contains('SWF') ||
                        works.coiffeurDetails.data.works[index].media
                            .contains('QT')
                    ? GestureDetector(
                        onTap: () => _playVideo(context,
                            works.coiffeurDetails.data.works[index].media),
                        child: Container(
                          height: 70,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
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
                                  works.coiffeurDetails.data.works[index].media,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mashghal_co/providers/moreScreenProvider.dart';
import 'package:mashghal_co/widgets/loader.dart';
import 'package:provider/provider.dart';

class AboutAppScreen extends StatelessWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'aboutAppScreen';

  @override
  Widget build(BuildContext context) {
    final moreData = Provider.of<More>(context, listen: false);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(235, 218, 241, 10),
          title: Text(
            'عن التطبيق',
            style: TextStyle(
              color: Color.fromRGBO(104, 57, 120, 10),
              fontSize: 20.0,
              fontFamily: 'beINNormal',
            ),
          ),
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
            future: moreData.fetchAboutApp(),
            builder: (context, data) {
              if (data.connectionState == ConnectionState.waiting) {
                return Center(
                  child: ColorLoader(
                    radius: 20.0,
                    dotRadius: 5.0,
                  ),
                );
              } else {
                if (data.error != null) {
                  return Center(
                    child: Text('An error occurred !' + data.error.toString()),
                  );
                } else {
                  return Consumer<More>(
                    builder: (context, more, child) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: ListView(
                        children: <Widget>[
                          Text(
                            more.aboutApp.data.info.phone,
                            style: TextStyle(
                              color: Color.fromRGBO(104, 57, 120, 10),
                              fontSize: 24.0,
                              fontFamily: 'beINNormal',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            more.aboutApp.data.info.email,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18.0,
                              fontFamily: 'beINNormal',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            more.aboutApp.data.info.about,
                            style: TextStyle(
                              color: Colors.pink,
                              fontSize: 18.0,
                              fontFamily: 'beINNormal',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            more.aboutApp.data.info.role,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                              fontFamily: 'beINNormal',
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }
            }),
      ),
    );
  }
}

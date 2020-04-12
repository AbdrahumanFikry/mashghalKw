import 'package:flutter/material.dart';
import 'package:mashghal_co/widgets/loader.dart';
import 'package:provider/provider.dart';
import '../../widgets/serviceProviderItem.dart';
import '../../providers/homePageProvider.dart';

class ServicesScreenFromSPHomePage extends StatelessWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'serviceScreenFromSPHomePage';

  Future<void> _onRefresh(BuildContext context) async {
    await Provider.of<HomePage>(context, listen: false)
        .fetchAdvertiserServices();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<HomePage>(context, listen: false)
          .fetchAdvertiserServices(),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: ColorLoader(
              radius: 15.0,
              dotRadius: 5.0,
            ),
          );
        } else {
          if (snapShot.error != null) {
            return Center(
              child: Text(
                'تحقق من اتصالك بالانترنت' + snapShot.error.toString(),
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
              color: Colors.white,
              child: Consumer<HomePage>(
                builder: (context, services, child) =>
                    services.advertiserServices.data.services.length == 0
                        ? Center(
                            child: Text(
                              'اضف خدماتك الان ! وقم بالتعديل عليها',
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
                            child: ListView.builder(
                              itemCount: services
                                      .advertiserServices.data.services.length +
                                  1,
                              itemBuilder: (context, index) {
                                return index !=
                                        services.advertiserServices.data
                                            .services.length
                                    ? ChangeNotifierProvider(
                                        builder: (context) => services
                                            .advertiserServices
                                            .data
                                            .services[index],
                                        child: ServiceProviderItem(
                                          type: 'services',
                                        ),
                                      )
                                    : SizedBox(
                                        height: 90.0,
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

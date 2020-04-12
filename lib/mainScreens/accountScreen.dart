import 'package:flutter/material.dart';
import '../mainScreens/editInfoScreen.dart';
import 'package:provider/provider.dart';
import '../providers/moreScreenProvider.dart';
import '../widgets/loader.dart';

class AccountScreen extends StatefulWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'accountScreen';

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  void _goToEditScreen(Map<dynamic, dynamic> data) {
    Navigator.of(context).pushNamed(EditInfoScreen.routeName, arguments: data);
  }

  Widget _infoViewer(String title, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            title,
            style: TextStyle(
              color: Color.fromRGBO(104, 57, 120, 10),
              fontSize: 16.0,
              fontFamily: 'beINNormal',
            ),
          ),
        ),
        Container(
          height: 40,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 15.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              10.0,
            ),
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          child: Text(
            hintText,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
              fontFamily: 'beINNormal',
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final item =
        Provider.of<More>(context, listen: false).userProfile.data.user;
    Map<dynamic, dynamic> data = {
      'name': item.name,
      'email': item.email,
      'phone': item.phone,
      'image': item.image,
    };
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(235, 218, 241, 10),
          title: Text(
            'الصفحه الشخصيه',
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
          future: Provider.of<More>(context, listen: false).fetchUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: ColorLoader(
                  radius: 15.0,
                  dotRadius: 5.0,
                ),
              );
            } else {
              if (snapshot.error != null) {
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
                return Consumer<More>(
                  builder: (context, profileData, child) => ListView(
                    children: <Widget>[
                      //--------------------------header--------------------------------
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 175,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(104, 57, 120, 10)
                                      .withOpacity(0.5),
                                  Color.fromRGBO(104, 57, 120, 10)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20.0,
                            right:
                                (MediaQuery.of(context).size.width - 100) / 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: profileData
                                              .userProfile.data.user.image ==
                                          null
                                      ? AssetImage('assets/images/user.png')
                                      : NetworkImage(
                                          'https://mashghllkw.com/cdn/' +
                                              profileData
                                                  .userProfile.data.user.image),
                                  backgroundColor: Colors.white,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                GestureDetector(
                                  onTap: () => _goToEditScreen(data),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2.0,
                                      horizontal: 10.0,
                                    ),
                                    child: Text(
                                      'تعديل بياناتى',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        fontFamily: 'beINNormal',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //---------------------------body---------------------------------
                      SizedBox(
                        height: 50.0,
                      ),
                      _infoViewer('اسم المستخدم',
                          profileData.userProfile.data.user.name),
                      _infoViewer('البريد الالكنرونى',
                          profileData.userProfile.data.user.email),
                      _infoViewer('رقم الجوال',
                          profileData.userProfile.data.user.phone),
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

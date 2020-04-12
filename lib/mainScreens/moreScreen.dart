import 'package:flutter/material.dart';
import 'package:mashghal_co/authScreens/serviceSelectionScreen.dart';
import 'package:mashghal_co/models/profileModel.dart';
import 'package:mashghal_co/models/userProfileModel.dart';
import 'package:mashghal_co/widgets/loader.dart';
import './serviceProviderScreens/serviceProviderAccountScreen.dart';
import './serviceProviderScreens/appPaymentScreen.dart';
import '../mainScreens/messagesScreen.dart';
import '../mainScreens/accountScreen.dart';
import '../mainScreens/aboutAppScreen.dart';
import '../mainScreens/questionsScreen.dart';
import '../providers/Auth.dart';
import 'package:provider/provider.dart';
import '../providers/moreScreenProvider.dart';

class MoreScreen extends StatefulWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'moreScreen';
  final String type;
  final bool isAuth;

  MoreScreen({@required this.type, this.isAuth});

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  //----------------------------variables---------------------------------------
  bool switchOn = false;
  int userId = 0;

  //-----------------------------methods----------------------------------------
  void _onSwitchChanged(bool value) async {
    setState(() {
      switchOn = !switchOn;
    });
    if (switchOn) {
      await Provider.of<More>(context, listen: false)
          .notificationsStatus(userId, 1);
    } else {
      await Provider.of<More>(context, listen: false)
          .notificationsStatus(userId, 0);
    }
  }

  void _goToAccountScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider<UserData>(
          builder: (context) => UserData(),
          child: AccountScreen(),
        ),
      ),
    );
  }

  void _goToAccountSPScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider<Advertiser>(
          builder: (context) => Advertiser(),
          child: ServiceProviderAccountScreen(),
        ),
      ),
    );
  }

  void _goToMessages() {
    Navigator.of(context)
        .pushNamed(MessagesScreen.routeName, arguments: widget.type);
  }

  void _goToAppPayment() {
    Navigator.of(context).pushNamed(AppPaymentScreen.routeName);
  }

  void _goToAboutApp() {
    Navigator.of(context).pushNamed(AboutAppScreen.routeName);
  }

  void _goToQuestions() {
    Navigator.of(context).pushNamed(QuestionsScreen.routeName);
  }

  void _logout(provider) {
    provider.logout().then((_) => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ServiceSelectionScreen(),
          ),
        ));
  }

  Widget _buildContainer(String title, Function toDO) {
    return GestureDetector(
      onTap: toDO,
      child: Container(
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
            30.0,
          ),
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        child: Row(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
                fontFamily: 'beINNormal',
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 16.0,
            )
          ],
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ChangeNotifierProvider(
        builder: (_) => Auth(),
        child: Consumer<Auth>(
          builder: (_, provider, child) => Scaffold(
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
              leading: new Container(),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  //---------------------AccountCard----------------------------
                  (!widget.isAuth)
                      ? Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              15.0,
                            ),
                            color: Colors.grey[200],
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 10.0,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 15.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    AssetImage('assets/images/user.png'),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                'Guest',
                                style: TextStyle(
                                  color: Color.fromRGBO(104, 57, 120, 10),
                                  fontSize: 16.0,
                                  fontFamily: 'beINNormal',
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        )
                      : widget.type == 'user'
                          ? Provider.of<More>(context, listen: false)
                                      .userProfile ==
                                  null
                              ? FutureBuilder(
                                  future:
                                      Provider.of<More>(context, listen: false)
                                          .fetchUserProfile(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container(
                                        width: double.infinity,
                                        height: 85.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            15.0,
                                          ),
                                          color: Colors.grey[200],
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 15.0,
                                          horizontal: 10.0,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                          horizontal: 15.0,
                                        ),
                                        child: Center(
                                          child: ColorLoader(
                                            radius: 15.0,
                                            dotRadius: 5.0,
                                          ),
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
                                        userId = Provider.of<More>(context,
                                                listen: false)
                                            .userProfile
                                            .data
                                            .user
                                            .id;
                                        if (Provider.of<More>(context,
                                                    listen: false)
                                                .userProfile
                                                .data
                                                .user
                                                .notification ==
                                            0) {
                                          switchOn = false;
                                        } else {
                                          switchOn = true;
                                        }
                                        return Consumer<More>(
                                          builder:
                                              (context, profileData, child) =>
                                                  GestureDetector(
                                            onTap: _goToAccountScreen,
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  15.0,
                                                ),
                                                color: Colors.grey[200],
                                              ),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                vertical: 15.0,
                                                horizontal: 10.0,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 15.0,
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  CircleAvatar(
                                                    radius: 35,
                                                    backgroundColor:
                                                        Colors.white,
                                                    backgroundImage: profileData
                                                                .userProfile
                                                                .data
                                                                .user
                                                                .image ==
                                                            null
                                                        ? AssetImage(
                                                            'assets/images/user.png')
                                                        : NetworkImage(
                                                            'https://mashghllkw.com/cdn/' +
                                                                profileData
                                                                    .userProfile
                                                                    .data
                                                                    .user
                                                                    .image),
                                                  ),
                                                  SizedBox(
                                                    width: 20.0,
                                                  ),
                                                  Text(
                                                    profileData.userProfile.data
                                                        .user.name,
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          104, 57, 120, 10),
                                                      fontSize: 16.0,
                                                      fontFamily: 'beINNormal',
                                                    ),
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                )
                              : Consumer<More>(
                                  builder: (context, profileData, child) =>
                                      GestureDetector(
                                    onTap: _goToAccountScreen,
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          15.0,
                                        ),
                                        color: Colors.grey[200],
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 15.0,
                                        horizontal: 10.0,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 15.0,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            radius: 35,
                                            backgroundColor: Colors.white,
                                            backgroundImage: profileData
                                                        .userProfile
                                                        .data
                                                        .user
                                                        .image ==
                                                    null
                                                ? AssetImage(
                                                    'assets/images/user.png')
                                                : NetworkImage(
                                                    'https://mashghllkw.com/cdn/' +
                                                        profileData.userProfile
                                                            .data.user.image),
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Text(
                                            profileData
                                                .userProfile.data.user.name,
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  104, 57, 120, 10),
                                              fontSize: 16.0,
                                              fontFamily: 'beINNormal',
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                          : Provider.of<More>(context, listen: false)
                                      .advertiserProfile ==
                                  null
                              ? FutureBuilder(
                                  future:
                                      Provider.of<More>(context, listen: false)
                                          .fetchAdvertiserProfile(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container(
                                        width: double.infinity,
                                        height: 85.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            15.0,
                                          ),
                                          color: Colors.grey[200],
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 15.0,
                                          horizontal: 10.0,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                          horizontal: 15.0,
                                        ),
                                        child: Center(
                                          child: ColorLoader(
                                            radius: 15.0,
                                            dotRadius: 5.0,
                                          ),
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
                                        userId = Provider.of<More>(context)
                                            .advertiserProfile
                                            .data
                                            .advertiser
                                            .id;
                                        if (Provider.of<More>(context,
                                                    listen: false)
                                                .advertiserProfile
                                                .data
                                                .advertiser
                                                .notification ==
                                            0) {
                                          switchOn = false;
                                        } else {
                                          switchOn = true;
                                        }
                                        return Consumer<More>(
                                          builder:
                                              (context, profileData, child) =>
                                                  GestureDetector(
                                            onTap: widget.type == 'user'
                                                ? _goToAccountScreen
                                                : _goToAccountSPScreen,
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  15.0,
                                                ),
                                                color: Colors.grey[200],
                                              ),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                vertical: 15.0,
                                                horizontal: 10.0,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 15.0,
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  CircleAvatar(
                                                    radius: 35,
                                                    backgroundColor:
                                                        Colors.white,
                                                    backgroundImage: profileData
                                                                .advertiserProfile
                                                                .data
                                                                .advertiser
                                                                .image ==
                                                            null
                                                        ? AssetImage(
                                                            'assets/images/user.png')
                                                        : NetworkImage(
                                                            'https://mashghllkw.com/cdn/' +
                                                                profileData
                                                                    .advertiserProfile
                                                                    .data
                                                                    .advertiser
                                                                    .image),
                                                  ),
                                                  SizedBox(
                                                    width: 20.0,
                                                  ),
                                                  Text(
                                                    profileData
                                                        .advertiserProfile
                                                        .data
                                                        .advertiser
                                                        .name,
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          104, 57, 120, 10),
                                                      fontSize: 16.0,
                                                      fontFamily: 'beINNormal',
                                                    ),
                                                  ),
                                                  Spacer(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                )
                              : Consumer<More>(
                                  builder: (context, profileData, child) =>
                                      GestureDetector(
                                    onTap: widget.type == 'user'
                                        ? _goToAccountScreen
                                        : _goToAccountSPScreen,
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          15.0,
                                        ),
                                        color: Colors.grey[200],
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 15.0,
                                        horizontal: 10.0,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 15.0,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            radius: 35,
                                            backgroundColor: Colors.white,
                                            backgroundImage: profileData
                                                        .advertiserProfile
                                                        .data
                                                        .advertiser
                                                        .image ==
                                                    null
                                                ? AssetImage(
                                                    'assets/images/user.png')
                                                : NetworkImage(
                                                    'https://mashghllkw.com/cdn/' +
                                                        profileData
                                                            .advertiserProfile
                                                            .data
                                                            .advertiser
                                                            .image),
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Text(
                                            profileData.advertiserProfile.data
                                                .advertiser.name,
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  104, 57, 120, 10),
                                              fontSize: 16.0,
                                              fontFamily: 'beINNormal',
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                  //-----------------NotificationController---------------------
                  !widget.isAuth
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'غلق الاشعارات',
                                style: TextStyle(
                                  color: Color.fromRGBO(104, 57, 120, 10),
                                  fontSize: 16.0,
                                  fontFamily: 'beINNormal',
                                ),
                              ),
                              Spacer(),
                              Switch(
                                value: switchOn,
                                onChanged: _onSwitchChanged,
                                activeColor: Color.fromRGBO(104, 57, 120, 10),
                              ),
                            ],
                          ),
                        ),
                  //-----------------------------Messages-----------------------
                  !widget.isAuth
                      ? Container()
                      : widget.type == 'user'
                          ? _buildContainer('الرسائل', _goToMessages)
                          : _buildContainer('عمولة التطبيق', _goToAppPayment),
                  //---------------------------AboutApp-------------------------
                  _buildContainer('عن التطبيق', _goToAboutApp),
                  //--------------------------Questions-------------------------
                  _buildContainer('الاسئله الشائعه', _goToQuestions),
                  //----------------------------logout--------------------------
                  GestureDetector(
                    onTap: () => _logout(provider),
                    child: Container(
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
                          30.0,
                        ),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.grey,
                            size: 16.0,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'تسجيل الخروج',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontFamily: 'beINNormal',
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 16.0,
                          )
                        ],
                      ),
                    ),
                  ),
                  //------------------------------------------------------------
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

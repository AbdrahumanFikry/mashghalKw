import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mashghal_co/authScreens/serviceSelectionScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../mainScreens/messagesScreen.dart';
import '../mainScreens/serviceProviderScreens/ordersScreen.dart';
import '../mainScreens/serviceProviderScreens/addItemScreen.dart';
import '../mainScreens/mapScreen.dart';
import '../mainScreens/favouriteScreen.dart';
import '../mainScreens/moreScreen.dart';
import '../mainScreens/reservationScreen.dart';
import '../mainScreens/homePageScreen.dart';
import '../providers/homePageProvider.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BottomNavigationBarScreen extends StatefulWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'bottomNavigationbarScreen';
  final String type;
  final bool isAuth;

  BottomNavigationBarScreen({@required this.type, this.isAuth = true});

  @override
  _BottomNavigationBarScreenState createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  Widget notAuth() {
    return Scaffold(
      body: Center(
          child: Container(
              child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'لا يمكنك استخدام هذا المحتوي قم بتسجيل الدخول',
            style: TextStyle(fontFamily: 'beINNormal'),
          ),
          Divider(
            height: 20,
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.purple[100],
            child:
                Text('تسجيل دخول', style: TextStyle(fontFamily: 'beINNormal')),
            onPressed: () async => SharedPreferences.getInstance().then((pref) {
              pref.clear().then((b) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ServiceSelectionScreen(),
                    ),
                    (Route<dynamic> route) => false);
              });
            }),
          ),
        ],
      ))),
    );
  }

  //------------------------------variables-------------------------------------
  List<Object> _pages;
  int nIndex = 0;
  List<Asset> _images;
  File _video;
  bool _isUploading = false;
  bool isAuth;
  //-------------------------------methods--------------------------------------
  void initState() {
    isAuth = widget.isAuth;

    SharedPreferences.getInstance().then((pref) {
      if (!isAuth) pref.clear();
//      final x = (pref.getString('userData'));
//      print(x);
//      if(x != null)
//      isAuth = json.decode(x)['token'] != null;
//      else
//      widget.type = 'user';
      pref.setBool('isAuth', isAuth);
      setState(() {});
    });

    super.initState();
  }

  //----------------------------Add handler-------------------------------------
  void _jopSelection() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            topLeft: Radius.circular(30.0),
          ),
        ),
        context: context,
        builder: (builder) {
          return Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 5.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(104, 57, 120, 10),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Text(
                  'اختر طريقة الادخال',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'beINNormal',
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddItemScreen()));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 5.0,
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Text(
                        'اضافه خدمات وعروض',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'beINNormal',
                          fontSize: 20.0,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.file_upload,
                        color: Colors.grey,
                        size: 26.0,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: _loadAssets,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Text(
                        'اضافه صور لاعمالك',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'beINNormal',
                          fontSize: 20.0,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.photo,
                        color: Colors.grey,
                        size: 26.0,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: _pickVideo,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Text(
                        'اضافه فيديو لاعمالك',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'beINNormal',
                          fontSize: 20.0,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.videocam,
                        color: Colors.grey,
                        size: 26.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  //---------------------------------load images--------------------------------
  Future<void> _loadAssets() async {
    setState(() {
      _images = List<Asset>();
    });
    List<Asset> resultList = List<Asset>();
    try {
      resultList = (await MultiImagePicker.pickImages(
        enableCamera: true,
        maxImages: 10,
      ));
    } catch (error) {}
    if (!mounted) return;
    setState(() {
      _images = resultList;
    });
    _addWork();
    setState(() {
      _isUploading = true;
    });
    Navigator.of(context).pop();
    Timer(Duration(seconds: 2), () {
      setState(() {
        _isUploading = false;
      });
    });
  }
  //---------------------------------load video---------------------------------

  Future<void> _pickVideo() async {
    try {
      final videoFile =
          await ImagePicker.pickVideo(source: ImageSource.gallery);
      setState(() {
        _video = videoFile;
      });
      _addVideo();
      setState(() {
        _isUploading = true;
      });
      Navigator.of(context).pop();
      Timer(Duration(seconds: 4), () {
        setState(() {
          _isUploading = false;
        });
      });
    } catch (e) {}
  }

  Future<void> _addVideo() async {
    Provider.of<HomePage>(context).addVideo(_video);
  }

  Future<void> _addWork() async {
    Provider.of<HomePage>(context).addWork(_images);
  }

  //--------------------------------build---------------------------------------

  @override
  Widget build(BuildContext context) {
    print(':::::::::::::::::::::::::::::::::::::HomePage');
    _pages = [
      /*******Screens*******/
      HomePageScreen(
        type: widget.type,
        isAuth: isAuth,
      ),
      isAuth ? ReservationScreen() : notAuth(),
      isAuth ? FavouriteScreen() : notAuth(),
      MoreScreen(
        type: widget.type,
        isAuth: isAuth,
      ),
      isAuth ? OrderScreen() : notAuth(),
      isAuth ? MessagesScreen() : notAuth(),
    ];
    final process = Provider.of<HomePage>(context, listen: false).process;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Scaffold(
              backgroundColor: Colors.white,
              body: _pages[nIndex],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height - 102,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: 105,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 30.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/images/bottomNavigationImage.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: IconButton(
                        icon: Image.asset(
                          'assets/icons/home.png',
                          fit: BoxFit.cover,
                        ),
                        onPressed: () {
                          setState(() {
                            nIndex = 0;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: widget.type == 'user'
                          ? IconButton(
                              icon: nIndex == 1
                                  ? Image.asset(
                                      'assets/icons/pa_on.png',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/icons/pa_off.png',
                                      fit: BoxFit.cover,
                                    ),
                              onPressed: () {
                                setState(() {
                                  nIndex = 1;
                                });
                              },
                            )
                          : IconButton(
                              icon: nIndex == 4
                                  ? Image.asset(
                                      'assets/icons/pa_on.png',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/icons/pa_off.png',
                                      fit: BoxFit.cover,
                                    ),
                              onPressed: () {
                                setState(() {
                                  nIndex = 4;
                                });
                              },
                            ),
                    ),
                    Expanded(
                      child: SizedBox(width: 130),
                    ),
                    Expanded(
                      child: widget.type == 'user'
                          ? IconButton(
                              icon: nIndex == 2
                                  ? Image.asset(
                                      'assets/icons/fav.png',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/icons/fav_off.png',
                                      fit: BoxFit.cover,
                                    ),
                              onPressed: () {
                                setState(() {
                                  nIndex = 2;
                                });
                              },
                            )
                          : IconButton(
                              icon: nIndex == 5
                                  ? Image.asset(
                                      'assets/icons/chat_on.png',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/icons/chat.png',
                                      fit: BoxFit.cover,
                                    ),
                              onPressed: () {
                                setState(() {
                                  nIndex = 5;
                                });
                              },
                            ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: nIndex == 3
                            ? Image.asset(
                                'assets/icons/more_on.png',
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/icons/more_off.png',
                                fit: BoxFit.cover,
                              ),
                        onPressed: () {
                          setState(() {
                            nIndex = 3;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: (MediaQuery.of(context).size.width - 70) / 2,
              bottom: 20.0,
              child: widget.type == 'user'
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(MapScreen.routeName);
                      },
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.deepPurple,
                        backgroundImage: AssetImage(
                          'assets/icons/location.png',
                        ),
                      ),
                    )
                  : _isUploading
                      ? CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.deepPurple,
                          backgroundImage: AssetImage(
                            'assets/icons/ellipse.png',
                          ),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : process == '100'
                          ? GestureDetector(
                              onTap: _jopSelection,
                              child: CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.deepPurple,
                                backgroundImage: AssetImage(
                                  'assets/icons/plus.png',
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.grey,
                              backgroundImage: AssetImage(
                                'assets/icons/ellipse.png',
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.file_upload,
                                    color: Colors.white,
                                    size: 18.0,
                                  ),
                                  FittedBox(
                                    child: Text(
                                      process + ' % ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'beINNormal',
                                        fontSize: 16.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
            ),
          ],
        ),
      ),
    );
  }
}

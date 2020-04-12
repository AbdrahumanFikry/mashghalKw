import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mashghal_co/authScreens/verifyCodeScreen.dart';
import 'package:mashghal_co/widgets/googleMaps.dart';
import 'package:mashghal_co/widgets/loader.dart';
import '../authScreens/SPloginScreen.dart';
import '../widgets/backwardWidget.dart';
import '../widgets/submitButton.dart';
import '../widgets/TextFormFieldWidget.dart';
import '../widgets/appLogo.dart';
import '../mainScreens/bottomNavigationbarScreen.dart';
import '../models/httpException.dart';
import '../providers/Auth.dart';
import 'package:provider/provider.dart';
import '../models/daysModel.dart';

class ServiceProviderSignupScreen extends StatefulWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'serviceProviderSignUpScreen';
  final List<Days> days;

  ServiceProviderSignupScreen(this.days);

  @override
  _ServiceProviderSignupScreenState createState() =>
      _ServiceProviderSignupScreenState();
}

class _ServiceProviderSignupScreenState
    extends State<ServiceProviderSignupScreen> {
  //--------------------------------variables-----------------------------------
  LatLng latLng;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  double _lat, _long;
  String _username,
      _phoneNumber,
      _serviceType = '',
      _password,
      _email,
      _address;
  List<String> modelItems = ['صالون', 'منزلى'];
  int _radioVal = 0;

  //----------------------------------methods-----------------------------------
  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GoogleMaps(),
        ));
    setState(() {
      latLng = result[0];
      _lat = latLng.latitude;
      _long = latLng.longitude;
      _address = result[1];
    });
  }

  void _onSavedFirstForm(value) {
    setState(() {
      _username = value;
    });
  }

  void _onSavedSecondForm(value) {
    setState(() {
      _phoneNumber = value;
    });
  }

  void _onSavedForthForm(String type) {
    if (type == 'صالون') {
      setState(() {
        _serviceType = 'salon';
      });
    } else {
      setState(() {
        _serviceType = 'home';
      });
    }
  }

  void _onSavedFifthForm(value) {
    setState(() {
      _password = value;
    });
  }

  void _onSavedEmailForm(value) {
    setState(() {
      _email = value;
    });
  }

  //----------------------------------------------------------------------------
  String _firstValidator(value) {
    if (value.isEmpty) {
      return 'رجاء ادخل اسم المستخدم ';
    }
    return null;
  }

  String _secondValidator(value) {
    if (value.isEmpty || value.length < 5) {
      return 'رقم الجوال غير صحيح';
    }
    return null;
  }

  String _forthValidator(value) {
    if (value.isEmpty || value.length < 5) {
      return 'كلمه المرور قصيره جدا';
    }
    return null;
  }

  String _emailValidator(value) {
    if (value.isEmpty || !value.contains('@')) {
      return 'بريد غير صالح!';
    }
    return null;
  }

  //----------------------------------------------------------------------------
  Widget _showDropDownList() {
    return DropdownButton(
      items: modelItems
          .map(
            (value) => DropdownMenuItem(
              child: Text(value),
              value: value,
            ),
          )
          .toList(),
      onChanged: _onSavedForthForm,
      isExpanded: false,
      hint: Text(
        '  مكان تقديم الخدمة               ' + '' + _serviceType,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
          fontFamily: 'beINNormal',
        ),
      ),
      iconDisabledColor: Colors.white,
      iconEnabledColor: Colors.white,
    );
  }

  //----------------------------------------------------------------------------
  void _signup(provider) async {
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<Auth>(context, listen: false).sPSignUp(
            _lat.toString(),
            _long.toString(),
            _address,
            _username,
            _email,
            _serviceType,
            'advertiser',
            _phoneNumber,
            _password,
            json.encode({'days': widget.days}));
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => VerifyCodeScreen(
              type: true,
              loginType: 'advertiser',
            ),
          ),
        );
        setState(() {
          _isLoading = false;
        });
      } on HttpException catch (error) {
        var errorMessage =
            'لا يمكنك تسجيل الدخول، حاول مره اخرى وتأكد من البيانات';
        if (error.toString().contains('The name has already been taken.')) {
          errorMessage = 'الاسم موجود بالفعل وجرب اسم اخر';
        } else if (error
            .toString()
            .contains('The email has already been taken.')) {
          errorMessage =
              'البريد الالكترونى موجود بالفعل وجرب بريد اخر او تأكد منه مره اخرى ';
        } else if (error
            .toString()
            .contains('The phone has already been taken.')) {
          errorMessage =
              'رقم الجوال موجود بالفعل وجرب رقم اخر او تأكد منه مره اخرى';
        } else if (error
            .toString()
            .contains('Error in sending message to this phone')) {
          errorMessage = 'خطأ فى ارسال رساله لهذا الرقم';
        }
        _showErrorDialog(errorMessage);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        String errorMessage =
            'لا يمكنك تسجيل الدخول، حاول مره اخرى وتأكد من كلمه المرور ورقم الجوال';
        if (error.toString().contains('The name has already been taken.')) {
          errorMessage = 'الاسم موجود بالفعل وجرب اسم اخر';
        } else if (error
            .toString()
            .contains('The email has already been taken.')) {
          errorMessage =
              'البريد الالكترونى موجود بالفعل وجرب بريد اخر او تأكد منه مره اخرى ';
        } else if (error
            .toString()
            .contains('The phone has already been taken.')) {
          errorMessage =
              'رقم الجوال موجود بالفعل وجرب رقم اخر او تأكد منه مره اخرى';
        } else if (error
            .toString()
            .contains('Error in sending message to this phone')) {
          errorMessage = 'خطأ فى ارسال رساله لهذا الرقم';
        }
        _showErrorDialog(errorMessage);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  //---------------------------errorDialog--------------------------------------
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        contentPadding: const EdgeInsets.all(0.0),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(104, 57, 120, 10),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                ),
                child: Text(
                  '! اخطار',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'beINNormal',
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              //---------------------------Body-----------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'beINNormal',
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              //--------------------------ratingBar-------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'حاول مره اخرى',
                      style: TextStyle(
                        color: Color.fromRGBO(104, 57, 120, 10),
                        fontFamily: 'beINNormal',
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------

  void _haveAccountButton() {
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(
        builder: (context) => ServiceProviderLoginScreen(),
      ),
    );
  }

  //----------------------------------build-------------------------------------
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ChangeNotifierProvider(
        builder: (_) => Auth(),
        child: Consumer<Auth>(
          builder: (_, provider, child) => Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              decoration: BoxDecoration(
                color: Colors.purple,
                image: DecorationImage(
                  image: AssetImage('assets/images/authBackgroundImage.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    BackwardWidget(),
                    //--------------------------------------------------------------
                    AppLogoWidget(),
                    //--------------------------------------------------------------
                    Text(
                      'انشاء حساب جديد',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontFamily: 'beINNormal',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    //--------------------------------------------------------------
                    TextFormFieldWidget(
                      labelText: 'اسم المستخدم',
                      isPassword: false,
                      onSaved: _onSavedFirstForm,
                      validator: _firstValidator,
                    ),
                    //--------------------------------------------------------------
                    TextFormFieldWidget(
                      labelText: 'البريد الالكترونى',
                      isPassword: false,
                      onSaved: _onSavedEmailForm,
                      validator: _emailValidator,
                    ),
                    //--------------------------------------------------------------
                    TextFormFieldWidget(
                      labelText: 'رقم الجوال',
                      isPassword: false,
                      isPhone: true,
                      onSaved: _onSavedSecondForm,
                      validator: _secondValidator,
                    ),
                    //--------------------------------------------------------------
                    GestureDetector(
                      onTap: () => _awaitReturnValueFromSecondScreen(context),
                      child: Container(
                        height: 80.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.white,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '      الموقع',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'beINNormal',
                                fontSize: 14.0,
                              ),
                            ),
                            _lat != null
                                ? Text(
                                    _address,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'beINNormal',
                                      fontSize: 12.0,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : Text(
                                    '       قم بتحريك ايقونه الموقع للاختيار او استخدم زر موقعك الحالى',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'beINNormal',
                                      fontSize: 12.0,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                          ],
                        ),
                      ),
                    ),

                    //--------------------------------------------------------------
                    SizedBox(
                      height: 15.0,
                    ),
                    _showDropDownList(),
                    //--------------------------------------------------------------
                    TextFormFieldWidget(
                      labelText: 'كلمة المرور',
                      isPassword: true,
                      onSaved: _onSavedFifthForm,
                      validator: _forthValidator,
                    ),
                    //--------------------------------------------------------------
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 0,
                          groupValue: _radioVal,
                          onChanged: (val) {
                            setState(() {
                              _radioVal = val;
                            });
                          },
                          activeColor: Colors.white,
                        ),
                        Text(
                          'الموافقة على الشروط والاحكام',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontFamily: 'beINNormal',
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    //--------------------------------------------------------------
                    SizedBox(
                      height: 40.0,
                    ),
                    _isLoading
                        ? Container(
                            height: 50.0,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 20.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                30.0,
                              ),
                            ),
                            child: Center(
                              child: ColorLoader(
                                radius: 15.0,
                                dotRadius: 5.0,
                              ),
                            ),
                          )
                        : SubmitButtonWidget(
                            buttonTitle: 'تسجيل',
                            onTab: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              _signup(provider);
                            },
                          ),
                    //--------------------------------------------------------------
                    FlatButton(
                      onPressed: _haveAccountButton,
                      child: Text(
                        'لديك حساب؟تسجيل الدخول',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: 'beINNormal'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

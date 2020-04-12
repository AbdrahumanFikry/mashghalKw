import 'package:flutter/material.dart';
import 'package:mashghal_co/authScreens/verifyCodeScreen.dart';
import 'package:mashghal_co/widgets/loader.dart';
import '../authScreens/userLogin.dart';
import '../widgets/backwardWidget.dart';
import '../widgets/submitButton.dart';
import '../widgets/TextFormFieldWidget.dart';
import '../widgets/appLogo.dart';
import '../providers/Auth.dart';
import 'package:provider/provider.dart';
import '../models/httpException.dart';
import '../mainScreens/bottomNavigationbarScreen.dart';

class UserSignupScreen extends StatefulWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'userSignUpScreen';

  @override
  _UserSignupScreenState createState() => _UserSignupScreenState();
}

class _UserSignupScreenState extends State<UserSignupScreen> {
  //--------------------------------variables-----------------------------------
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _username, _phoneNumber, _password, _email;
  int _radioVal = 0;
  bool _isLoading = false;

  //----------------------------------methods-----------------------------------
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

  void _onSavedThirdForm(value) {
    setState(() {
      _password = value;
    });
  }

  void _onSavedEmailForm(value) {
    setState(() {
      _email = value;
    });
  }

  String _firstValidator(value) {
    if (value.isEmpty) {
      return 'رجاء ادخل اسم المستخدم ';
    }
    return null;
  }

  String _secondValidator(value) {
    if (value.isEmpty || value.length < 9 || value.length > 9) {
      return 'رقم الجوال غير صحصح';
    }
    return null;
  }

  String _thirdValidator(value) {
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
  void _userSignUp(Auth provider) async {
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await provider.userSignUp(
            _username, _email, 'user', _phoneNumber, _password);

//        Navigator.of(context).pushReplacement(
//          MaterialPageRoute(
//            builder: (context) => VerifyCodeScreen(
//              type: true,
//              loginType: 'user',
//            ),
//          ),
//        );
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => VerifyCodeScreen(
                type: true,
                loginType: 'user',
              ),
            ),
            (Route<dynamic> route) => false);
        setState(() {
          _isLoading = false;
        });
      } on HttpException catch (error) {
        print(':::::::::::error::::::::' + error.toString());
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
        }
        _showErrorDialog(errorMessage);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        print(error);
        const errorMessage =
            'لا يمكنك تسجيل الدخول، حاول مره اخرى وتأكد من كلمه المرور ورقم الجوال';
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
        builder: (context) => UserLoginScreen(),
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
                      labelText: 'رقم الجوال',
                      isPassword: false,
                      isPhone: true,
                      onSaved: _onSavedSecondForm,
                      validator: _secondValidator,
                    ),
                    //-------------------------------------------------------------
                    TextFormFieldWidget(
                      labelText: 'البريد الالكترونى',
                      isPassword: false,
                      onSaved: _onSavedEmailForm,
                      validator: _emailValidator,
                    ),
                    //--------------------------------------------------------------
                    TextFormFieldWidget(
                      labelText: 'كلمة المرور',
                      isPassword: true,
                      onSaved: _onSavedThirdForm,
                      validator: _thirdValidator,
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
                              _userSignUp(provider);
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

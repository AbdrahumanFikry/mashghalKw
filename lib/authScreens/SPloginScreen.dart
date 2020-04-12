import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:mashghal_co/authScreens/daysSelectionScreen.dart';
import 'package:mashghal_co/widgets/loader.dart';
import '../mainScreens/bottomNavigationbarScreen.dart';
import '../authScreens/forgivePasswordScreen.dart';
import '../widgets/submitButton.dart';
import '../widgets/TextFormFieldWidget.dart';
import '../widgets/appLogo.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../models/httpException.dart';

class ServiceProviderLoginScreen extends StatefulWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'loginScreen';

  @override
  _ServiceProviderLoginScreenState createState() =>
      _ServiceProviderLoginScreenState();
}

class _ServiceProviderLoginScreenState
    extends State<ServiceProviderLoginScreen> {
  //--------------------------------variables-----------------------------------
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _phoneNumber, _password;
  bool _isLoading = false;

  //----------------------------------methods-----------------------------------
  void _onSavedFirstForm(value) {
    setState(() {
      _phoneNumber = value;
    });
  }

  void _onSavedSecondForm(value) {
    setState(() {
      _password = value;
    });
  }

  String _firstValidator(value) {
    if (value.isEmpty) {
      return 'رجاء ادخل اسم المستخدم ';
    }
    return null;
  }

  String _secondValidator(value) {
    if (value.isEmpty || value.length < 5) {
      return 'كلمه المرور قصيره جدا';
    }
    return null;
  }

  void _forgivePasswordButton() {
    Navigator.of(context).pushNamed(ForgivePasswordScreen.routeName);
  }

  void _login(provider) async {
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await provider.logIn(_phoneNumber, _password, 'advertiser');
//        Navigator.of(context).pop();
//        Navigator.of(context).pushReplacement(
//          MaterialPageRoute(
//            builder: (context) => BottomNavigationBarScreen(type: 'advertiser'),
//          ),
//        );
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) =>
                    BottomNavigationBarScreen(type: 'advertiser')),
            (Route<dynamic> route) => false);
        setState(() {
          _isLoading = false;
        });
      } on HttpException catch (error) {
        var errorMessage =
            'لا يمكنك تسجيل الدخول، حاول مره اخرى وتأكد من كلمه المرور ورقم الجوال';
        if (error.toString().contains('authFailed')) {
          errorMessage =
              'لا يمكنك تسجيل الدخول، حاول مره اخرى وتأكد من كلمه المرور ورقم الجوال';
        }
        _showErrorDialog(errorMessage);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        const errorMessage =
            'لا يمكنك تسجيل الدخول، حاول مره اخرى وتأكد من كلمه المرور ورقم الجوال';
        _showErrorDialog(errorMessage);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

//-----------------------------errorDialog------------------------------------
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
  void _noAccountButton() {
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(
        builder: (context) => DaysSelectionScreen(),
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
                    AppLogoWidget(),
                    //--------------------------------------------------------------
                    Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontFamily: 'beINNormal'),
                      textAlign: TextAlign.center,
                    ),
                    //--------------------------------------------------------------
                    TextFormFieldWidget(
                      labelText: 'رقم الجوال',
                      isPassword: false,
                      isPhone: true,
                      onSaved: _onSavedFirstForm,
                      validator: _firstValidator,
                    ),
                    //--------------------------------------------------------------
                    TextFormFieldWidget(
                      labelText: 'كلمة المرور',
                      isPassword: true,
                      onSaved: _onSavedSecondForm,
                      validator: _secondValidator,
                    ),
                    //--------------------------------------------------------------
                    SizedBox(
                      height: 30.0,
                    ),
                    FlatButton(
                      onPressed: _forgivePasswordButton,
                      child: Text(
                        'هل نسيت كلمة المرور؟',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontFamily: 'beINNormal'),
                      ),
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
                            buttonTitle: 'تسجيل الدخول',
                            onTab: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              _login(provider);
                            },
                          ),
                    //--------------------------------------------------------------
                    FlatButton(
                      onPressed: _noAccountButton,
                      child: Text(
                        'ليس لديك حساب؟انشاء حساب',
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

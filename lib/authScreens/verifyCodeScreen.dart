import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mashghal_co/mainScreens/bottomNavigationbarScreen.dart';
import 'package:mashghal_co/widgets/loader.dart';
import '../authScreens/setNewPasswordScreen.dart';
import '../widgets/appLogo.dart';
import '../widgets/backwardWidget.dart';
import '../widgets/submitButton.dart';
import '../providers/Auth.dart';
import 'package:provider/provider.dart';
import '../models/httpException.dart';

class VerifyCodeScreen extends StatefulWidget {
  final bool type;
  final String loginType;
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'verifyCodeScreen';

  const VerifyCodeScreen({Key key, this.type = false, this.loginType})
      : super(key: key);

  @override
  _VerifyCodeScreenState createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  //--------------------------------variables-----------------------------------
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _verificationCode;
  Timer _timer;
  int _start = 59;
  bool _isLoading = false;

  //----------------------------------methods-----------------------------------
  void _onSavedFirstForm(value) {
    setState(() {
      _verificationCode = value;
    });
  }

  String _firstValidator(value) {
    if (value.isEmpty || value.length < 4) {
      return 'الكود قصير';
    }
    return null;
  }

  //-------------------------reSendVerificationCode-----------------------------
  Future<void> _reSendVerificationCode(provider, String phoneNumber) async {
    setState(() {
      _start = 59;
    });
    startTimer();
    try {
      setState(() {
        _isLoading = true;
      });
      await provider.forgetPassword(phoneNumber);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      const errorMessage =
          'لا يمكنك تسجيل الدخول، حاول مره اخرى تأكد من رقم الجوال';
      _showErrorDialog(errorMessage);
    }
  }

  //---------------------------verificationCode---------------------------------
  Future<void> _send(Auth provider, String phoneNumber) async {
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      try {
        setState(() {
          _isLoading = true;
        });
        if (widget.type)
          await provider.verifyCode(_verificationCode).then((s) {
            print(s);
            if (s != null && s == true)
//              Navigator.of(context).pushReplacement(MaterialPageRoute(
//                  builder: (context) => BottomNavigationBarScreen(
//                        type: widget.loginType,
//                      )));
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => BottomNavigationBarScreen(
                            type: widget.loginType,
                          )),
                  (Route<dynamic> route) => false);
            _isLoading = false;
          });
        else
          await provider.verifyNumber(phoneNumber, _verificationCode).then((s) {
            Navigator.of(context).pushNamed(SetNewPasswordScreen.routeName);
            setState(() {
              _isLoading = false;
            });
          });
      } on HttpException catch (error) {
        print(error);
        _isLoading = false;
        var errorMessage = 'الكود الذى ادخلته غير صحيح';
        if (error.toString().contains('EMAIL_EXISTS')) {
          errorMessage = 'This email address is already in use.';
        }
        _showErrorDialog(errorMessage);
      } catch (error) {
        print(' nt $error');
        _isLoading = false;
        const errorMessage = 'الكود الذى ادخلته غير صحيح';
        _showErrorDialog(errorMessage);
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
                child: Text(
                  message,
                  style: TextStyle(
                    color: Color.fromRGBO(104, 57, 120, 10),
                    fontFamily: 'beINNormal',
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
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
                        fontSize: 14.0,
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
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (!mounted) return;
        setState(() {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        });
      },
    );
  }

  @override
  void didChangeDependencies() {
    startTimer();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  //--------------------------------build---------------------------------------
  @override
  Widget build(BuildContext context) {
    String phoneNumber = ModalRoute.of(context).settings.arguments;
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
                    BackwardWidget(check: true),
                    //----------------------------------------------------------
                    AppLogoWidget(),
                    //----------------------------------------------------------
                    Text(
                      'ادخل كود التحقق',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontFamily: 'beINNormal',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    //----------------------------------------------------------
                    Container(
                      width: 80,
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 100.0,
                      ),
                      child: TextFormField(
                        maxLength: 4,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                        ),
                        onSaved: _onSavedFirstForm,
                        validator: _firstValidator,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0.5,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          filled: true,
                        ),
                      ),
                    ),
                    //----------------------------------------------------------
                    SizedBox(
                      height: 20.0,
                    ),
                    _start != 0
                        ? Text(
                            '00:' + _start.toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                            textAlign: TextAlign.center,
                          )
                        : FlatButton(
                            onPressed: () =>
                                _reSendVerificationCode(provider, phoneNumber),
                            child: Text(
                              'اعادة الارسال',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: 'beINNormal',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                    //----------------------------------------------------------
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
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
                            )),
                          )
                        : SubmitButtonWidget(
                            buttonTitle: 'ارسال',
                            onTab: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              _send(provider, phoneNumber);
                            },
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

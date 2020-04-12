import 'package:flutter/material.dart';
import 'package:mashghal_co/authScreens/serviceSelectionScreen.dart';
import 'package:mashghal_co/widgets/loader.dart';
import '../widgets/backwardWidget.dart';
import '../widgets/appLogo.dart';
import '../widgets/TextFormFieldWidget.dart';
import '../widgets/submitButton.dart';
import 'package:provider/provider.dart';
import '../providers/Auth.dart';
import '../models/httpException.dart';

class SetNewPasswordScreen extends StatefulWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'setNewPasswordScreen';

  @override
  _SetNewPasswordScreenState createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  //--------------------------------variables-----------------------------------
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _password, _confirmedPassword;
  bool _isLoading = false;

  //----------------------------------methods-----------------------------------
  void _onSavedFirstForm(value) {
    setState(() {
      _password = value;
    });
  }

  void _onSavedSecondForm(value) {
    setState(() {
      _confirmedPassword = value;
    });
  }

  String _firstValidator(value) {
    if (value.isEmpty || value.length < 5) {
      return 'كلمه المرور قصيره جدا';
    }
    setState(() {
      _password = value;
    });
    return null;
  }

  String _secondValidator(value) {
    if (value != _password) {
      return 'كلمتان المرور غير متطابقتان';
    }
    return null;
  }

  void _save(provider) async {
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      try {
        setState(() {
          _isLoading = true;
        });
        await provider.changePass(_password, _confirmedPassword);
        Navigator.of(context).pushNamedAndRemoveUntil(
            ServiceSelectionScreen.routeName, (Route<dynamic> route) => false);
        setState(() {
          _isLoading = false;
        });
      } on HttpException catch (error) {
        var errorMessage =
            'لا يمكنك تسجيل الدخول، حاول مره اخرى تأكد من رقم الجوال';
        if (error.toString().contains('EMAIL_EXISTS')) {
          errorMessage = 'This email address is already in use.';
        } else if (error.toString().contains('INVALID_EMAIL')) {
          errorMessage = 'This is not a valid email address';
        }
        _showErrorDialog(errorMessage);
      } catch (error) {
        const errorMessage =
            'لا يمكنك تسجيل الدخول، حاول مره اخرى تأكد من رقم الجوال';
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

  //--------------------------------build---------------------------------------
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
                      'اعادة تعيين كلمة المرور',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    //--------------------------------------------------------------
                    TextFormFieldWidget(
                      labelText: 'كلمة المرور الجديدة',
                      isPassword: true,
                      onSaved: _onSavedFirstForm,
                      validator: _firstValidator,
                    ),
                    //--------------------------------------------------------------
                    TextFormFieldWidget(
                      labelText: 'تأكيد كلمة المرور',
                      isPassword: true,
                      onSaved: _onSavedSecondForm,
                      validator: _secondValidator,
                    ),
                    //--------------------------------------------------------------
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
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
                                dotRadius: 5.0,
                                radius: 15.0,
                              ),
                            ),
                          )
                        : SubmitButtonWidget(
                            buttonTitle: 'حفظ',
                            onTab: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              _save(provider);
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

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../widgets/textFieldEditingWidget.dart';
import 'package:provider/provider.dart';
import '../providers/moreScreenProvider.dart';
import '../widgets/loader.dart';

class EditInfoScreen extends StatefulWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'editInfoScreen';

  @override
  _EditInfoScreenState createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditInfoScreen> {
  //-----------------------------variables--------------------------------------
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _username, _phoneNumber, _password, _confirmedPassword, _email;
  File _image;
  bool _isLoading = false;

  void _editProfile() async {
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<More>(context).editUserProfile(
            _username, _email, _phoneNumber, _image, _confirmedPassword);
        Provider.of<More>(context).fetchAdvertiserProfile();
        Navigator.of(context).pop();
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        const errorMessage =
            'لا يمكنك تعديل البيانات، حاول مره اخرى وتأكد من البيانات';
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
              //----------------------------------------------------------------
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

  //----------------------------imageHandler------------------------------------
  void _imageSelection() {
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
                onTap: _openCamera,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Text(
                        'الكاميرا',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'beINNormal',
                          fontSize: 20.0,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.camera_enhance,
                        color: Colors.grey,
                        size: 26.0,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: _openGallery,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Text(
                        'الاستديو',
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
            ],
          );
        });
  }

   _openCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
    Navigator.of(context).pop();
  }

   _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    Navigator.of(context).pop();
  }

  //--------------------------onSavedMethods------------------------------------
  void _onSavedFirstForm(value) {
    _username = value;
  }

  void _onSavedSecondForm(value) {
    _phoneNumber = value;
  }

  void _onSavedThirdForm(value) {
    _email = value;
  }

  void _onSavedForthForm(value) {
    _password = value;
  }

  void _onSavedFifthForm(value) {
    _confirmedPassword = value;
  }

  // ------------------------------validators-----------------------------------
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

  String _thirdValidator(value) {
    if (value.isEmpty || !value.contains('@')) {
      return 'Invalid email!';
    }
    return null;
  }

  String _forthValidator(value) {
    if (value.isEmpty || value.length < 5) {
      return 'كلمه المرور قصيره جدا';
    }
    setState(() {
      _password = value;
    });
    return null;
  }

  String _fifthValidator(value) {
    if (value != _password) {
      return 'كلمتان المرور غير متطابقتان';
    }
    return null;
  }

  //-------------------------------build----------------------------------------

  @override
  Widget build(BuildContext context) {
    print(':::::::::::::::::::::::::::::::sditInfo');
    final data =
        ModalRoute.of(context).settings.arguments as Map<dynamic, dynamic>;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(235, 218, 241, 10),
          title: Text(
            'تعديل بياناتى',
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
        body: Form(
          key: _formKey,
          child: ListView(
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
                          Color.fromRGBO(104, 57, 120, 10).withOpacity(0.5),
                          Color.fromRGBO(104, 57, 120, 10)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20.0,
                    right: (MediaQuery.of(context).size.width - 120) / 2,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _image != null
                          ? AssetImage(_image.path)
                          : data['image'] == null
                              ? AssetImage('assets/images/user.png')
                              : NetworkImage(
                                  'https://mashghllkw.com/cdn/' + data['image'],
                                ),
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 59,
                        backgroundColor: Colors.black54,
                        child: Center(
                          child: IconButton(
                              icon: Icon(
                                Icons.photo_camera,
                                color: Colors.white30,
                                size: 35.0,
                              ),
                              onPressed: _imageSelection),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              //---------------------------body---------------------------------
              SizedBox(
                height: 50.0,
              ),
              TextFieldEditingWidget(
                labelText: 'اسم المستخدم',
                initialValue: data['name'],
                validator: _firstValidator,
                onSaved: _onSavedFirstForm,
              ),
              TextFieldEditingWidget(
                labelText: 'رقم الجوال',
                initialValue: data['phone'],
                validator: _secondValidator,
                onSaved: _onSavedSecondForm,
              ),
              TextFieldEditingWidget(
                labelText: 'البريد الالكترونى',
                initialValue: data['email'],
                validator: _thirdValidator,
                onSaved: _onSavedThirdForm,
              ),
              TextFieldEditingWidget(
                labelText: 'كلمه المرور',
                initialValue: '',
                validator: _forthValidator,
                onSaved: _onSavedForthForm,
              ),
              TextFieldEditingWidget(
                labelText: 'تأكيد كلمه المرور',
                initialValue: '',
                validator: _fifthValidator,
                onSaved: _onSavedFifthForm,
              ),
              _isLoading
                  ? Container(
                      height: 60,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Center(
                        child: ColorLoader(
                          radius: 15.0,
                          dotRadius: 5.0,
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: _editProfile,
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(104, 57, 120, 10),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Center(
                          child: Text(
                            'تعديل',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'beINNormal',
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

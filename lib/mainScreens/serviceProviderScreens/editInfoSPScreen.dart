import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:mashghal_co/widgets/loader.dart';
import '../../widgets/textFieldEditingWidget.dart';
import 'package:provider/provider.dart';
import '../../providers/moreScreenProvider.dart';
import '../../widgets/googleMaps.dart';

class EditInfoSPScreen extends StatefulWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'editInfoSPScreen';

  @override
  _EditInfoSPScreenState createState() => _EditInfoSPScreenState();
}

class _EditInfoSPScreenState extends State<EditInfoSPScreen> {
  //-------------------------------variables------------------------------------
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File _image;
  List<String> modelItems = ['صالون', 'منزلى'];
  LatLng latLng;
  double _lat, _long;
  bool _isLoading = false;
  String _username,
      _phoneNumber,
      _serviceType = '',
      _password,
      _address,
      _confirmedPassword,
      _email;

  //-----------------------------methods----------------------------------------
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

  void _onSavedFifthForm(value) {
    _password = value;
  }

  void _onSavedSixthForm(value) {
    _confirmedPassword = value;
  }

  void _onSavedServiceLocation(String type) {
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
      return 'البريد الالكترونى غير صحيح';
    }
    return null;
  }

  String _fifthValidator(value) {
    if (value.isEmpty || value.length < 5) {
      return 'كلمه المرور قصيره جدا';
    }
    setState(() {
      _password = value;
    });
    return null;
  }

  String _sixthValidator(value) {
    if (value != _password) {
      return 'كلمتان المرور غير متطابقتان';
    }
    return null;
  }

  Widget _showDropDownList() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: DropdownButton(
        items: modelItems
            .map(
              (value) => DropdownMenuItem(
                child: Text(value),
                value: value,
              ),
            )
            .toList(),
        onChanged: _onSavedServiceLocation,
        isExpanded: false,
        hint: Text(
          '  مكان تقديم الخدمة               ' + '' + _serviceType,
          style: TextStyle(
            color: Color.fromRGBO(104, 57, 120, 10),
            fontSize: 14.0,
            fontFamily: 'beINNormal',
          ),
        ),
        iconDisabledColor: Color.fromRGBO(104, 57, 120, 10),
        iconEnabledColor: Color.fromRGBO(104, 57, 120, 10),
      ),
    );
  }

  Future<void> _editProfile() async {
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      setState(() {
        _isLoading = true;
      });

      try {
        await Provider.of<More>(context, listen: false).editProfile(
            _username,
            _email,
            _phoneNumber,
            _serviceType,
            _image,
//            json.encode(days),
            _confirmedPassword,
            _lat.toString(),
            _long.toString(),
            _address.toString());
        Provider.of<More>(context).fetchAdvertiserProfile();
        Navigator.of(context).pop();
        setState(() {
          _isLoading = false;
        });
      } on HttpException catch (error) {
        var errorMessage =
            'لا يمكنك تعديل البيانات، حاول مره اخرى وتأكد من البيانات';
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
        print(':::::::::::::::::::error:::::::::::::' + error.toString());
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

  //-------------------------------build----------------------------------------

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context).settings.arguments as Map<dynamic, dynamic>;
    setState(() {
      _serviceType = data['service_type'];
      _lat = data['lat'];
      _long = data['long'];
      _address = data['address'];
    });
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
                        backgroundColor: Colors.black26,
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
              GestureDetector(
                onTap: () => _awaitReturnValueFromSecondScreen(context),
                child: Container(
                  height: 80.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromRGBO(104, 57, 120, 10),
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
                          color: Color.fromRGBO(104, 57, 120, 10),
                          fontFamily: 'beINNormal',
                          fontSize: 14.0,
                        ),
                      ),
                      _address != null
                          ? Text(
                              '         ' + _address,
                              style: TextStyle(
                                color: Color.fromRGBO(104, 57, 120, 10),
                                fontFamily: 'beINNormal',
                                fontSize: 12.0,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            )
                          : Text(
                              '        ' + data['address'],
                              style: TextStyle(
                                color: Color.fromRGBO(104, 57, 120, 10),
                                fontFamily: 'beINNormal',
                                fontSize: 12.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: _showDropDownList(),
              ),
              TextFieldEditingWidget(
                labelText: 'كلمه المرور',
                initialValue: '',
                validator: _fifthValidator,
                onSaved: _onSavedFifthForm,
              ),
              TextFieldEditingWidget(
                labelText: 'تأكيد كلمه المرور',
                initialValue: '',
                validator: _sixthValidator,
                onSaved: _onSavedSixthForm,
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

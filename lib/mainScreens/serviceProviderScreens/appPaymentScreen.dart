import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:mashghal_co/widgets/loader.dart';
import 'package:mashghal_co/widgets/textFieldEditingWidget.dart';
import 'package:provider/provider.dart';
import '../../providers/moreScreenProvider.dart';

class AppPaymentScreen extends StatefulWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'appPaymentScreen';

  @override
  _AppPaymentScreenState createState() => _AppPaymentScreenState();
}

class _AppPaymentScreenState extends State<AppPaymentScreen> {
  //--------------------------------variables-----------------------------------
  bool _done = false;
  bool _finish = false;
  File _image;
  bool _isFetching = false;
  bool _loading = false;
  bool _imageDone = false;
  String price, commission;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  Future _openCamera() async {
    setState(() {
      _loading = true;
    });
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
      _imageDone = true;
      _loading = false;
    });
    Navigator.of(context).pop();
  }

  Future _openGallery() async {
    setState(() {
      _loading = true;
    });
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      _imageDone = true;
      _loading = false;
    });
    Navigator.of(context).pop();
  }

  //--------------------------------methods-------------------------------------
  void _onSavedFirstForm(value) {
    price = value;
  }

//  void _onSavedThirdForm(value) {
//    commission = value;
//  }

  String _firstValidator(value) {
    if (value.isEmpty) {
      return 'رجاء ادخل المبلغ';
    }
    return null;
  }

//  String _thirdValidator(value) {
//    if (value.isEmpty) {
//      return 'رجاء ادخل عموله التطبيق';
//    }
//    return null;
//  }

  Future<void> _pay(BuildContext context) async {
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      setState(() {
        _done = true;
      });
    }
  }

  Future<void> _finishAll(BuildContext context) async {
    setState(() {
      _isFetching = true;
    });
    await Provider.of<More>(context, listen: false).commissions(price, _image);
    setState(() {
      _finish = true;
    });
    setState(() {
      _isFetching = false;
    });
  }

  //--------------------------------build---------------------------------------

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(235, 218, 241, 10),
          title: Text(
            'عموله التطبيق',
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
        body: _done
            ? ListView(
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    height: 60.0,
                    width: MediaQuery.of(context).size.width - 100,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7.0,
                      vertical: 5.0,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(235, 218, 241, 10),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        '  المبلغ :   $price  ريال سعودى   ',
                        style: TextStyle(
                          color: Color.fromRGBO(104, 57, 120, 10),
                          fontFamily: 'beINNormal',
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: _imageSelection,
                    child: Container(
                      height: 60.0,
                      width: MediaQuery.of(context).size.width - 100,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7.0,
                        vertical: 5.0,
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: _loading
                          ? ColorLoader(
                              radius: 15.0,
                              dotRadius: 5.0,
                            )
                          : _imageDone
                              ? Row(
                                  children: <Widget>[
                                    Text(
                                      'تم ارفاق صوره الايصال',
                                      style: TextStyle(
                                        color: Color.fromRGBO(104, 57, 120, 10),
                                        fontFamily: 'beINNormal',
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.done,
                                      color: Color.fromRGBO(104, 57, 120, 10),
                                      size: 24.0,
                                    )
                                  ],
                                )
                              : Row(
                                  children: <Widget>[
                                    Text(
                                      'ارفاق صوره الايصال',
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontFamily: 'beINNormal',
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.attach_file,
                                      color: Colors.grey[600],
                                      size: 20.0,
                                    )
                                  ],
                                ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  _isFetching
                      ? Container(
                          height: 60.0,
                          width: 200.0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7.0,
                            vertical: 5.0,
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 30.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: ColorLoader(
                              radius: 10.0,
                              dotRadius: 5.0,
                            ),
                          ),
                        )
                      : _finish
                          ? Container(
                              height: 60.0,
                              width: 200.0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7.0,
                                vertical: 5.0,
                              ),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 30.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Text(
                                  '  العموله   ${Provider.of<More>(context).com}',
                                  style: TextStyle(
                                    color: Color.fromRGBO(104, 57, 120, 10),
                                    fontFamily: 'beINNormal',
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () => _finishAll(context),
                              child: Container(
                                height: 60.0,
                                width: 200.0,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 7.0,
                                  vertical: 5.0,
                                ),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(104, 57, 120, 10),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Text(
                                    'سداد المبلغ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'beINNormal',
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                ],
              )
            : Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 30.0,
                    ),
                    TextFieldEditingWidget(
                      labelText: ''
                          'المبلغ :',
                      initialValue: '',
                      validator: _firstValidator,
                      onSaved: _onSavedFirstForm,
                    ),
//                    TextFieldEditingWidget(
//                      labelText: 'عموله التطبيق:',
//                      initialValue: '',
//                      validator: _thirdValidator,
//                      onSaved: _onSavedThirdForm,
//                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () => _pay(context),
                      child: Container(
                        height: 60.0,
                        width: MediaQuery.of(context).size.width - 100,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7.0,
                          vertical: 5.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(104, 57, 120, 10),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text(
                            'سداد المبلغ',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'beINNormal',
                              fontSize: 18.0,
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

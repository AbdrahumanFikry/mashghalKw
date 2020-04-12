import 'package:flutter/material.dart';
import 'package:mashghal_co/widgets/loader.dart';
import 'package:provider/provider.dart';
import '../../widgets/textFieldEditingWidget.dart';
import '../../providers/homePageProvider.dart';
import '../../models/allServicesDropListModel.dart';
import 'dart:async';

class EditItemScreen extends StatefulWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'editItemScreen';

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  //-------------------------------variables------------------------------------
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String desc, type, price, serviceType = '', offer = '0', selected = ' ';
  List<Services> info = [];
  bool _start = true;
  List<String> modelSheet = [];
  bool _isLoading = false;
  bool _isOffer = false;
  String isOffer = '0';
  String showSelected;
  //---------------------------------methods------------------------------------
  @override
  void initState() {
    Timer(Duration(seconds: 1), () {
      Provider.of<HomePage>(context, listen: false).fetchServicesDropList();
      setState(() {
        _start = false;
      });
    });
    super.initState();
  }

  void _onSwitchChanged(bool value) {
    setState(() {
      _isOffer = !_isOffer;
    });
    if (_isOffer) {
      setState(() {
        isOffer = '1';
      });
    } else {
      isOffer = '0';
    }
  }

  void _onSavedDropList(String type) {
    selected = type;
    showSelected = type;
    setState(() {});
    int index = info.indexWhere((item) => item.name == type);
    serviceType = info[index].id.toString();
  }

  Widget _showDropDownList(List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: DropdownButton(
        iconSize: 15.0,
        elevation: 5,
        style: TextStyle(
          fontFamily: 'beINNormal',
          color: Color.fromRGBO(104, 57, 120, 10),
          fontSize: 12.0,
        ),
        items: items
            .map(
              (value) => DropdownMenuItem(
                child: Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'beINNormal',
                    color: Color.fromRGBO(104, 57, 120, 10),
                    fontSize: 14.0,
                  ),
                  textAlign: TextAlign.end,
                ),
                value: value,
              ),
            )
            .toList(),
        onChanged: _onSavedDropList,
        isExpanded: false,
        hint: Text(
          '  نوع الخدمه:  ${showSelected == null ? selected : showSelected}',
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

  Future<void> _editItem(int id) async {
    final formData = _formKey.currentState;
    if (formData.validate()) {
      formData.save();
      setState(() {
        _isLoading = true;
      });
      await Provider.of<HomePage>(context)
          .updateService(id, serviceType, desc, type, price, isOffer, offer);
      Provider.of<HomePage>(context).fetchAdvertiserServices();
      Provider.of<HomePage>(context).fetchAdvertiserOffers();
      Navigator.of(context).pop();
    }
    setState(() {
      _isLoading = false;
    });
  }

  //--------------------------onSavedMethods------------------------------------
  void _onSavedFirstForm(value) {
    type = value;
  }

  void _onSavedThirdForm(value) {
    price = value;
  }

  void _onSavedForthForm(value) {
    desc = value;
  }

  void _onSavedFifthForm(value) {
    offer = value;
  }

  // ------------------------------validators-----------------------------------
  String _firstValidator(value) {
    if (value.isEmpty) {
      return 'رجاء ادخل اسم الخدمه ';
    }
    return null;
  }

  String _thirdValidator(value) {
    if (value.isEmpty) {
      return 'ادخل سعر الخدمه رجاء';
    }
    return null;
  }

  String _forthValidator(value) {
    return null;
  }

  String _fifthValidator(value) {
    if (value.isEmpty) {
      return 'ادخل قيمة العرض رجاء';
    }
    return null;
  }

  //-------------------------------build----------------------------------------

  @override
  Widget build(BuildContext context) {
    Provider.of<HomePage>(context, listen: false).fetchServicesDropList();
    info = Provider.of<HomePage>(context, listen: false).dropList;
    Provider.of<HomePage>(context, listen: false).dropList.forEach((i) {
      modelSheet.add(i.name);
    });
    final data =
        ModalRoute.of(context).settings.arguments as Map<dynamic, dynamic>;
    serviceType = data['serviceType'];
    data['status'] == 1 ? _isOffer = true : _isOffer = false;
    selected = info.firstWhere((i) => i.id == int.tryParse(serviceType)).name;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(235, 218, 241, 10),
          title: Text(
            'تعديل',
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
              Padding(
                padding: const EdgeInsets.only(top: 30.0, right: 10.0),
                child: _showDropDownList(modelSheet),
              ),
              TextFieldEditingWidget(
                labelText: 'اسم الخدمه:',
                initialValue: data['name'],
                validator: _firstValidator,
                onSaved: _onSavedFirstForm,
              ),
              TextFieldEditingWidget(
                labelText: 'سعر الخدمه:',
                initialValue: data['price'],
                validator: _thirdValidator,
                onSaved: _onSavedThirdForm,
              ),
              TextFieldEditingWidget(
                labelText: 'الوصف:',
                initialValue: data['desc'],
                validator: _forthValidator,
                onSaved: _onSavedForthForm,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      'اضافه الخدمه ضمن العروض',
                      style: TextStyle(
                        color: Color.fromRGBO(104, 57, 120, 10),
                        fontSize: 16.0,
                        fontFamily: 'beINNormal',
                      ),
                    ),
                    Spacer(),
                    Switch(
                      value: _isOffer,
                      onChanged: _onSwitchChanged,
                      activeColor: Color.fromRGBO(104, 57, 120, 10),
                    ),
                  ],
                ),
              ),
              _isOffer == true
                  ? TextFieldEditingWidget(
                      labelText: 'قيمة العرض:',
                      initialValue: data['offer'],
                      validator: _fifthValidator,
                      onSaved: _onSavedFifthForm,
                    )
                  : SizedBox(
                      height: 50.0,
                    ),
              SizedBox(
                height: 50.0,
              ),
              _isLoading
                  ? Container(
                      height: 60,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
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
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _editItem(data['id']);
                      },
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

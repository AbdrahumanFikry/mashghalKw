import 'package:flutter/material.dart';
import 'package:mashghal_co/authScreens/serviceProviderSignUpScreen.dart';
import 'package:mashghal_co/widgets/appLogo.dart';
import '../models/daysModel.dart';
import 'package:xlive_switch/xlive_switch.dart';

class DaysSelectionScreen extends StatefulWidget {
  @override
  _DaysSelectionScreenState createState() => _DaysSelectionScreenState();
}

class _DaysSelectionScreenState extends State<DaysSelectionScreen> {
  //----------------------------variables---------------------------------------
  List<Days> daysList = [
    Days(day: 'sat', endTime: 11, startTime: 9, status: 0),
    Days(day: 'sun', endTime: 11, startTime: 9, status: 0),
    Days(day: 'Mon', endTime: 11, startTime: 9, status: 0),
    Days(day: 'Tue', endTime: 11, startTime: 9, status: 0),
    Days(day: 'wed', endTime: 11, startTime: 9, status: 0),
    Days(day: 'Thu', endTime: 11, startTime: 9, status: 0),
    Days(day: 'Fri', endTime: 11, startTime: 9, status: 0),
  ];

  //-----------------------------methods----------------------------------------
  void _continue() {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => ServiceProviderSignupScreen(daysList),
      ),
    );
  }

  Widget _buildDay(String title, Days day) {
    bool switchOn = false;
    void _onSwitchChanged(bool value) {
      setState(() {
        switchOn = !switchOn;
      });
      if (switchOn) {
        setState(() {
          day.status = 1;
        });
      }
    }

    void _selectTime(String type) async {
      final TimeOfDay picked =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (picked != null) {
        setState(() {
          type != 'start'
              ? day.endTime = picked.hour
              : day.startTime = picked.hour;
        });
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300],
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Color.fromRGBO(104, 57, 120, 10),
              fontSize: 18.0,
              fontFamily: 'beINNormal',
            ),
          ),
          XlivSwitch(
            value: switchOn,
            onChanged: _onSwitchChanged,
            activeColor: Color.fromRGBO(104, 57, 120, 10),
            unActiveColor: Colors.grey[200],
          ),
          Text(
            'من',
            style: TextStyle(
              color: Color.fromRGBO(104, 57, 120, 10),
              fontSize: 18.0,
              fontFamily: 'beINNormal',
            ),
          ),
          GestureDetector(
            onTap: () => _selectTime('start'),
            child: Container(
              width: 50.0,
              height: 30.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  5.0,
                ),
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey[100],
                  width: 0.5,
                ),
              ),
              child: Center(
                child: Text(
                  day.startTime.toString() + ':00',
                  style: TextStyle(
                    color: Color.fromRGBO(104, 57, 120, 10),
                    fontSize: 12.0,
                    fontFamily: 'beINNormal',
                  ),
                ),
              ),
            ),
          ),
          Text(
            'الى',
            style: TextStyle(
              color: Color.fromRGBO(104, 57, 120, 10),
              fontSize: 18.0,
              fontFamily: 'beINNormal',
            ),
          ),
          GestureDetector(
            onTap: () => _selectTime('end'),
            child: Container(
              width: 50.0,
              height: 30.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  5.0,
                ),
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey[100],
                  width: 0.5,
                ),
              ),
              child: Center(
                child: Text(
                  day.endTime.toString() + ':00',
                  style: TextStyle(
                    color: Color.fromRGBO(104, 57, 120, 10),
                    fontSize: 12.0,
                    fontFamily: 'beINNormal',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //-------------------------------build----------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            AppLogoWidget(),
            Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 310,
                  margin: const EdgeInsets.only(
                    bottom: 40.0,
                    left: 15.0,
                    right: 15.0,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                    color: Colors.grey[50],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(5.0, 5.0),
                        blurRadius: 20.0,
                        spreadRadius: 7.0,
                      ),
                    ],
                  ),
                  child: ListView(
                    padding: EdgeInsets.only(top: 10.0, bottom: 25.0),
                    children: <Widget>[
                      _buildDay('السبت', daysList[0]),
                      _buildDay('الاحد', daysList[1]),
                      _buildDay('الاثنين', daysList[2]),
                      _buildDay('الثلاثاء', daysList[3]),
                      _buildDay('الاربعاء', daysList[4]),
                      _buildDay('الخميس', daysList[5]),
                      _buildDay('الجمعه', daysList[6]),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 15.0,
                  right: (MediaQuery.of(context).size.width - 250) / 2,
                  child: GestureDetector(
                    onTap: _continue,
                    child: Container(
                      height: 50.0,
                      width: 250.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          30.0,
                        ),
                        color: Color.fromRGBO(104, 57, 120, 10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(5.0, 5.0),
                            blurRadius: 20.0,
                            spreadRadius: 3.0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'متابعه',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontFamily: 'beINNormal',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

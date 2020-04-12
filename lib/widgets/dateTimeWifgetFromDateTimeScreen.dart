import 'package:flutter/material.dart';

class DateTimeWidget extends StatefulWidget {
  final List<String> days;
  final List<String> hours;

  DateTimeWidget({this.days, this.hours});

  @override
  _DateTimeWidgetState createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  //------------------------------variables-------------------------------------
  String _selectedTime = '';
  String _selectedDate = '';

  //-------------------------------methods--------------------------------------
  void _selectTime(String selectedTime) {
    setState(() {
      _selectedTime = selectedTime;
    });
  }

  void _selectDate(String selectedDate) {
    setState(() {
      _selectedDate = selectedDate;
    });
  }

  //----------------------------build-------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 25.0,
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          width: MediaQuery.of(context).size.width * 0.33,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey[500],
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              items: widget.hours.reversed
                  .map(
                    (value) => DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    ),
                  )
                  .toList(),
              onChanged: _selectTime,
              isExpanded: false,
              hint: FittedBox(
                child: _selectedTime.isEmpty
                    ? FittedBox(
                        child: Text(
                          'اختر الوقت',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                            fontFamily: 'beINNormal',
                          ),
                        ),
                      )
                    : Text(
                        _selectedTime,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                          fontFamily: 'beINNormal',
                        ),
                      ),
              ),
              iconDisabledColor: Colors.grey,
              iconEnabledColor: Colors.grey,
            ),
          ),
        ),
        Container(
          height: 25.0,
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          width: MediaQuery.of(context).size.width * 0.33,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey[500],
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              items: widget.days.reversed
                  .map(
                    (value) => DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    ),
                  )
                  .toList(),
              onChanged: _selectDate,
              isExpanded: false,
              hint: _selectedDate.isEmpty
                  ? FittedBox(
                      child: Text(
                        'اخترالتاريخ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                          fontFamily: 'beINNormal',
                        ),
                      ),
                    )
                  : FittedBox(
                      child: Text(
                        _selectedDate,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                          fontFamily: 'beINNormal',
                        ),
                      ),
                    ),
              iconDisabledColor: Colors.grey,
              iconEnabledColor: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}

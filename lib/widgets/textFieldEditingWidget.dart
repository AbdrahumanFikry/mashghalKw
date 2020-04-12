import 'package:flutter/material.dart';

class TextFieldEditingWidget extends StatefulWidget {
  final String labelText;
  final String initialValue;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  const TextFieldEditingWidget({
    this.labelText,
    this.initialValue,
    this.onSaved,
    this.validator,
  });

  @override
  _TextFieldEditingWidgetState createState() => _TextFieldEditingWidgetState();
}

class _TextFieldEditingWidgetState extends State<TextFieldEditingWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 20.0,
      ),
      child: Column(
        children: <Widget>[
          TextFormField(
            style: TextStyle(
              color: Color.fromRGBO(104, 57, 120, 10),
              fontSize: 14.0,
              fontFamily: 'beINNormal',
            ),
            initialValue: widget.initialValue,
            decoration: InputDecoration(
              labelText: widget.labelText,
              labelStyle: TextStyle(
                color: Color.fromRGBO(104, 57, 120, 10),
                fontFamily: 'beINNormal',
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(104, 57, 120, 10),
                  width: 2.0,
                ),
              ),
            ),
            validator: widget.validator,
            onSaved: widget.onSaved,
          ),
          SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
  }
}

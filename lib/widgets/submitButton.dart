import 'package:flutter/material.dart';

class SubmitButtonWidget extends StatelessWidget {
  final String buttonTitle;
  final Function onTab;

  SubmitButtonWidget({
    @required this.buttonTitle,
    @required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
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
          child: Text(
            buttonTitle,
            style: TextStyle(
              color: Colors.deepPurple,
              fontFamily: 'beINNormal',
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ServiceSelectionWidget extends StatelessWidget {
  final String widgetTitle;
  final String widgetImage;
  final TextAlign textAlign;
  final Function onTab;

  const ServiceSelectionWidget({
    @required this.widgetTitle,
    @required this.widgetImage,
    @required this.textAlign,
    @required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        height: 90,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 50.0,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
            image: AssetImage(widgetImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Text(
          widgetTitle,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontFamily: 'beINNormal',
          ),
          textAlign: textAlign,
        ),
      ),
    );
  }
}

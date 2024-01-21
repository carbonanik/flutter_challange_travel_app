import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/place.dart';

class GradientStatusTag extends StatelessWidget {
  const GradientStatusTag({Key? key, required this.statusTag}) : super(key: key);
  final StatusTag statusTag;

  @override
  Widget build(BuildContext context) {
    String text;
    List<Color> colors;

    switch(statusTag){
      case StatusTag.popular:
        text = 'Popular Place';
        colors = [Colors.cyan, Colors.blue.shade600];
        break;
      case StatusTag.event:
        text = 'Event';
        colors = [Colors.amber, Colors.orange.shade600];
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: colors
        )
      ),
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 16),)
    );
  }
}

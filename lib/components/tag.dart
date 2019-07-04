import 'package:flutter/material.dart';

class TagWidget extends StatelessWidget {
  TagWidget(
      {Key key,
      this.tagList,
      this.tagColor,
      this.tagTextColor,
      this.tagTextSize = 20,
      this.margin,
      this.spacing = 4,
      this.runSpacing = 9});

  final List tagList;
  final Color tagColor;
  final Color tagTextColor;
  final double tagTextSize;
  final EdgeInsetsGeometry margin;
  final double spacing;
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Wrap(
        spacing: spacing,
        runSpacing: runSpacing,
        children: tagList.map((item) => buildTagList(title: item)).toList(),
      ),
    );
  }

  Widget buildTagList({String title}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 9),
      decoration: BoxDecoration(
          color: tagColor, borderRadius: BorderRadius.circular(2)),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(color: tagTextColor, fontSize: 10),
      ),
    );
  }
}

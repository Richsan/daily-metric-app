

import 'package:flutter/material.dart';


class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
    required this.heading,
    this.footerWidgets = const [],
    this.subHeading,
    this.supportingText,
  }) : super(key: key);

  final String heading;
  final String? subHeading;
  final String? supportingText;
  final List<Widget> footerWidgets;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  Text(heading),
                  Spacer(),
                  IconButton(onPressed: () {}, icon: Icon(Icons.edit))
                ],
              ),
              subtitle: subHeading != null ? Text(subHeading!) : null,
              //trailing: Icon(Icons.favorite_outline),
            ),
            if (supportingText != null)
              Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.centerLeft,
                child: Text(supportingText!),
              ),
            Divider(),
            if (footerWidgets.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[...footerWidgets],
                ),
              ),
          ],
        ));
  }
}
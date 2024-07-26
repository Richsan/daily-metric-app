import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
    required this.heading,
    this.footerWidgets = const [],
    this.subHeading = const [],
    this.supportingText,
    this.onTap,
  }) : super(key: key);

  final String heading;
  final List<Widget> subHeading;
  final String? supportingText;
  final List<Widget> footerWidgets;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  Text(heading),
                  Spacer(),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search))
                ],
              ),
              subtitle: Container(
                alignment: Alignment.centerLeft,
                child: Column(children: <Widget>[...subHeading]),
              ),
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
        ),
      ),
    );
  }
}

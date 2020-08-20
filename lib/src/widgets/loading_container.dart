import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),
        ),
        Divider(
          height: 8,
        ),
      ],
    );
  }

  Widget buildContainer() {
    return Container(
      color: Colors.grey[200],
      height: 24,
      margin: EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
    );
  }
}

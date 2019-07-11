import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: _buildGreyBox(),
          subtitle: _buildGreyBox()          
        ),
        Divider(
          height: 8.0,
        )
      ]);
  }

  Widget _buildGreyBox() {
    return Container(
      color: Colors.grey[300],
      height: 24.0,
      width: 150.0,
      margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
    );
  }
}
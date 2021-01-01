import 'package:flutter/material.dart';


class NameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 120,
          ),
          Text('Nice to meet you! What do your friends call you',style: TextStyle(
              fontSize: 30
          ),),
          SizedBox(
            height: 100,
          ),
          TextField(
            style: TextStyle(
              fontSize: 30
            ),
            cursorColor: Colors.red,
            cursorWidth: 2,
            maxLength: 20,
            decoration: InputDecoration(
              helperText: 'Enter your name',
              hintText: 'Your Name',
              border: InputBorder.none,
            ),
          )
        ],
      ),
    );
  }
}

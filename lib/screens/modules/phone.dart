import 'package:flutter/material.dart';


class PhoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

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
            maxLength: 3,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              helperText: 'Country Code',
              hintText: '+91',
              border: InputBorder.none,
            ),
          ),
          TextField(
            style: TextStyle(
                fontSize: 30
            ),
            cursorColor: Colors.red,
            cursorWidth: 2,
            maxLength: 10,
            decoration: InputDecoration(
              helperText: 'Phone number',
              hintText: '999998888',//AppLocalization.of(context).heyWorld,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';


class OtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 120,
          ),
          Text('Enter verification code sent on number',style: TextStyle(
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
              helperText: 'Verification Code',
              hintText: '000000',
              border: InputBorder.none,
            ),
          ),

        ],
      ),
    );
  }
}

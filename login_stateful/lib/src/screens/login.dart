import 'package:flutter/material.dart';
import 'package:http/http.dart' show post;

import '../mixins/validation_mixin.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(children: <Widget>[
          emailField(),
          Container(margin: EdgeInsets.only(top: 25)),
          passwordField(),
          Container(margin: EdgeInsets.only(top: 25)),
          submitButton()
        ]),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
      onSaved: (String value) {
        email = value;
      },
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'you@example.com',
        icon: Icon(Icons.email)
      ),
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      validator: validatePassword,
      onSaved: (String value) {
        password = value;
      },      
      decoration: InputDecoration(
        icon: Icon(Icons.https),
        labelText: 'Password',
        hintText: 'Password',
      ),
    );
  }

  Widget submitButton() {
    return RaisedButton(
      color: Colors.blue,
      onPressed: submitForm,
      child: Text('Submit'),
      textColor: Colors.white,
    );
  }

  void submitForm() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      var response = await post(
        'https://reqres.in/api/login', 
        body: {
          'email': email,
          'password': password
        }
      );

      print(response.body);
    }
  }
}
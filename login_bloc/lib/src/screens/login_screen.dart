import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import '../blocs/provider.dart';

class LoginScreen extends StatelessWidget {
  Widget emailField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'you@example.com',
              labelText: 'Email Address',
              errorText: snapshot.error
            ),
            onChanged: bloc.changeEmail
          );
      },
    );
  }

  Widget passwordField(Bloc  bloc) {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changePassword,
          decoration: InputDecoration(
            hintText: 'Password', 
            labelText: 'Password',
            errorText: snapshot.error
          )
        );
      }
    );
  }

  Widget submitButton(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text('Login'),
          color: Colors.blue,
          elevation: 4.0, 
          onPressed: snapshot.hasData 
            ? bloc.submit
            : null,
        );
      }
    );
  }

  Widget build(BuildContext context) {   
    final bloc = Provider.of(context);

    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(children: <Widget>[
        emailField(bloc),
        Container(margin: EdgeInsets.only(bottom: 25.0)),
        passwordField(bloc),
        Container(margin: EdgeInsets.only(bottom: 25.0)),
        submitButton(bloc)
      ]),
    );
  }
}

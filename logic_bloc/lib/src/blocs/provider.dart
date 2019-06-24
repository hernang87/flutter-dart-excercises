import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
  final _bloc = Bloc();

  Provider({ Key key, Widget child }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) {
    return true;
  } 

  static Bloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._bloc;
  }
}
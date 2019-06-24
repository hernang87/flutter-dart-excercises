import 'package:rxdart/rxdart.dart';
import 'validators.dart';

class Bloc with Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  Function(String) get changeEmail => _email.sink.add;
  Stream<String> get email => _email.stream.transform(validateEmail);

  Function(String) get changePassword => _password.sink.add;
  Stream<String> get password => _password.stream.transform(validatePassword);

  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, password, (e, p) => true);

  void submit() {
    final isValidEmail = _email.value;
    final isValidPassword = _password.value;
  }

  void dispose() {
    _email.close();
    _password.close();
  }
}

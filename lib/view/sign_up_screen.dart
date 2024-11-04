import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_memo/controller/auth_controller.dart';
import 'package:photo_memo/model/signup_screen_model.dart';
import 'package:photo_memo/view/utilities.dart';
import 'package:photo_memo/constant/constant.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  static const routeName = '/signUp';

  @override
  State<StatefulWidget> createState() {
    return _SignUpWidgetState();
  }
}

class _SignUpWidgetState extends State<SignUpWidget> {
  late _Controller con;
  late SignUpScreenModel screenModel;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    con = _Controller(this);
    screenModel = SignUpScreenModel();
  }

  void render(fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  'Create New Account',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter email',
                  ),
                  initialValue: screenModel.email,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: screenModel.validateEmail,
                  onSaved: screenModel.saveEmail,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter password',
                  ),
                  initialValue: screenModel.password,
                  autocorrect: false,
                  obscureText: !screenModel.showPasswords,
                  validator: screenModel.validatePassword,
                  onSaved: screenModel.savePassword,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Confirm password',
                  ),
                  initialValue: screenModel.passwordConfirm,
                  autocorrect: false,
                  obscureText: !screenModel.showPasswords,
                  validator: screenModel.validatePassword,
                  onSaved: screenModel.savePasswordConfirm,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: screenModel.showPasswords,
                      onChanged: con.showHidePasswords,
                    ),
                    const Text('show passwords'),
                  ],
                ),
                ElevatedButton(
                    onPressed: con.create,
                    child: Text(
                      'Create',
                      style: Theme.of(context).textTheme.labelLarge,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _SignUpWidgetState state;
  _Controller(this.state);

  Future<void> create() async {
    FormState? currentState = state.formKey.currentState;
    if (currentState == null || !currentState.validate()) return;
    currentState.save();

    if (state.screenModel.password != state.screenModel.passwordConfirm) {
      showSnackBar(
        context: state.context,
        message: 'passwords do not match',
        seconds: 5,
      );
      return;
    }
    try {
      await Auth.createAccount(
        email: state.screenModel.email!,
        password: state.screenModel.password!,
      );
      // account created!
      if (state.mounted) {
        Navigator.of(state.context).pop(); // go back
      }
    } on FirebaseAuthException catch (e) {
      if (Constant.devMode) print('==== failed to create: $e');
      showSnackBar(
          context: state.context,
          message: '${e.code} ${e.message}',
          seconds: 5);
    } catch (e) {
      if (Constant.devMode) print('==== failed to create: $e');
      showSnackBar(context: state.context, message: 'failed to create: $e');
    }
  }

  void showHidePasswords(bool? value) {
    if (value != null) {
      state.render(() {
        state.screenModel.showPasswords = value;
      });
    }
  }
}

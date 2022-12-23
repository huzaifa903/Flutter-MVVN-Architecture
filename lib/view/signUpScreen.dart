import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resources/components/rounded_button.dart';
import '../utils/general_utils.dart';
import '../utils/routes/routesName.dart';
import '../view_model/authViewModel.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();

  ValueNotifier<bool> togglePass = ValueNotifier<bool>(true);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passController.dispose();

    emailFocus.dispose();
    passFocus.dispose();

    togglePass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up Screen"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            focusNode: emailFocus,
            onFieldSubmitted: (value) {
              Utils.focusFormField(context, emailFocus, passFocus);
            },
            decoration: const InputDecoration(
              hintText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),
          //
          const SizedBox(height: 10),
          //
          ValueListenableBuilder(
            valueListenable: togglePass,
            builder: (context, value, child) {
              return TextFormField(
                controller: _passController,
                focusNode: passFocus,
                obscureText: togglePass.value,
                obscuringCharacter: '*',
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: () {
                      togglePass.value = !togglePass.value;
                    },
                    icon: togglePass.value
                        ? const Icon(Icons.visibility_off_outlined)
                        : const Icon(Icons.remove_red_eye_outlined),
                  ),
                ),
              );
            },
          ),
          //
          const SizedBox(height: 30),
          //
          RoundedButton(
            title: 'Sign Up',
            loading: authProvider.signUploading,
            onPress: () {
              if (_emailController.text.isEmpty) {
                Utils.customSnackBar("Please Insert Email", context);
              } else if (_passController.text.isEmpty) {
                Utils.customSnackBar("Password Required", context);
              } else if (_passController.text.length < 6) {
                Utils.customSnackBar(
                    "Password lenght should be atleast or greater than 6",
                    context);
              } else {
                if (kDebugMode) {
                  print("API hit");
                }
                Map data = {
                  'email': _emailController.text.toString(),
                  'password': _passController.text.toString(),
                };
                authProvider.registerApiModel(data, context);
              }
            },
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.login);
            },
            child: const Text("Already have na account? Login"),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/utils/routes/routesName.dart';
import 'package:flutter_mvvm_architecture/view/homeScreen.dart';
import 'package:flutter_mvvm_architecture/view/loginScreen.dart';
import 'package:flutter_mvvm_architecture/view/signUpScreen.dart';
import 'package:flutter_mvvm_architecture/view/splashScreen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case RoutesName.signUp:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());

      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      default:
        {
          return MaterialPageRoute(builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text("No Routes Defined"),
              ),
            );
          });
        }
    }
  }
}

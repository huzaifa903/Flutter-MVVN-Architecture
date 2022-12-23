import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/view_model/services/splashServices.dart';
import 'package:flutter_mvvm_architecture/view_model/userViewModel.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashServices _splashServices = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _splashServices.checkAuthenticate(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 100,
          style: FlutterLogoStyle.stacked,
        ),
      ),
    );
  }
}

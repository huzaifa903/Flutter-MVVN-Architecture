import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/utils/routes/routes.dart';
import 'package:flutter_mvvm_architecture/utils/routes/routesName.dart';
import 'package:flutter_mvvm_architecture/view/loginScreen.dart';
import 'package:flutter_mvvm_architecture/view_model/authViewModel.dart';
import 'package:flutter_mvvm_architecture/view_model/userViewModel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: RoutesName.splashScreen,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}

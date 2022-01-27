import 'package:data_app_motiva/providers/registration_privider.dart';
import 'package:data_app_motiva/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Registrations(),
        ),
      ],
      child: MaterialApp(
        title: 'Motiva Task',
        home: const WelcomeScreen(),
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
      ),
    );
  }
}

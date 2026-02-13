import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/addEvent/add_event.dart';
import 'package:evently/intro/intro.dart';
import 'package:evently/onboarding/onboarding.dart';
import 'package:evently/auth/register.dart';
import 'package:evently/provider/app_provider.dart';
import 'package:evently/provider/auth_provider.dart';
import 'package:evently/theme/theme.dart';
import 'package:evently/provider/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase/firebase_options.dart';
import 'home/home.dart';
import 'auth/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),

          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => AppProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    var authProvider = context.watch<AuthProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: MyTheme.light,
      darkTheme: MyTheme.dark,
      themeMode: themeProvider.themeMode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      // initialRoute: authProvider.firebaseUser != null
      //     ? Home.routName
      //     :Onboarding.routName,
      initialRoute:Home.routName,
      routes: {
        Onboarding.routName: (context) => Onboarding(),
        Intro.routName: (context) => Intro(),
        Home.routName: (context) => Home(),
        Login.routName: (context) => Login(),
        Register.routName: (context) => Register(),
        AddEvent.routName: (context) => AddEvent(),
      },
    );
  }
}

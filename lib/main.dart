import 'package:club8/Onboarding/onboarding.dart';
import 'package:club8/Splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Experience/experience.dart';
import 'Experience/experience_bloc.dart';
void main() {
  runApp(
    BlocProvider(
      create: (_) => ExperienceBloc(),
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voice Recorder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const Experience(),
      debugShowCheckedModeBanner: false,
    );
  }
}

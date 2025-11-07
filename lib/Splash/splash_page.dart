import 'package:club8/Experience/experience.dart';
import 'package:flutter/material.dart';
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState(){
    super.initState();
  Future.delayed(Duration(seconds: 3),(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Experience()));
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset("Assets/img.png"),
      ),
    );
  }
}

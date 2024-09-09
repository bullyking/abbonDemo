import 'package:abbon_demo/features/app_layout/screen/app_layout.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    onInit();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  onInit() async {}

  @override
  Widget build(BuildContext context) {
    return const AppLayout();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_project/models/formprovider.dart';
import 'package:flutter_project/views/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const CoDoctor());
}

class CoDoctor extends StatelessWidget {
  const CoDoctor({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CoDoctorProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(child: LoginScreen(),),
      ),
    );
  }
}

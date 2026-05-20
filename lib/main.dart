import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

// Widget stateless vuol dire che non ha uno stato interno che cambia, è un widget che dipende solo dai dati che riceve
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context)
   {
    return MaterialApp(
      title: 'Ambulatorio Polispecialistico A. Tuscano',
      theme: ThemeData( primarySwatch: Colors.blue),
      home: const HomeScreen(), // comincia da home screen
    );
  }
}
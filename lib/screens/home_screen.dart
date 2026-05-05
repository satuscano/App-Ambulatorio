import 'package:flutter/material.dart';
import 'pazienti_screen.dart';
import 'esami_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ambulatorio")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              child: const Text("Pazienti"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PazientiScreen()),
                );
              },
            ),
            ElevatedButton(
              child: const Text("Esami"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EsamiScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'pazienti_screen.dart';
import 'esami_screen.dart';

class HomeScreen extends StatelessWidget {
  // "costruisco" la schermata home
  const HomeScreen({super.key}); // super.key è un parametro richiesto usato per identificare univocamente il widget

  // creo il metodo build che restituisce la schermata da mostrare
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ambulatorio")), // "navbar"
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton( // pulsante pazienti
              child: const Text("Pazienti"),
              onPressed: () {
                Navigator.push(
                  context,
                  // MaterialPageRoute serve per navigare tra le schermate
                  // il builder è una funzione che restituisce la schermata da mostrare
                  // const PazientiScreen() è la schermata da mostrare quando si preme il pulsante (contenuta in pazienti_screen.dart)
                  // (_) è un parametro required ma non usato
                  MaterialPageRoute(builder: (_) => const PazientiScreen()),
                );
              },
            ),
            ElevatedButton( // pulsante esami
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
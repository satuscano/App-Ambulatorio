import 'package:flutter/material.dart';
import '../entities/paziente.dart';

class DettaglioPazienteScreen extends StatelessWidget {
  final Paziente paziente; // creo una variabile per ricevere i dati del paziente

  // costruisco la schermata di dettaglio del paziente
  // required this.paziente serve per ricevere i dati del paziente dalla schermata precedente, passata tramite il costruttore
  const DettaglioPazienteScreen({super.key, required this.paziente});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(paziente.fullName)), // mostro il nome del paziente come titolo della schermata
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("CF: ${paziente.codiceFiscale}"),
            Text("Nascita: ${paziente.dataNascita}"),
            const SizedBox(height: 10), // aggiungo uno spazio di 10 px
            Text("Anamnesi: ${paziente.anamnesi ?? 'N/A'}"),
            const SizedBox(height: 20),
            Text("Indirizzo:"),
            // i ?? servono per mostrare una stringa vuota se i dati dell'indirizzo sono nulli
            Text("${paziente.indVia ?? ''} ${paziente.indCivico ?? ''}"),
            Text("${paziente.indCap ?? ''} ${paziente.indCitta ?? ''}"),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../entities/paziente.dart';

class DettaglioPazienteScreen extends StatelessWidget {
  final Paziente paziente;

  const DettaglioPazienteScreen({super.key, required this.paziente});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(paziente.fullName)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("CF: ${paziente.codiceFiscale}"),
            Text("Nascita: ${paziente.dataNascita}"),
            const SizedBox(height: 10),
            Text("Anamnesi: ${paziente.anamnesi ?? 'N/A'}"),
            const SizedBox(height: 20),
            Text("Indirizzo:"),
            Text("${paziente.indVia ?? ''} ${paziente.indCivico ?? ''}"),
            Text("${paziente.indCap ?? ''} ${paziente.indCitta ?? ''}"),
          ],
        ),
      ),
    );
  }
}
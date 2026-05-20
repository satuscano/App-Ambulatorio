import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../../entities/paziente.dart';
import 'dettaglio_paziente.dart';

class PazientiScreen extends StatefulWidget {
  const PazientiScreen({super.key});

  @override
  // createState() serve per creare lo stato associato a questo widget (PazientiScreen)
  // lo stato di un widget è una classe che contiene i dati e la logica per gestire il widget stesso
  State<PazientiScreen> createState() => _PazientiScreenState();
}

class _PazientiScreenState extends State<PazientiScreen> {
  List<Paziente> pazienti = [];
  bool loading = true;

  // La funzione load() è una funzione asincrona che recupera i dati dei pazienti dall'API e aggiorna lo stato del widget
  void load() async {
    // chiama il metodo getPazienti() dell'ApiService per ottenere la lista dei pazienti
    final data = await ApiService.getPazienti();

    // aggiorna lo stato del widget con i dati ottenuti e imposta loading a false
    // se il loading è true mostra un indicatore di caricamento
    setState(() {
      pazienti = data ?? [];
      loading = false;
    });
  }

  @override
  // initState() viene chiamato quando il widget viene creato per la prima volta
  void initState() {
    super.initState();
    load(); // chiama la funzione load() --> inizializzaizone del widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pazienti")),
      body: loading // body: loading serve per mostrare un indicatore di caricamento mentre i dati vengono recuperati dall'API
          ? const Center(child: CircularProgressIndicator()) // stile del caricatore
          : ListView.builder( // ListView.builder fa in modo di mostrare solo i valori che sono visibili (ottimizzazione)
              itemCount: pazienti.length, // specifica il numero di elementi da mostrare nella lista
              itemBuilder: (context, index) { // itemBuilder è una funzione che costruisce ogni elemento della lista
                final p = pazienti[index]; // riempie la lista con i dati dei pazienti ottenuti dall'API

                return ListTile(
                  title: Text(p.fullName),
                  subtitle: Text(p.codiceFiscale),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DettaglioPazienteScreen(paziente: p),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
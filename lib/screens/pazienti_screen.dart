import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../entities/paziente.dart';
import 'dettaglio_paziente_screen.dart';

class PazientiScreen extends StatefulWidget {
  const PazientiScreen({super.key});

  @override
  State<PazientiScreen> createState() => _PazientiScreenState();
}

class _PazientiScreenState extends State<PazientiScreen> {
  List<Paziente> pazienti = [];
  bool loading = true;

  void load() async {
    final data = await ApiService.getPazienti();

    setState(() {
      pazienti = data ?? [];
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pazienti")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: pazienti.length,
              itemBuilder: (context, index) {
                final p = pazienti[index];

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
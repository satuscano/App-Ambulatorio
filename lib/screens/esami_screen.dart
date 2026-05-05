import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../entities/esame.dart';

class EsamiScreen extends StatefulWidget {
  const EsamiScreen({super.key});

  @override
  State<EsamiScreen> createState() => _EsamiScreenState();
}

class _EsamiScreenState extends State<EsamiScreen> {
  List<Esame> esami = [];
  bool loading = true;
  bool error = false;

  void loadEsami() async {
    setState(() {
      loading = true;
      error = false;
    });

    final data = await ApiService.getEsami();

    if (data != null) {
      setState(() {
        esami = data;
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
        error = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadEsami();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Esami"),
        actions: [
          IconButton(
            onPressed: loadEsami,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error) {
      return const Center(child: Text("Errore caricamento esami"));
    }

    if (esami.isEmpty) {
      return const Center(child: Text("Nessun esame disponibile"));
    }

    return ListView.builder(
      itemCount: esami.length,
      itemBuilder: (context, index) {
        final e = esami[index];

        return Card(
          child: ListTile(
            title: Text("Medico: ${e.codiceMedico}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("CF: ${e.codiceFiscale}"),
                Text("Diagnosi: ${e.diagnosi}"),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.description),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Referto"),
                    content: Text(e.referto),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Chiudi"),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
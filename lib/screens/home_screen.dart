import 'dart:math';

import 'package:appcontatti_finalefinale/web_api.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../entities/esame.dart';
import 'dettagli.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Random r = Random();
  bool isDowloading = false;
  bool isError = false;
  List<Esame> esami = [];

  void downloadEsame() async {
    setState(() {
      isDowloading = true;
      isError = false;
    });

    final esamiDalServer = await WebApi.getEsami();

    setState(() {
      isDowloading = false;
      if (esamiDalServer != null) {
        esami = esamiDalServer;
      } else {
        isError = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    downloadEsame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tarassaco',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 191, 0, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: _makeBody(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var nuovoEsame = await Navigator.of(context).push<Esame>(
            MaterialPageRoute(
              builder: (context) => DettagliScreen(),
            ),
          );

          if (nuovoEsame != null) {
            final idNuovoEsame =
                await WebApi.nuovoEsame(nuovoEsame);

            if (idNuovoEsame != -1) {
              setState(() {
                esami.insert(
                  0,
                  Esame(
                    codiceEsame: idNuovoEsame,
                    codiceAmbulatorio: nuovoEsame.codiceAmbulatorio,
                    codiceMedico: nuovoEsame.codiceMedico,
                    codiceFiscale: nuovoEsame.codiceFiscale,
                    diagnosi: nuovoEsame.diagnosi,
                    referto: nuovoEsame.referto,
                  ),
                );
              });
            } else {
              await showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text('Errore 1'),
                    content: const Text(
                        'Errore durante l\'aggiunta dell\'esame'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      )
                    ],
                  );
                },
              );
            }
          }
        },
        child: const Text('+'),
      ),
    );
  }

  Widget _makeBody() {
    if (isDowloading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(child: Text('ERRORE nel caricamento'));
    }

    return ListView.builder(
      itemCount: esami.length,
      itemBuilder: (context, index) {
        final esame = esami[index];

        return ListTile(
          onTap: () async {
            final esameAggiornato = await Navigator.of(context).push<Esame>(
              MaterialPageRoute(
                builder: (context) => DettagliScreen(esame: esame),
              ),
            );

            if (esameAggiornato != null) {
              if (esameAggiornato.codiceAmbulatorio !=
                      esame.codiceAmbulatorio ||
                  esameAggiornato.codiceMedico != esame.codiceMedico ||
                  esameAggiornato.codiceFiscale != esame.codiceFiscale ||
                  esameAggiornato.diagnosi != esame.diagnosi ||
                  esameAggiornato.referto != esame.referto) {
                final risultato =
                    await WebApi.updateEsame(esameAggiornato);

                if (risultato) {
                  setState(() {
                    esami[index] = esameAggiornato;
                  });
                } else {
                  await showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text('Errore 2'),
                        content: const Text(
                            'Errore durante l\'aggiornamento'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          )
                        ],
                      );
                    },
                  );
                }
              }
            }
          },
          onLongPress: () async {
            final conferma = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Sei sicuro?'),
                  content: const Text(
                      'Questo esame verrà cancellato definitivamente'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text('Conferma'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text('Annulla'),
                    ),
                  ],
                );
              },
            );

            if (conferma == true) {
              final risultato =
                  await WebApi.deleteEsame(esame.codiceEsame);

              if (risultato) {
                setState(() {
                  esami.removeAt(index);
                });
              }
            }
          },
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Color.fromARGB(
              255,
              r.nextInt(256),
              r.nextInt(256),
              r.nextInt(256),
            ),
            child: Text(
              esame.codiceMedico.substring(0, 1),
              style: const TextStyle(fontSize: 20),
            ),
          ),
          title: Text(
            'Medico: ${esame.codiceMedico}',
            style: const TextStyle(fontSize: 18),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CF: ${esame.codiceFiscale}'),
              Text('Diagnosi: ${esame.diagnosi}'),
            ],
          ),
          trailing: IconButton(
            onPressed: () {
              _showReferto(esame.referto);
            },
            icon: const Icon(Icons.description),
          ),
        );
      },
    );
  }

  void _showReferto(String referto) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Referto'),
          content: Text(referto),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Chiudi'),
            )
          ],
        );
      },
    );
  }
}
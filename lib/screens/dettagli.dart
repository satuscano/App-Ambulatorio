import 'package:flutter/material.dart';
import '../entities/esame.dart';

class DettagliScreen extends StatefulWidget{
  final Esame? esame;
  const DettagliScreen({this.esame, super.key});
  @override
  State<DettagliScreen> createState() => _DettagliScreenState();
}

class _DettagliScreenState extends State<DettagliScreen>{
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    //Nuovo esame
    var titolo = "Nuovo esame";
    var codiceEsame = 0;
    var codiceAmbulatorio = 0;
    var codiceMedico = "";
    var codiceFiscale = "";
    var diagnosi = "";
    var referto = "";
    if(widget.esame != null){
      titolo = "Modifica esame";
      codiceEsame = widget.esame!.codiceEsame;
      codiceAmbulatorio = widget.esame!.codiceAmbulatorio;
      codiceMedico = widget.esame!.codiceMedico;
      codiceFiscale = widget.esame!.codiceFiscale;
      diagnosi = widget.esame!.diagnosi;
      referto = widget.esame!.referto;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(titolo),
        actions: [
          IconButton(
              onPressed: (){
                if(_formKey.currentState!.validate()){
                  final esame = Esame(
                      codiceEsame: codiceEsame,
                      codiceAmbulatorio: codiceAmbulatorio,
                      codiceMedico: codiceMedico.trim(),
                      codiceFiscale: codiceFiscale.trim(),
                      diagnosi: diagnosi.trim(),
                      referto: referto.trim());
                  Navigator.of(context).pop(esame);
                }
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              TextFormField(
                initialValue: codiceEsame.toString(),
                decoration: InputDecoration(labelText: 'Codice Esame'),
                onChanged: (value) {
                  codiceEsame = int.tryParse(value) ?? 0;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserire il codice esame';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: codiceAmbulatorio.toString(),
                decoration: InputDecoration(labelText: 'Codice Ambulatorio'),
                onChanged: (value) {
                  codiceAmbulatorio = int.tryParse(value) ?? 0;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserire il codice ambulatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: codiceMedico,
                decoration: InputDecoration(labelText: 'Codice Medico'),
                onChanged: (value) {
                  codiceMedico = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserire il codice medico';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: codiceFiscale,
                decoration: InputDecoration(labelText: 'Codice Fiscale'),
                onChanged: (value) {
                  codiceFiscale = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserire il codice fiscale';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: diagnosi,
                decoration: InputDecoration(labelText: 'Diagnosi'),
                onChanged: (value) {
                  diagnosi = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserire la diagnosi';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: referto,
                decoration: InputDecoration(labelText: 'Referto'),
                onChanged: (value) {
                  referto = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserire il referto';
                  }
                  return null;
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lenci Diet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Informações do usuário'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

    String? dropdownSexo;
    String? dropdownAtvFisica;
    int alturaUsuario = 0;
    double pesoUsuario = 0.0;
    int idadeUsuario = 0;
    double tmb = 0.0;
    double ndc = 0.0;

  void _calcTMB(int alt, double peso, int idade, var sexo){
    setState(() {
      if(sexo == 'Homem'){
        tmb = 66 + 13.7 * peso + 5 * alt - 6.8 * idade;
      }
      if(sexo == 'Mulher'){
        tmb = 655 + 9.6 * peso + 1.8 * alt + 4.7 * idade;
      }
    });
  }

    void _calcNDC(var atvfisica){
      setState(() {
        if(atvfisica == 'Nenhuma atividade física'){
          ndc = tmb * 1.2;
        }
        if(atvfisica == 'Atividade física leve'){
          ndc = tmb * 1.375;
        }
        if(atvfisica == 'Atividade física moderada'){
          ndc = tmb * 1.55;
        }
        if(atvfisica == 'Atividade física intensa'){
          ndc = tmb * 1.725;
        }
      });
    }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Text(
                'Insira suas informações:',
                style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 30
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: DropdownButton<String>(
                value: dropdownSexo,
                icon: const Icon(Icons.arrow_downward),
                items: <String?>['Homem', 'Mulher']
                    .map<DropdownMenuItem<String>>((String? value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value ?? "",
                      style: const TextStyle(fontSize: 20),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownSexo = newValue;
                  });
                },
                hint: const Text("Sexo"),
                ),
              ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: DropdownButton<String?>(
            hint: const Text("Nível de atividade física diária"),
            value: dropdownAtvFisica,
            icon: const Icon(Icons.arrow_downward),
            items: <String?>['Nenhuma atividade física', 'Atividade física leve', 'Atividade física moderada', 'Atividade física intensa']
                .map<DropdownMenuItem<String>>((String? value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value ?? "",
                  style: const TextStyle(fontSize: 20),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownAtvFisica = newValue;
              });
            },
          ),
        ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                onChanged: (text) {
                  alturaUsuario = int.parse(text);
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Altura (cm)',
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                onChanged: (text) {
                  pesoUsuario = double.parse(text);
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Peso (kg)',
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                onChanged: (text) {
                  idadeUsuario = int.parse(text);
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Idade',
                ),
              ),
            ),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                _calcTMB(alturaUsuario, pesoUsuario, idadeUsuario, dropdownSexo);
                _calcNDC(dropdownAtvFisica);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MySecondPage(tmb, ndc)));
              },
              child: Text('CALCULAR DIETA'),
            ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}

class MySecondPage extends StatefulWidget {
  double tmb = 0.0;
  double ndc = 0.0;
  MySecondPage(this.tmb, this. ndc);

  @override
  State<MySecondPage> createState() => _MySecondPageState();
}

  class _MySecondPageState extends State<MySecondPage> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Calorias para dieta'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: Text('TMB:        NDC:\n${widget.tmb}     ${widget.ndc}'),
        ),
      );
    }
  }



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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

    String dropdownValue = 'Homem';
    int alturaUsuario = 0;
    double pesoUsuario = 0.0;
    int idadeUsuario = 0;
    double tmb = 0;

  void _calcTMB(int alt, double peso, int idade, var sexo){
    setState(() {
      if(sexo == 'Homem'){
        tmb = 66 + 13.8 * peso + 5 * alt - 6.8 * idade;
      }
      if(sexo == 'Mulher'){
        tmb = 655 + 9.6 * peso + 1.8 * alt + 4.7 * idade;
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
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                items: <String>['Homem', 'Mulher']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 20),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
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
                _calcTMB(alturaUsuario, pesoUsuario, idadeUsuario, dropdownValue);
              },
              child: Text('CALCULAR DIETA'),
            ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Text(
                '$tmb',
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}


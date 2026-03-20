import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final mensalController = TextEditingController();
  final mesesController = TextEditingController();
  final jurosController = TextEditingController();

  double semJuros = 0;
  double comJuros = 0;

  InputDecoration campo(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  void calcular() {
    double mensal = double.tryParse(mensalController.text) ?? 0;
    int meses = int.tryParse(mesesController.text) ?? 0;
    double juros = (double.tryParse(jurosController.text) ?? 0) / 100;

    double totalSem = mensal * meses;
    double totalCom = 0;

    for (int i = 0; i < meses; i++) {
      totalCom = (totalCom + mensal) * (1 + juros);
    }

    setState(() {
      semJuros = totalSem;
      comJuros = totalCom;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Investimento"),
          backgroundColor: Colors.green,
        ),
        body: Container(
          color: Colors.green.shade50,
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 8),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: mensalController,
                    decoration: campo("Valor mensal"),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: mesesController,
                    decoration: campo("Meses"),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: jurosController,
                    decoration: campo("Juros (%)"),
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: calcular,
                    child: const Text("Simular"),
                  ),

                  const SizedBox(height: 20),

                  Text("Sem juros: R\$ ${semJuros.toStringAsFixed(2)}"),
                  Text("Com juros: R\$ ${comJuros.toStringAsFixed(2)}"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:kelola_duwit/pages/list_cashflow.dart';
import 'package:kelola_duwit/pages/login.dart';
import 'package:kelola_duwit/pages/setting.dart';
import 'package:kelola_duwit/pages/input_cash_flow.dart';
import 'package:flutter/material.dart';
import 'package:kelola_duwit/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const LoginPage(),
      routes: {
        '/pemasukan': (context) => const InputCashFlowPage(type: 'pemasukan'),
        '/pengeluaran': (context) => const InputCashFlowPage(
              type: 'pengeluaran',
            ),
        '/cashFlow': (context) => const CashFlowPage(),
        '/pengaturan': (context) => const PengaturanPage(),
      },
    );
  }
}

import 'package:kelola_duwit/models/cash_flow.dart';
import 'package:kelola_duwit/models/menu.dart';
import 'package:kelola_duwit/sqlite/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/graph_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<Menu> _listMenu = [
  Menu(
    name: 'Tambah Pemasukan',
    icon: 'assets/income.png',
    route: '/pemasukan',
  ),
  Menu(
    name: 'Tambah Pengeluaran',
    icon: 'assets/profits.png',
    route: '/pengeluaran',
  ),
  Menu(
    name: 'Detail Cashflow',
    icon: 'assets/cashflow.png',
    route: '/cashFlow',
  ),
  Menu(
    name: 'Pengaturan',
    icon: 'assets/gear.png',
    route: '/pengaturan',
  ),
];
final formatter = NumberFormat("#,##0.00", "en_US");

class _HomePageState extends State<HomePage> {
  int _pengeluaran = 0;
  int _pemasukan = 0;

  late DataHelper dataHelper;
  int count = 0;

  @override
  void initState() {
    dataHelper = DataHelper();
    initData();
    super.initState();
  }

  void initData() async {
    List<CashFlow> listCashFlow = await dataHelper.selectCashFlow();
    for (CashFlow cashFlow in listCashFlow) {
      if (cashFlow.type == 0) {
        _pemasukan += cashFlow.amount!;
      } else {
        _pengeluaran += cashFlow.amount!;
      }
    }
    dataHelper.close();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: const Text(
                'Rangkuman Bulan Ini',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                'Pengeluaran: Rp ${formatter.format(_pengeluaran)}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.redAccent, fontSize: 20),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                'Pemasukan: Rp ${formatter.format(_pemasukan)}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 20),
              ),
            ),
            SizedBox(
              height: height / 3,
              child: const GraphCard(),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                height: height - 280,
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                  children: <Widget>[
                    for (Menu menu in _listMenu)
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, menu.route!);
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Image.asset(menu.icon!,
                                      width: height / 5)),
                              Text(
                                menu.name!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

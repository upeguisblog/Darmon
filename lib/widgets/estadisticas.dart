//import 'package:animate_do/animate_do.dart';
import 'package:app_3/services/auth_services.dart';
import 'package:app_3/theme/app_theme.dart';
import 'package:app_3/widgets/mes_widget.dart';
import 'package:flutter/material.dart';
//import 'package:app_3/widgets/widgets.dart';
import 'package:provider/provider.dart';
//import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatisticPage extends StatefulWidget {
  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  Widget _bottonAction(IconData icon) {
    return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Icon(icon, color: AppTheme.primary),
        ),
        onTap: () {});
  }

  late PageController _controller;
  int currentPage = 9;
  late Stream<QuerySnapshot> _query;

  @override
  void initState() {
    super.initState();

    _query = FirebaseFirestore.instance
        .collection('gastos')
        .where('mes', isEqualTo: currentPage + 1)
        .snapshots();
    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.4,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    Widget _pageItem(String name, int position) {
      var _aligment;
      final selected = TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.blueGrey);
      final unselected = TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.normal,
          color: Colors.blueGrey.withOpacity(0.4));
      if (position == currentPage) {
        _aligment = Alignment.center;
      } else if (position > currentPage) {
        _aligment = Alignment.centerRight;
      } else {
        _aligment = Alignment.centerLeft;
      }
      return Align(
          alignment: _aligment,
          child: Text(
            name,
            style: position == currentPage ? selected : unselected,
          ));
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                authService.logout();
                Navigator.pushReplacementNamed(context, 'home');
              },
              icon: Icon(Icons.home_outlined))
        ],
        backgroundColor: AppTheme.primary,
        centerTitle: true,
        title: Text('Estadísticas del mes'),
      ),
      bottomNavigationBar: BottomAppBar(
          notchMargin: 10,
          shape: CircularNotchedRectangle(),
          color: Colors.white,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _bottonAction(Icons.bar_chart),
              _bottonAction(Icons.pie_chart)
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add_circle,
          color: AppTheme.primary,
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, 'añadirgasto');
        },
      ),
      body: //_body(),
          SafeArea(
        child: Column(
          children: [
            SizedBox.fromSize(
              size: Size.fromHeight(70.0),
              child: PageView(
                  onPageChanged: (newPage) {
                    setState(() {
                      currentPage = newPage;

                      _query = FirebaseFirestore.instance
                          .collection('gastos')
                          .where('mes', isEqualTo: currentPage + 1)
                          .snapshots();
                    });
                  },
                  controller: _controller,
                  children: [
                    _pageItem('Enero', 0),
                    _pageItem('Febrero', 1),
                    _pageItem('Marzo', 2),
                    _pageItem('Abril', 3),
                    _pageItem('Mayo', 4),
                    _pageItem('Junio', 5),
                    _pageItem('Julio', 6),
                    _pageItem('Agosto', 7),
                    _pageItem('Septiembre', 8),
                    _pageItem('Octubre', 9),
                    _pageItem('Noviembre', 10),
                    _pageItem('Diciembre', 11),
                  ]),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _query,
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
                if (data.hasData) {
                  return MesWidget(docs: data.data!.docs);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

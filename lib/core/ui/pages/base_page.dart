import 'package:flutter/material.dart';
import 'package:vocab/features/query_word/presentation/widgets/query_word_body.dart';
import 'package:vocab/features/word_card/presentation/widgets/word_card_body.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key key}) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  List<Widget> _bodyWidgets;
  int _selectedTab;

  @override
  void initState() {
    super.initState();
    _selectedTab = 0;
    _bodyWidgets = [QueryWordBody(), WordCardBody()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            title: Text('Oxford Dictionary'),
            icon: Icon(Icons.book),
          ),
          BottomNavigationBarItem(
            title: Text('Words API'),
            icon: Icon(Icons.credit_card),
          ),
        ],
        currentIndex: _selectedTab,
        onTap: (int value) {
          setState(() => _selectedTab = value);
        },
      ),
      body: _bodyWidgets[_selectedTab],
    );
  }
}

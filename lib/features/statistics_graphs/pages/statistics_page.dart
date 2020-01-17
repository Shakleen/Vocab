import 'package:flutter/material.dart';
import 'package:vocab/core/navigation/routes.dart';
import 'package:vocab/core/ui/widgets/app_title.dart';
import 'package:vocab/core/ui/widgets/side_drawer.dart';
import 'package:vocab/features/statistics_graphs/widgets/quiz_statistics_tab.dart';
import 'package:vocab/features/statistics_graphs/widgets/word_statistics_tab.dart';

class StatisticsPage extends StatefulWidget {
  StatisticsPage({Key key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage>
    with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTitle(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            tooltip: 'Info',
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _controller,
          tabs: <Widget>[
            Tab(child: Text('Word stats')),
            Tab(child: Text('Quiz stats')),
          ],
        ),
      ),
      drawer: SideDrawer(page: Page.StatisticsPage),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[WordStatisticsTab(), QuizStatisticsTab()],
      ),
    );
  }
}

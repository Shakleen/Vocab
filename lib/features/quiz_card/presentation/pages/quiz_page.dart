import 'package:flutter/material.dart';
import 'package:vocab/core/navigation/routes.dart';
import 'package:vocab/core/ui/widgets/app_title.dart';
import 'package:vocab/core/ui/widgets/side_drawer.dart';
import 'package:vocab/features/statistics_graphs/mastery_level_stat.dart';
import 'package:vocab/features/statistics_graphs/quiz_heatmap.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTitle(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {},
            tooltip: "Help!",
          )
        ],
      ),
      drawer: SideDrawer(page: Page.QuizPage),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        tooltip: "Take quiz",
        onPressed: () {
          Navigator.pushNamed(context, '${Page.TakeQuizPage}');
        },
      ),
      body: ListView(
        children: <Widget>[
          MasteryLevelStats(),
          QuizHeatmap(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:vocab/core/entities/pronunciation.dart';
import 'package:vocab/core/entities/syllable.dart' as s;
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/entities/word_card_details.dart';
import 'package:vocab/core/navigation/routes.dart';
import 'package:vocab/core/ui/widgets/app_title.dart';
import 'package:vocab/core/ui/widgets/side_drawer.dart';
import 'package:provider/provider.dart';
import 'package:vocab/features/word_card_save/data/data_source/card_database.dart';

class CardPage extends StatefulWidget {
  CardPage({Key key}) : super(key: key);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, initialIndex: 0, vsync: this);
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
            icon: Icon(Icons.add),
            tooltip: 'Add new word entry',
            onPressed: () {
              Navigator.pushNamed(context, '${Page.CardFormPage}', arguments: _buildWordCard());
            },
          ),
        ],
        bottom: TabBar(
          controller: _controller,
          tabs: <Widget>[
            Tab(text: 'Statistics'),
            Tab(text: 'Saved'),
          ],
        ),
      ),
      drawer: SideDrawer(page: Page.CardPage),
      body: Provider(
        create: (BuildContext context) => CardDatabase(),
        child: TabBarView(
          controller: _controller,
          children: <Widget>[Container(), ViewSavedWords()],
        ),
      ),
    );
  }
}

class ViewSavedWords extends StatelessWidget {
  const ViewSavedWords({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<CardDatabase>(context).wordDao.getSavedWords(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(title: Text(snapshot.data[index]));
              },
            );
          }
        }

        return Container();
      },
    );
  }
}

WordCard _buildWordCard() {
  return WordCard(
    word: "race",
    detailList: [
      WordCardDetails(
        definition: "compete in a race",
        partOfSpeech: "verb",
        synonymList: ["run"],
        exampleList: ["let's race and see who gets there first"],
      ),
      WordCardDetails(
        definition:
            "the flow of air that is driven backwards by an aircraft propeller",
        partOfSpeech: "noun",
        synonymList: ["airstream", "backwash", "slipstream", "wash"],
      ),
      WordCardDetails(
        definition: "cause to move fast or to rush or race",
        partOfSpeech: "verb",
        synonymList: ["rush"],
        exampleList: ["The psychologist raced the rats through a long maze"],
      ),
      WordCardDetails(
        definition: "move hurridly",
        partOfSpeech: "verb",
        synonymList: [
          "belt along",
          "bucket along",
          "cannonball along",
          "hasten",
          "hie",
          "hotfoot",
          "pelt along",
          "rush",
          "rush along",
          "speed",
          "step on it"
        ],
        exampleList: ["The cars raced down the street"],
      ),
      WordCardDetails(
        definition: "a canal for a current of water",
        partOfSpeech: "noun",
        synonymList: ["raceway"],
      ),
      WordCardDetails(
        definition:
            "(biology) a taxonomic group that is a division of a species; usually arises as a consequence of geographical isolation within a species",
        partOfSpeech: "noun",
        synonymList: ["subspecies"],
      ),
      WordCardDetails(
        definition: "a contest of speed",
        partOfSpeech: "noun",
        exampleList: ["the race is to the swift"],
      ),
      WordCardDetails(
        definition: "any competition",
        partOfSpeech: "noun",
        exampleList: ["the race for the presidency"],
      ),
      WordCardDetails(
        definition:
            "people who are believed to belong to the same genetic stock",
        partOfSpeech: "noun",
        exampleList: [
          "some biologists doubt that there are important genetic differences between races of human beings"
        ],
      ),
      WordCardDetails(
        definition:
            "to work as fast as possible towards a goal, sometimes in competition with others",
        partOfSpeech: "verb",
      ),
    ],
    syllables: s.Syllable(count: 1, list: ["race"]),
    pronunciation: Pronunciation(all: "res"),
  );
}

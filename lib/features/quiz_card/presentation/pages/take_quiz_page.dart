import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocab/core/ui/widgets/app_title.dart';
import 'package:provider/provider.dart';
import 'package:vocab/core/ui/widgets/notifier.dart';
import 'package:vocab/features/quiz_card/domain/entities/quiz_card.dart';
import 'package:vocab/features/quiz_card/presentation/bloc/bloc.dart';
import 'package:vocab/features/quiz_card/presentation/widgets/back_widget.dart';
import 'package:vocab/features/quiz_card/presentation/widgets/front_widget.dart';
import 'package:vocab/features/quiz_card/presentation/widgets/select_quiz_card_limit.dart';

import '../../../../injection_container.dart';

class TakeQuizPage extends StatefulWidget {
  const TakeQuizPage({Key key}) : super(key: key);

  @override
  _TakeQuizPageState createState() => _TakeQuizPageState();
}

class _TakeQuizPageState extends State<TakeQuizPage> {
  QuizBloc _bloc = sl();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _bloc,
      child: BlocBuilder<QuizBloc, QuizState>(
        bloc: _bloc,
        builder: (BuildContext context, QuizState state) {
          return Scaffold(
            appBar: AppBar(
              title: AppTitle(),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.undo),
                  onPressed: () => _bloc.add(UndoAnswerQuizEvent()),
                  tooltip: "Undo last answer",
                ),
              ],
            ),
            body: _buildBody(state),
          );
        },
      ),
    );
  }

  Widget _buildBody(QuizState state) {
    Widget _body;
    if (state is InitQuizState) {
      _body = SelectQuizCardLimit();
    } else if (state is LoadingQuizState) {
      _body = Center(child: CircularProgressIndicator());
    } else if (state is ShowCardFrontState) {
      _body = _OnlyFront(quizCard: state.quizCard);
    } else if (state is ShowFullCardState) {
      _body = _FullCard(quizCard: state.quizCard);
    } else if (state is NoDueCardsQuizState) {
      _body = Notifier(
        text: "All caught up!",
        color: Colors.green,
        icon: Icons.done,
      );
    } else if (state is FinishedQuizState) {
      _body = Notifier(
        text: "Yay! Quizzed finished!",
        color: Colors.blue,
        icon: Icons.tag_faces,
      );
    } else if (state is ErrorQuizState) {
      _body = Notifier(
        text: state.message,
        color: Colors.red,
        icon: Icons.clear,
      );
    }
    return _body;
  }
}



class _OnlyFront extends StatelessWidget {
  final QuizCard quizCard;

  const _OnlyFront({Key key, @required this.quizCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(flex: 1, child: FrontWidget(quizCard: quizCard)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text("Reveal"),
            ),
            textTheme: ButtonTextTheme.primary,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Provider.of<QuizBloc>(context, listen: false)
                  .add(RevealCardQuizEvent());
            },
          ),
        ),
      ],
    );
  }
}

class _FullCard extends StatelessWidget {
  final QuizCard quizCard;

  const _FullCard({Key key, @required this.quizCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        FrontWidget(quizCard: quizCard),
        Divider(color: Colors.grey, height: 2, thickness: 2),
        Expanded(child: BackWidget(quizCard: quizCard)),
        ButtonBar(
          buttonMinWidth: 100,
          buttonHeight: 65,
          alignment: MainAxisAlignment.spaceAround,
          buttonTextTheme: ButtonTextTheme.primary,
          children: <Widget>[
            RaisedButton(
              child: Text(
                "Again\n(1 min)",
                textAlign: TextAlign.center,
              ),
              color: Colors.red,
              onPressed: () {
                Provider.of<QuizBloc>(context, listen: false).add(
                  AnswerCardQuizEvent(cardID: quizCard.id),
                );
              },
            ),
            RaisedButton(
              child: Text(
                "Good\n${_getTime()}",
                textAlign: TextAlign.center,
              ),
              color: Colors.green,
              onPressed: () {
                Provider.of<QuizBloc>(context, listen: false).add(
                  AnswerCardQuizEvent(
                    cardID: quizCard.id,
                    level: quizCard.level + 1,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  String _getTime() {
    final int level = quizCard.level;

    if (level == 0) {
      return "10 minutes";
    } else if (level == 1) {
      return "1 day";
    } else if (level < 15) {
      return "${2 * level - 1} days";
    } else {
      final double time = (level / 15);
      return "${time.toStringAsFixed(1)} months";
    }
  }
}

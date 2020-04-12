import 'package:flutter/material.dart';
import 'package:mashghal_co/widgets/loader.dart';
import 'package:provider/provider.dart';
import '../providers/moreScreenProvider.dart';

class QuestionsScreen extends StatelessWidget {
  // variable to ref screen name to routes in main.dart and Navigation
  static const routeName = 'questionsScreen';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(235, 218, 241, 10),
          title: Text(
            'الاسئله الشائعه',
            style: TextStyle(
              color: Color.fromRGBO(104, 57, 120, 10),
              fontSize: 20.0,
              fontFamily: 'beINNormal',
            ),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color.fromRGBO(104, 57, 120, 10),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: FutureBuilder(
            future: Provider.of<More>(context, listen: false).fetchQuestions(),
            builder: (context, data) {
              if (data.connectionState == ConnectionState.waiting) {
                return Center(
                  child: ColorLoader(
                    radius: 20.0,
                    dotRadius: 5.0,
                  ),
                );
              } else {
                if (data.error != null) {
                  return Center(
                    child: Text('An error occurred !' ),
                  );
                } else {
                  return Consumer<More>(
                    builder: (context, q, child) => ListView.builder(
                      itemCount: q.question.data.questions.length,
                      itemBuilder: (context, index) {
                        return QuestionReview(
                          question: q.question.data.questions[index].question,
                          answer: q.question.data.questions[index].answer,
                        );
                      },
                    ),
                  );
                }
              }
            }),
      ),
    );
  }
}

//------------------------------------------------------------------------------
class QuestionReview extends StatelessWidget {
  final String question;
  final String answer;

  QuestionReview({this.question, this.answer});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: Colors.grey[100],
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              question,
              style: TextStyle(
                color: Color.fromRGBO(104, 57, 120, 10),
                fontSize: 18.0,
                fontFamily: 'beINNormal',
              ),
            ),
            Text(
              answer,
              style: TextStyle(
                color: Color.fromRGBO(104, 57, 120, 10),
                fontSize: 14.0,
                fontFamily: 'beINNormal',
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../data/model/trivia_model.dart';


class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.answers, required this.onTap, required this.triviaModel});

  final List<String> answers; // User-provided answers
  final void Function() onTap; // Restart callback
  final TriviaModel triviaModel; // Trivia data

  List<Map<String, Object>> getSummary() {
    List<Map<String, Object>> summary = [];
    for (var i = 0; i < answers.length; i++) {
      summary.add({
        'index': i + 1,
        'question': triviaModel.results![i].question.toString(),
        'correct_answer': triviaModel.results![i].correctAnswer.toString(),
        'user_answer': answers[i],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummary();
    int score = summaryData
        .where((question) => question['user_answer'] == question['correct_answer'])
        .length;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Text(
              'You answered $score out of ${triviaModel.results!.length} correctly!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: summaryData.length,
                itemBuilder: (context, index) {
                  final data = summaryData[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: (data['user_answer'] == data['correct_answer'])
                          ? Colors.green
                          : Colors.red,
                      foregroundColor: Colors.white,
                      radius: 30,
                      child: Text(
                        '${data['index']}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    title: Text(
                      data['question'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Answer: ${data['user_answer']}',
                          style: TextStyle(
                            color: (data['user_answer'] == data['correct_answer'])
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        if (data['user_answer'] != data['correct_answer'])
                          Text(
                            'Correct Answer: ${data['correct_answer']}',
                            style: const TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            OutlinedButton.icon(
              onPressed: onTap,
              icon: const Icon(Icons.restart_alt_outlined),
              label: const Text('Restart Quiz'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

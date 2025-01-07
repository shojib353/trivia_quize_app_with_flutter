import 'package:flutter/material.dart';
import 'package:untitled1/data/model/trivia_model.dart';

import '../widgets/option.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({
    super.key,
    required this.onOptionSelected,
    required this.triviaModel,
  });

  final TriviaModel triviaModel;
  final void Function(String) onOptionSelected;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  var currentIndex = 0;
  List<String> allOptions = [];

  void _onOptionSelected(String answer) {
    widget.onOptionSelected(answer);

    // Move to the next question
    setState(() {
      currentIndex++;
      if (currentIndex == widget.triviaModel.results!.length) {
        currentIndex = 0; // Reset to the first question
      }
      _prepareOptions(); // Refresh options for the new question
    });
  }

  void _prepareOptions() {
    // Prepare options for the current question
    allOptions = [
      widget.triviaModel.results![currentIndex].correctAnswer!,
      ...widget.triviaModel.results![currentIndex].incorrectAnswers!,
    ];
    allOptions.shuffle(); // Shuffle options
  }

  @override
  void initState() {
    super.initState();
    _prepareOptions(); // Prepare options for the first question
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Display the question
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            widget.triviaModel.results![currentIndex].question ?? "No question",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),

        // Display the options
        ...allOptions.map(
              (option) => Option(
            text: option,
            onTap: () {
              _onOptionSelected(option);
            },
          ),
        ),
      ],
    );
  }
}




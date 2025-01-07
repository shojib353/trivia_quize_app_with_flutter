import 'package:flutter/material.dart';
import 'package:untitled1/core/utils/constants/urls.dart';
import 'package:untitled1/data/model/trivia_model.dart';
import 'package:untitled1/presentation/screen/question_screen.dart';
import 'package:untitled1/presentation/screen/result_screen.dart';
import 'package:untitled1/presentation/screen/start_screen.dart';
// import 'package:untitled1/presentation/screen/result_screen.dart'; // Uncomment when implemented
import '../../core/services/api_service.dart';

class QuizeScreen extends StatefulWidget {
  const QuizeScreen({super.key});

  @override
  State<QuizeScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizeScreen> {
  Widget? currentScreen;
  List<String> userAnswers = [];
  bool isLoading = true;
  final ApiService _apiService = ApiService();
  late TriviaModel triviaModel;

  // Fetch trivia data from the API
  void _loadTriviaData() async {
    final data = await _apiService.fetchData(getUrl);
    triviaModel = TriviaModel.fromJson(data);
    isLoading = false;
    setState(() {});
  }

  // Switch from StartScreen to QuestionScreen
  void switchScreen() {
    setState(() {
      currentScreen = QuestionScreen(
        triviaModel: triviaModel,
        onOptionSelected: _addAnswers,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _loadTriviaData();
    currentScreen = StartScreen(onPressed: switchScreen);
  }

  // Add selected answers to userAnswers
  void _addAnswers(String answer) {
    userAnswers.add(answer);
    print("User Answers: $userAnswers");
    if (userAnswers.length == triviaModel.results!.length) {
      
      currentScreen = ResultScreen(
        answers: userAnswers,
        onTap: restartQuiz, triviaModel: triviaModel,
      );



      setState(() {});
    }
  }

  // Restart quiz
  void restartQuiz() {
    userAnswers.clear();
    currentScreen = StartScreen(onPressed: switchScreen);
    _loadTriviaData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : currentScreen,
    );
  }
}

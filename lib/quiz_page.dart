import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the capital of France?',
      'answers': ['Berlin', 'Madrid', 'Paris', 'Rome'],
      'correctAnswer': 'Paris'
    },
    {
      'question': 'What is the largest planet in our solar system?',
      'answers': ['Earth', 'Mars', 'Jupiter', 'Saturn'],
      'correctAnswer': 'Jupiter'
    },
    {
      'question': 'What is the chemical symbol for water?',
      'answers': ['O2', 'H2O', 'CO2', 'NaCl'],
      'correctAnswer': 'H2O'
    },
    {
      'question': 'What is the speed of light?',
      'answers': ['300,000 km/s', '150,000 km/s', '1,000,000 km/s', '50,000 km/s'],
      'correctAnswer': '300,000 km/s'
    },
    {
      'question': 'What is the main ingredient in guacamole?',
      'answers': ['Tomato', 'Avocado', 'Pepper', 'Onion'],
      'correctAnswer': 'Avocado'
    },
    {
      'question': 'Who wrote "To Kill a Mockingbird"?',
      'answers': ['Harper Lee', 'Mark Twain', 'Ernest Hemingway', 'F. Scott Fitzgerald'],
      'correctAnswer': 'Harper Lee'
    },
    {
      'question': 'What is the tallest mountain in the world?',
      'answers': ['K2', 'Kangchenjunga', 'Everest', 'Lhotse'],
      'correctAnswer': 'Everest'
    },
    {
      'question': 'What is the powerhouse of the cell?',
      'answers': ['Nucleus', 'Ribosome', 'Mitochondria', 'Golgi apparatus'],
      'correctAnswer': 'Mitochondria'
    },
    {
      'question': 'What planet is known as the Red Planet?',
      'answers': ['Earth', 'Venus', 'Mars', 'Jupiter'],
      'correctAnswer': 'Mars'
    },
    {
      'question': 'What is the largest mammal in the world?',
      'answers': ['Elephant', 'Blue Whale', 'Giraffe', 'Great White Shark'],
      'correctAnswer': 'Blue Whale'
    },
  ];

  List<String?> selectedAnswers = List<String?>.filled(10, null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            return _buildQuestionCard(index);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showResults,
        child: Icon(Icons.check),
      ),
    );
  }

  Widget _buildQuestionCard(int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              questions[index]['question'],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...questions[index]['answers'].map<Widget>((answer) {
              return RadioListTile<String>(
                title: Text(answer),
                value: answer,
                groupValue: selectedAnswers[index],
                onChanged: (value) {
                  setState(() {
                    selectedAnswers[index] = value;
                  });
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _showResults() {
    int score = 0;
    String resultDescription;

    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i]['correctAnswer']) {
        score++;
      }
    }

    if (score >= 7) {
      resultDescription = 'Congratulations! You passed the quiz.';
    } else {
      resultDescription = 'Unfortunately, you failed. Better luck next time!';
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Results'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Your Score: $score/${questions.length}'),
              SizedBox(height: 10),
              Text(resultDescription),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                setState(() {
                  selectedAnswers = List<String?>.filled(10, null); // Reset answers
                });
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:untitled1/presentation/screen/quize_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(


        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          SizedBox(width: double.infinity,),
          ElevatedButton(onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const QuizeScreen()),
            );
          }, child: Text("Quize"))
        ],
      ),
    );
  }
}

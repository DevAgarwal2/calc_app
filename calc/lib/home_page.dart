import 'package:calc/my_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var user_q = "";
  var user_a = "";
  final List<String> buttons = [
    "C",
    "Del",
    "%",
    "/",
    "9",
    "8",
    "7",
    "X",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "="
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      body: Column(children: [
        Expanded(
            child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      user_q,
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
              SizedBox(
                height: 50,
              ),
              Container(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      user_a,
                      style: TextStyle(fontSize: 20),
                    ),
                  ))
            ],
          ),
        )),
        Expanded(
            flex: 2,
            child: Container(
                child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return MyButton(
                      buttonTap: () {
                        setState(() {
                          user_q = '';
                        });
                      },
                      color: Colors.green,
                      textColor: Colors.white,
                      text: buttons[index]);
                } else if (index == 1) {
                  return MyButton(
                      buttonTap: () {
                        setState(() {
                          user_q = user_q.substring(0, user_q.length - 1);
                        });
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      text: buttons[index]);
                } else if (index == buttons.length - 1) {
                  return MyButton(
                    buttonTap: (){
                      setState(() {
                        equal_button();
                        
                      });
                    },
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      text: buttons[index]);
                }
                return MyButton(
                    buttonTap: () {
                      setState(() {
                        user_q += buttons[index];
                      });
                    },
                    color: operator(buttons[index])
                        ? Colors.deepPurple
                        : Colors.deepPurple[50],
                    textColor: operator(buttons[index])
                        ? Colors.white
                        : Colors.deepPurple,
                    text: buttons[index]);
              },
            )))
      ]),
    );
  }

  bool operator(String check) {
    if (check == "+" ||
        check == "-" ||
        check == "/" ||
        check == "%" ||
        check == "X" ||
        check == "=") {
      return true;
    } else {
      return false;
    }
  }
  void equal_button(){
    String final_question = user_q;
    final_question = final_question.replaceAll("X", "*");

     Parser p = Parser();
  Expression exp = p.parse(final_question);
  ContextModel cm = ContextModel();
  double eval = exp.evaluate(EvaluationType.REAL, cm);
  user_a = eval.toString();
  
  }
}

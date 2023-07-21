import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 240, 86, 192),
            title: const Row(
              children: [
                Icon(
                  Icons.task,
                  size: 40,
                ),
                SizedBox(
                  width: 20,
                ),
                Text('ToDos')
              ],
            )),
        // add out main functionality widgets on the app body
        body: const Todo(), //stateful class to implement todo
      ),
    );
  }
}

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _Todostate();
}

class _Todostate extends State<Todo> {
  String _textFieldValue = ''; // var text input to the filed
  List<String> todos = []; //array list to save input texts

  bool textfieldvalue = false; //bool variable to listen to the text inputfield
  final TextEditingController _controller =
      TextEditingController(); //controller for textfield

  // method to implement adding textinput to the todo list
  void _addtodo() {
    setState(() {
      todos.add(('$_textFieldValue ')); //adds last input at the end of list
    });
  }

  // initial state and dispose methods to enable and disable add task button by listening to textfield controller
  // before adding when input is empty press button was adding the last deleted item, therefore I saw from pub dev and other sources
  //to control the button active state.

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final textfieldvalue = _controller.text.isNotEmpty;
      setState(() => this.textfieldvalue = textfieldvalue);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: todolists()), //add the todo Listview to a column widget
            const SizedBox(
                height:
                    20), //space between Lists of todo and the input textfield
            TextField(
              controller:
                  _controller, // controller for the textfield to listen changes
              //textfield to enter task to do at the bottom of body
              onChanged: (value) {
                setState(() {
                  _textFieldValue =
                      value; //pass the change in textfield to  _textFieldValue for later use
                });
              },
              decoration: InputDecoration(
                // add task button to be pressed to pass input to the list
                labelText: 'Enter todo',
                labelStyle: const TextStyle(color: Colors.pinkAccent),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.black45, width: 3),
                ),
                //icon on top of textfield to clear the textfield on press,
                //advantage of this iconis when user adds ling text removing maybe time taking
                suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: Color.fromARGB(255, 82, 154, 255),
                    ),
                    onPressed: () {
                      _controller.clear();
                    }),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              //button to add the input text to todo, it will be active when textfieldvalue=true
              onPressed: textfieldvalue
                  ? () => _addtodo()
                  : null, //if textfield value is true we add the text to list calling _addtodo method
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 240, 86, 192),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              child: const Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }

  // a widget for adding items on lisview and delete, the todos list is also updated inside the widgets

  Widget todolists() {
    return ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: todos.length,
        reverse: true,
        itemBuilder: ((context, index) {
          return ListTile(
              title:
                  Text(todos[index]), //add list elements to the listile items
              tileColor: Colors.greenAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onTap: () {
                //when item in the listile is tapped it will be removed from the list and listview
                setState(() {
                  todos.remove(todos[index]);
                  AlertDialog alert = const AlertDialog(
                    //alert dialog telling the user the item is moved to done
                    title: Text('You are done with a selected todo'),
                    icon: Icon(
                      Icons.done,
                      color: Colors.green,
                      weight: 60,
                      size: 60,
                    ),
                  );
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      });
                });
              });
        }));
  }
}

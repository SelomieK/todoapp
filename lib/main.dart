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
        body: const Todo(),
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
  String _textFieldValue = '';
  List<String> items = [];

  bool textfieldvalue = false;
  final TextEditingController _clrear = TextEditingController();

  void _addtodo() {
    setState(() {
      items.add(('$_textFieldValue '));
    });
  }

  @override
  void initState() {
    super.initState();
    _clrear.addListener(() {
      final textfieldvalue = _clrear.text.isNotEmpty;
      setState(() => this.textfieldvalue = textfieldvalue);
    });
  }

  @override
  void dispose() {
    _clrear.dispose();
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
            Expanded(child: todolists()),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                setState(() {
                  _textFieldValue = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter todo',
                labelStyle: const TextStyle(color: Colors.pinkAccent),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.black45, width: 3),
                ),
                suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: Color.fromARGB(255, 82, 154, 255),
                    ),
                    splashColor: const Color.fromARGB(255, 82, 154, 255),
                    onPressed: () {
                      _clrear.clear();
                    }),
              ),
              controller: _clrear,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: textfieldvalue ? () => _addtodo() : null,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 240, 86, 192),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              child: const Text("Add Task"),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget todolists() {
    return ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: items.length,
        reverse: true,
        itemBuilder: ((context, index) {
          return ListTile(
              title: Text(items[index]),
              tileColor: Colors.greenAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onTap: () {
                setState(() {
                  items.remove(items[index]);
                  AlertDialog alert = const AlertDialog(
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

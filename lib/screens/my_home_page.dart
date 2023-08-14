import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/provider/todo_provider.dart';
import '../widgets/todo_action.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textFieldController = TextEditingController();
  String newTask = '';
  @override
  void initState() {
    super.initState();
    _textFieldController.addListener(() {
      newTask = _textFieldController.text;
    });
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  void _submit() {
    Provider.of<TodoProvider>(context, listen: false).addTask(newTask);
    Navigator.pop(context);
    _textFieldController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _showAddtextDialog() async {
      return showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              title: const Text("Add a new Task"),
              content: TextField(
                autofocus: true,
                controller: _textFieldController,
                decoration: const InputDecoration(hintText: "Add New Task"),
                onSubmitted: (_) => _submit(),
              ),
              actions: [
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(120, 40)),
                  child: const Text("Submit"),
                )
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              actionsAlignment: MainAxisAlignment.center,
            );
          }));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo App"),
      ),
      body: const TodoAction(),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          _showAddtextDialog();
        }),
        tooltip: "Add a Todo",
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
      home: TodoBox(),
    );
  }
}

class TodoBox extends StatefulWidget {
  @override
  State createState() => TodoBoxState();
}

class TodoBoxState extends State<TodoBox> {
  final List<TodoItem> _todos = <TodoItem>[];
  final TextEditingController _textController = TextEditingController();
  FocusNode todoInputFocusNode;

  @override
  void initState() {
    super.initState();
    todoInputFocusNode = FocusNode();
  }

  @override
  void dispose() {
    todoInputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('After Todos'),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 50),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20.0,
              spreadRadius: 5.0,
              offset: Offset(0.0, 0.0),
            )
          ],
        ),
        child: _todoContainer(),
      )
    );
  }

  Widget _todoContainer() {
    return Column(
      children: <Widget>[
        _todoInput(),
        _todoList(),
      ],
    );
  }

  Widget _todoInput() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Theme.of(context).cardColor,
      ),
      child: TextField(
        controller: _textController,
        autofocus: true,
        focusNode: todoInputFocusNode,
        onSubmitted: _handleSubmitted,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20.0),
          hintText: 'Enter To do!',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _todoList() {
    return Flexible(
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(10.0),
          itemBuilder: (_, int index) => _todos[index],
          itemCount: _todos.length,
        )
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    todoInputFocusNode.previousFocus();

    if (text.length < 1) {
      return;
    }

    TodoItem todo = TodoItem(text: text);

    setState(() {
      _todos.insert(0, todo);
    });
  }
}

class TodoItem extends StatelessWidget {
  TodoItem({
    this.text
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.grey[50],
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            spreadRadius: 1.0,
            offset: Offset(0.0, 3.0),
          )
        ],
      ),
      child: Text(text),
    );
  }
}

final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);
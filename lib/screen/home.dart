import 'package:flutter/material.dart';
import 'package:todo/database/db_helper.dart';
import 'package:todo/widget/textfield.dart';
import 'package:todo/widget/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> allTodo = [];
  DbHelper? db;
  String? title;
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = DbHelper.getInstance;
    getTodo();
  }

  void getTodo() async {
    allTodo = await db!.getTodo();
    //allTodo = allTodo.reversed.toList();
    setState(() {});
  }

  void isDone({required Map<String, dynamic> todo}) async {
    int pressed = todo[DbHelper.COLUMN_NOTE_ISCOMPLETED] == 0 ? 1 : 0;
    bool check = await db!
        .updateTodo(sno: todo[DbHelper.COLUMN_NOTE_SNO], isCompleted: pressed);
    if (check) {
      getTodo();
    }
  }

  void delete({required Map<String, dynamic> todo}) async {
    bool checked = await db!.deleteTodo(sno: todo[DbHelper.COLUMN_NOTE_SNO]);
    if (checked) {
      getTodo();
    }
  }

  void addTodobutton() async {
    title = titleController.text;
    if (title != null && title!.isNotEmpty) {
      bool check = await db!.addTodo(tdTitle: title!, tdIsSelected: 0);
      print("Todo added: $check"); // Debugging
      if (check) {
        titleController.clear();
        getTodo();
      }
    } else {
      print("Title is empty. Not adding to DB.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade100,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        title: Text(
          'To-Do',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 30,
            right: 30,
            left: 30,
            child: SizedBox(
              height: 650,
              child: ListView.builder(
                itemCount: allTodo.length,
                itemBuilder: (context, index) {
                  return TodoItem(
                    todo: allTodo[index],
                    onPressed: () {
                      isDone(todo: allTodo[index]);
                    },
                    deleteTodo: () {
                      delete(todo: allTodo[index]);
                    },
                  );
                },
              ),
            ),
          ),
          Positioned(
              bottom: 70,
              left: 28,
              right: 95,
              child: TextfieldW(
                titleController: titleController,
              )),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          splashColor: Colors.white,
          elevation: 4,
          backgroundColor: Colors.lightGreen.shade700,
          onPressed: addTodobutton,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }
}

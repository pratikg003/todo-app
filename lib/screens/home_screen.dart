import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/providers/todo_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  void _addEntry() {
    final text = _controller.text.trim();
    if(text.isEmpty) return;
    context.read<TodoProvider>().addEntry(text);
    _controller.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<TodoProvider>().todoList;
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Todo App"))),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
          
                    return Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueGrey[50]
                      ),
                      child: ListTile(
                        onTap: () {
                          context.read<TodoProvider>().toggleEntry(index);
                        },
                        leading: Icon(
                          todo.isDone
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                        ),
                        title: Text(todo.title),
                        trailing: IconButton(
                          onPressed: () {
                            context.read<TodoProvider>().deleteEntry(index);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    );
                  },
                ),
              ),
              BottomAppBar(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none
                          ),
                          hintText: "New Todo"
                        ),
                      ),
                    ),
                    IconButton(onPressed: _addEntry, icon: Icon(Icons.add)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

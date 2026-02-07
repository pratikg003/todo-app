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
    if (text.isEmpty) return;
    context.read<TodoProvider>().addEntry(text);
    _controller.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<TodoProvider>().todoList;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Todo App",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(thickness: 0.5, color: Colors.blueGrey),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];

                    return Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green[50],
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
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blueGrey[50],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "New Todo",
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.green[100]
                      ),
                      child: IconButton(onPressed: _addEntry, icon: Icon(Icons.add))),
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

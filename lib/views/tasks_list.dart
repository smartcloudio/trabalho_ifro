import 'package:flutter_app/database/database-moor.dart';
import 'package:flutter_app/provider/tasks.dart';
import 'package:flutter_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/views/todo_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

/// Shows a list of todos and displays a text input to add another one
class HomeScreenState extends State<HomeScreen> {
  // we only use this to reset the input field at the bottom when a entry has
  // been added
  final TextEditingController controller = TextEditingController();

  TodoAppBloc get bloc => Provider.of<TodoAppBloc>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo list'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.createEntry('TESTE');
        },
        child: Icon(Icons.mouse),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<List<EntryWithCategory>>(
        stream: bloc.homeScreenEntries,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }

          final activeTodos = snapshot.data;

          return ListView.builder(
            itemCount: activeTodos.length,
            itemBuilder: (context, index) {
              return TodoCard(activeTodos[index].entry);
            },
          );
        },
      ),
    );
  }

  void _createTodoEntry() {
    if (controller.text.isNotEmpty) {
      // We write the entry here. Notice how we don't have to call setState()
      // or anything - moor will take care of updating the list automatically.
      bloc.createEntry(controller.text);
      controller.clear();
    }
  }
}

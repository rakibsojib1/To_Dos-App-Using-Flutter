import 'package:flutter/material.dart';

import 'style.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  TextEditingController inpcont = TextEditingController();
  List Todo = [];
  String item = '';

  MyInputOnChange(content) {
    setState(() {
      item = content;
    });
  }

  AddItem() {
    if (item.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("List item cannot be empty"),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      setState(() {
        Todo.add({'item': item});
        inpcont.clear();
        item = "";
      });
    }
  }

  void RemoveItem(index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are you sure you want to remove this item?"),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Yes"),
              onPressed: () {
                setState(() {
                  Todo.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Dos"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Expanded(
              flex: 10,
              child: Row(
                children: [
                  Expanded(
                      flex: 70,
                      child: TextField(
                        controller: inpcont,
                        onChanged: (content) {
                          MyInputOnChange(content);
                        },
                        decoration: AppInputDecoratiion("List Item"),
                      )),
                  Expanded(
                    flex: 30,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: ElevatedButton(
                        onPressed: () {
                          AddItem();
                        },
                        style: AppButtonStyle(),
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ),
                ],
              )),
          Expanded(
              flex: 90,
              child: ListView.builder(
                itemCount: Todo.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: SizedBox50(Row(
                      children: [
                        Expanded(
                            flex: 80,
                            child: Text(Todo[index]['item'].toString())),
                        Expanded(
                          flex: 20,
                          child: TextButton(
                            onPressed: () {
                              RemoveItem(index);
                            },
                            //style: AppButtonStyle(),
                            child: const Icon(Icons.delete),
                          ),
                        ),
                      ],
                    )),
                  );
                },
              )),
        ]),
      ),
    );
  }
}

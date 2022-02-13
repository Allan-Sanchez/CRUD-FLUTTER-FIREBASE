import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpdatePage extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  const UpdatePage(
      {Key? key,
      required this.title,
      required this.description,
      required this.id})
      : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _formkey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  final CollectionReference _tasks =
      FirebaseFirestore.instance.collection('task');

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _descriptionController = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _deleteTask() {
    _tasks.doc(widget.id).delete().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Task Delete successfully'),
        backgroundColor: Theme.of(context).canvasColor,
      ));
    }).catchError((onError) => print("Failed to delete task: $onError"));
    return Navigator.pushNamed(context, '/');
  }

  Future<void> _updatedTask() {
    _tasks
        .doc(widget.id)
        .update({
          'title': _titleController.text,
          'description': _descriptionController.text
        })
        .then((value) => {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Task Updated successfully'),
                backgroundColor: Colors.green,
              ))
            })
        .catchError((onError) => print('Error into the $onError'));
    return Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'FlutterFirebase',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(width: 10),
            Text('CRUD',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.yellow)),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                _deleteTask();
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Title',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _titleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some title';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'type the title',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some description';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: const InputDecoration(
                          hintText: 'Type one description'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: InkWell(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      _updatedTask();
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Center(
                          child: Text(
                        'Add Item',
                        style: Theme.of(context).textTheme.headline5,
                      )),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

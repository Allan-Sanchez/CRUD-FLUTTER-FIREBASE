import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewData extends StatefulWidget {
  const NewData({Key? key}) : super(key: key);

  @override
  State<NewData> createState() => _NewDataState();
}

class _NewDataState extends State<NewData> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final CollectionReference _tasks =
      FirebaseFirestore.instance.collection('task');

  Future<void> _saveNewTask() {
    _tasks.add({
      'title': _titleController.text,
      'description': _descriptionController.text
    })
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('task saved sucessfully'),
        backgroundColor: Colors.green,
      ));
    })
        .catchError((onError) => print("Failed to add user: $onError"));

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
                      _saveNewTask();
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

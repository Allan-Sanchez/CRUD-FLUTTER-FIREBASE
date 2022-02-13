import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase_flutter/screens/new.dart';
import 'package:crud_firebase_flutter/screens/update_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _tasksStream =
      FirebaseFirestore.instance.collection('task').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Flutter App'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _tasksStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return CardMain(
                  id: document.id,
                  title: data['title'],
                  description: data['description']);
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewData()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CardMain extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  const CardMain({
    Key? key,
    required this.title,
    required this.description,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    UpdatePage(id: id,title: title, description: description)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.white.withOpacity(0.4),
        child: ListTile(
          leading: const FlutterLogo(),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle: Text(
            description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

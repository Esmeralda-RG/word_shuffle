import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:word_shuffle/firebase_options.dart';
import 'firestore_service.dart'; 

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirestoreService().addSampleData();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web App',
      home: Scaffold(
        appBar: AppBar(title: const Text('Firebase Flutter Web')),
        body: Center(
          child: FutureBuilder<QuerySnapshot>(
            future: FirestoreService().fetchGuides(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading');
              }
              
              final documents = snapshot.data!.docs;

              return ListView.builder(
                itemCount: documents[0]['words'].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(documents[0]['words'][index]['word']),
                    subtitle: Text(documents[0]['words'][index]['description']),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addSampleData() async {
    final data = {
      'guide_number': 1,
      'guide_title': 'Example Title',
      'words': [
        {
          'word': 'Example Word 1',
          'description': 'Example Description 1',
          'image': 'https://example.com/image1.jpg',
        },
        {
          'word': 'Example Word 2',
          'description': 'Example Description 2',
          'image': 'https://example.com/image2.jpg',
        },
        {
          'word': 'Example Word 3',
          'description': 'Example Description 3',
          'image': 'https://example.com/image3.jpg',
        },
      ],
    };

    await firestore.collection('guides').add(data);
  }

  Future<QuerySnapshot> fetchGuides() {
    return firestore.collection('guides').get();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseFirestore firebaseFirestoreInstance=FirebaseFirestore.instance;
FirebaseAuth firebaseAuthInstance=FirebaseAuth.instance;
FirebaseStorage firebaseStorageInstance=FirebaseStorage.instance;

CollectionReference userDataCollection =firebaseFirestoreInstance.collection('userData');
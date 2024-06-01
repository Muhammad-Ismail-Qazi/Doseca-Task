import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore firebaseFirestoreInstance=FirebaseFirestore.instance;
FirebaseAuth firebaseAuthInstance=FirebaseAuth.instance;

CollectionReference userDataCollection =firebaseFirestoreInstance.collection('userData');
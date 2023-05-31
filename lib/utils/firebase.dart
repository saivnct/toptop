//Created by giangtpu on 25/05/2023.
//Giangbb Studio
//giangtpu@gmail.com

// FIREBASE
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

final firebaseAuth = FirebaseAuth.instance;
final firebaseStorage = FirebaseStorage.instance;
final firestore = FirebaseFirestore.instance;
const uuid = Uuid();

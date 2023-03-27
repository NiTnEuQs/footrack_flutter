import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

extension SnapshotExtension on AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>? {
  List<T> map<T>(T Function(DocumentSnapshot<Map<String, dynamic>> e) toElement) {
    return this?.data?.docs.map<T>(toElement).toList() ?? [];
  }
}

extension QuerySnapshotExtension on QuerySnapshot<Map<String, dynamic>>? {
  List<T> map<T>(T Function(DocumentSnapshot<Map<String, dynamic>> e) toElement) {
    return this?.docs.map<T>(toElement).toList() ?? [];
  }
}

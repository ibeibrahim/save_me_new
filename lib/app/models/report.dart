import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  late int? id;
  late String uid;
  late String nama;
  late int? telepon;
  late String email;
  late int? umur;
  late String jenisKelamin;
  late String alamat;
  late String spesifik;
  late String file;
  Report({
    required this.id,
    required this.uid,
    required this.nama,
    required this.telepon,
    required this.email,
    required this.umur,
    required this.jenisKelamin,
    required this.alamat,
    required this.spesifik,
    required this.file,
  });
  factory Report.fromDocument(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return Report(
      id: data['id'],
      uid: data['uid'],
      nama: data['nama'],
      telepon: data['telepon'],
      email: data['email'],
      umur: data['umur'],
      jenisKelamin: data['jenisKelamin'],
      alamat: data['alamat'],
      spesifik: data['spesifik'],
      file: data['file'],
    );
  }
}

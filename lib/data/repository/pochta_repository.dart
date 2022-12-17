import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pochta_model.dart';


class PochtaRepository {
  final FirebaseFirestore _firestore;

  PochtaRepository({required FirebaseFirestore firebaseFirestore})
      : _firestore = firebaseFirestore;

  Future<void> addMail({required PochtaModel pochtaModel}) async {
    try {
      DocumentReference newPochta =
      await _firestore.collection("mails").add(pochtaModel.toJson());
      await _firestore.collection("mails").doc(newPochta.id).update({
        "pochta_id": newPochta.id,
      });

    } on FirebaseException catch (er) {
      print(er.message.toString());
    }
  }

  Future<void> deleteMail({required String docId}) async {
    try {
      await _firestore.collection("mails").doc(docId).delete();

      print("Mahsulot muvaffaqiyatli o'chirildi!");
    } on FirebaseException catch (er) {
      print(er.message.toString());
    }
  }

  Future<void> updateMail({required PochtaModel pochtaModel}) async {
    try {
      await _firestore
          .collection("mails")
          .doc(pochtaModel.pochtaId)
          .update(pochtaModel.toJson());

      print("Mahsulot muvaffaqiyatli yangilandi!");
    } on FirebaseException catch (er) {
      print(er.message.toString());
    }
  }

  Stream<List<PochtaModel>> getMails() =>
      _firestore.collection("mails").snapshots().map(
            (querySnapshot) => querySnapshot.docs
            .map((doc) => PochtaModel.fromJson(doc.data()))
            .toList(),
      );

  // Stream<List<PochtaModel>> getProductsById({required String pochtaId}) =>
  //     _firestore.collection("mails")
  //         .where("category_id", isEqualTo: pochtaId)
  //         .snapshots()
  //         .map(
  //           (querySnapshot) => querySnapshot.docs
  //           .map((doc) => PochtaModel.fromJson(doc.data()))
  //           .toList(),
  //     );

  Stream<List<PochtaModel>> getMail({required String pochtaId}) async* {
    if (pochtaId.isEmpty) {
      yield* _firestore.collection("mails").snapshots().map(
            (querySnapshot) => querySnapshot.docs
            .map((doc) => PochtaModel.fromJson(doc.data()))
            .toList(),
      );
    } else {
      yield* _firestore
          .collection("mails")
          .where("pochtaId", isEqualTo: pochtaId)
          .snapshots()
          .map(
            (querySnapshot) => querySnapshot.docs
            .map((doc) => PochtaModel.fromJson(doc.data()))
            .toList(),
      );
    }
  }
}

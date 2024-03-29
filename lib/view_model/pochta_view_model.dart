import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../data/models/pochta_model.dart';
import '../data/repository/pochta_repository.dart';


class PochtaViewModel extends ChangeNotifier {
  final PochtaRepository productRepository;

  PochtaModel? currentPostage;
  bool isSwitched=false;
  num? distance;

  changeisSavedField(List indexes){
    for(var i in indexes){
      for (var j in products){
        if(i.toString()==j.oldIndex){
          j.isSaved=true;
        }
        else{
          j.isSaved=false;
        }
      }
    }
    return products;

  }

  changePostage(PochtaModel newPostage,num distance1){
    currentPostage=newPostage;
    distance=distance1;
    isSwitched=!isSwitched;
    notifyListeners();
  }

  PochtaViewModel({required this.productRepository}){
    listenProducts("");
  }
  List<PochtaModel> productAdmin = [];
  late StreamSubscription subscription;

  List<PochtaModel> products = [];


  Stream<List<PochtaModel>> listenProducts1() =>
      productRepository.getMails();

  addProduct(PochtaModel pochtaModel) =>
      productRepository.addMail(pochtaModel: pochtaModel);

  updateProduct(PochtaModel pochtaModel) =>
      productRepository.updateMail(pochtaModel: pochtaModel);

  deleteProduct(String docId) => productRepository.deleteMail(docId: docId);

  listenProducts(String pochtaId) async {
    subscription = productRepository
        .getMail(pochtaId: pochtaId)
        .listen((allProducts) {
      if(pochtaId.isEmpty) productAdmin = allProducts;
      print("ALL PRODUCTS LENGTH:${allProducts.length}");
      products = allProducts;
      notifyListeners();
    });
  }


  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}

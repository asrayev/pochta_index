import 'package:flutter/cupertino.dart';
import 'package:pochta_index/data/models/pochta_model.dart';
import 'package:pochta_index/data/repository/database_repository.dart';
import 'package:pochta_index/view_model/pochta_view_model.dart';

class SavedsViewModel extends ChangeNotifier{

  LocalDatabaseRepository localDatabaseRepository;

  SavedsViewModel({required this.localDatabaseRepository});

  List<PochtaModel>? saveds;

  listenSaveds(List<PochtaModel> postages) async {
    List<PochtaModel> result = await localDatabaseRepository.getPostagesFromDb(postages);
    saveds=result;
    notifyListeners();
  }

  deleteByIndex(PochtaModel postage){
    localDatabaseRepository.deleteByIndex(postage.oldIndex!);
    saveds!.remove(postage);
    notifyListeners();
  }

  insertToDb(String oldIndex,List<PochtaModel> postages)=>localDatabaseRepository.insertToDb(oldIndex,postages);
}
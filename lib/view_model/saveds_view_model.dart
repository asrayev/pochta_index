import 'package:flutter/cupertino.dart';
import 'package:pochta_index/data/models/pochta_model.dart';
import 'package:pochta_index/data/repository/database_repository.dart';
import 'package:pochta_index/view_model/pochta_view_model.dart';

class SavedsViewModel extends ChangeNotifier{

  LocalDatabaseRepository localDatabaseRepository;

  SavedsViewModel({required this.localDatabaseRepository}){
    getSavedIndexes();
  }

  List<PochtaModel>? saveds;
  List? indexes;

  listenSaveds(List<PochtaModel> postages) async {
    List<PochtaModel> result = await localDatabaseRepository.getPostagesFromDb(postages);
    saveds=result;
    notifyListeners();
  }

  deleteByIndex(PochtaModel postage){
    localDatabaseRepository.deleteByIndex(postage.oldIndex!);
    print("Deleted: $postage");
    saveds!.remove(postage);
    indexes!.remove(int.parse(postage.oldIndex!));
    notifyListeners();
  }

  insertToDb(String oldIndex,List<PochtaModel> postages)=>localDatabaseRepository.insertToDb(oldIndex,postages);

  deleteOrInsertToDb(String  index) async {
    bool isSaved = await localDatabaseRepository.deleteOrInsertToDb(index);
    notifyListeners();
    getSavedIndexes();
    return isSaved;
  }

  getSavedIndexes() async {
    indexes = await localDatabaseRepository.getSavedIndexes();
    notifyListeners();
  }

}
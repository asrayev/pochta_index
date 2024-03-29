import 'package:pochta_index/data/models/pochta_model.dart';
import 'package:pochta_index/data/servis/database_service.dart';

class LocalDatabaseRepository{
  insertToDb(String oldIndex,List<PochtaModel> postages){
    bool isHas=false;
    for(PochtaModel i in postages){
      if(oldIndex==i.oldIndex){
        isHas=true;
        break;
      }
    }

    if(isHas==false){
      LocalDatabase.insertToDatabase(int.parse(oldIndex));
    }

  }

  deleteByIndex(String oldIndex)=>LocalDatabase.deleteById(int.parse(oldIndex));

  getPostagesFromDb(List<PochtaModel> postages) async {
    List indexes= await LocalDatabase.getPostagesFromDb();
    List<PochtaModel> saveds=[];

    for(var i in indexes){
      for(var j in postages){
        if(j.oldIndex==i.toString()){
          saveds.add(j);
        }
      }
    }

    return saveds;
  }


  Future<bool> deleteOrInsertToDb(String index) async {
    List indexes= await LocalDatabase.getPostagesFromDb();

    for(int i in indexes){
      if(index==i.toString()){
        deleteByIndex(index);
        return true;
      }
    }
    LocalDatabase.insertToDatabase(int.parse(index));
    return false;
  }

  Future<List> getSavedIndexes() async {
    List indexes= await LocalDatabase.getPostagesFromDb();
    return indexes;
  }
}
import 'package:flutter/cupertino.dart';
import 'package:food_dilivery/widgets/widgets.dart';

class TrashProvider with ChangeNotifier{
  List<TrashCardWidget> trashCards = [];


  void update(TrashCardWidget cardWidget){
    trashCards.add(cardWidget);
    notifyListeners();
  }

  void delete(int index){
    for(int i=0; i<trashCards.length; i++){
      if(trashCards[i].id == index){
        trashCards.removeAt(i);
        notifyListeners();
      }
    }
  }
}
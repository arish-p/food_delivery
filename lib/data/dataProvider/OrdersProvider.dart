import 'package:flutter/cupertino.dart';

import '../../models/order.dart';

class OrderProviders with ChangeNotifier{
  List<Order> _orders = [];

  int? _findOrderIndex(int id){
    for(int i=0; i<_orders.length; i++){
      if(_orders[i].id == id){
        return i;
      }
    }
    return  null;// throw("метод - findOrderIndex(): id:$id не существует в заказах");
  }
  List<Order> getOrders(){
    return _orders;
  }

  int getSize(){
    return _orders.length;
  }

  //Добавляем заказ в список
  void addOrder(Order order){
    order.increaseCount();
    _orders.add(order);
    notifyListeners();
  }

  //Возвращает заказ по id продукта
  Order? getOrderById(int id){
    try{
      return _orders[_findOrderIndex(id)!];
    }catch(e){
      return null;
    }
  }


  //Удаляем заказ по id продукта
  void deleteOrderById(int id){
    _orders.removeAt(_findOrderIndex(id)!);
    notifyListeners();
  }

  //Возвращает заказ по индексу листа
  Order getOrderByIndex(int index){
    return _orders[index];
  }

  //Возвращает все id Order
  List<int> getAllIdOrders(){
    List<int> idList = [];
    for(int i=0; i<_orders.length; i++){
      idList.add(_orders[i].id);
    }
    return idList;

  }


  //Обновляет количество продукта на 1 по его id
  void increaseById(int id){
    _orders[_findOrderIndex(id)!].increaseCount();
    notifyListeners();
  }

  void decreaseById(int id){
    _orders[_findOrderIndex(id)!].decreaseCount();
    notifyListeners();
  }

  //Устанавличвает указанное количество продуката по его id
  void setCountOrderById(int id, int count){
    _orders[_findOrderIndex(id)!].setCount(count);
    notifyListeners();
  }

  int getCountOrderById(int id){
    return _orders[_findOrderIndex(id)!].getCount();
  }


  //Устанавливает указанное количество продукта по индексу в списке
  void setCountOrderByIndex(int index, int count){
    _orders[index].setCount(count);
    notifyListeners();
  }
}
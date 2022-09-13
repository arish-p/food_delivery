class Order{
  int id;
  int _count = 0;

  Order(this.id);

  int getCount(){
    return _count;
  }

  void increaseCount(){
    _count++;
  }
  void decreaseCount(){
    if(_count==0){
      _count=0;
    }else{
      _count--;
    }
  }

  void setCount(int value){
    _count = value;
  }
}
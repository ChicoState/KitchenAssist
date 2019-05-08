class Food{
  String _name;
  int _id;

  Food(this._name);
  Food.withId(this._id, this._name);

  String get name => _name;

  set name(String newName){
    this._name = newName;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

  //extract object
  Food.fromMapObject(Map<String, dynamic> map){
    this._id = map['id'];
    this._name = map['name'];
  }
}
class Type {
  String color;
  String icon;
  dynamic id;
  String name;

  Type({this.color, this.icon, this.id, this.name});

  Type.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    icon = json['icon'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
class GList {
  String id;
  String name;
  int a;
  int r;
  int g;
  int b;

  GList({
    required this.id,
    required this.name,
    required this.a,
    required this.r,
    required this.g,
    required this.b
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'a': a,
      'r': r,
      'g': g,
      'b': b,
    };
  }

  factory GList.fromMap(Map<String, dynamic> map) {
    return GList(
      id: map['id'],
      name: map['name'],
      a: map['a'],
      r: map['r'],
      g: map['g'],
      b: map['b'],
    );
  }
}
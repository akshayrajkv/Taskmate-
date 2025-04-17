class Categorymodel  {
  final List<String > categories ;
  Categorymodel({required this.categories});

factory Categorymodel.fromJson (Map<String,dynamic>json){
  return Categorymodel(categories: List<String>.from(json['categories']),
  );

}
}
class TaskModel {
  int id;
  String title;
  String descripcion;
  String status;

  TaskModel(
      {required this.id,
      required this.title,
      required this.descripcion,
      required this.status});

//un costructor un modelo que te devuelve => unh modelo ( semana 9 video 8 min 8min)
//devuelve un costructor apartir de un mapa

  factory TaskModel.deMapAModel(Map<String, dynamic> mapa) => TaskModel(
      id: mapa["id"],
      title: mapa["title"],
      descripcion: mapa["descripcion"],
      status: mapa["status"]);
}

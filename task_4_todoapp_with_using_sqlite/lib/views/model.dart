class TodoModel {
  final int? id;
  final String? title;
  final String? desc;
  final String? dateandtime;

//Constructor
  TodoModel({this.id, this.desc, this.title, this.dateandtime});

  TodoModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        desc = res['desc'],
        dateandtime = res['dateandtime'];

  Map<String,Object?> toMap(){
    return  {
      "id":id,
      "title":title,
      "desc":desc,
      "dateandtime":dateandtime,
    };
  }


}

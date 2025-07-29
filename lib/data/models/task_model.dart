// class TaskModel {
 
//   late String id;

//   late String title;

//   late String description;
//   late String status;
//   late String createdDate;

//   TaskModel.fromJson(Map<String,dynamic>jsonDecode){
//     id = jsonDecode['_id'];
//     title = jsonDecode['title'];
//     description =jsonDecode['descreiption'];
//     status =jsonDecode['status'];
//     createdDate =jsonDecode['createdDate'];
//   }
  

  


class TaskModel {
  final String id;
  final String title;
  final String description;
  final String status;
  final String email;
  final String createdDate;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.email,
    required this.createdDate,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      createdDate: json['createdDate']?.toString() ?? '',
    );
  }
}

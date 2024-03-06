class ModelResume{

  int?  id=0;
  String?  name="";
  String?  email="";
  String?  address="";
  String?  phone="";
  String?  photo="";
  String?  education="";


  ModelResume({
    this.id,
    this.name,
    this.email,this.address,this.phone,this.photo,this.education});


  factory ModelResume.fromJson(Map<dynamic, dynamic> json) {
    return ModelResume(

      id: json['id']!=null?json['id']:'',
      name: json['name']!=null?json['name'].toString():'',
      email:json['email']!=null? json['email'].toString():'',
      address: json['address']!=null?json['address'].toString():'',
      phone: json['phone']!=null?json['phone'].toString():'',
      education: json['education']!=null?json['education']:true,
    );
  }

}
class ModelClass{

  String?  name="";
  String?  email="";
  String?  address="";
  String?  phone="";
  String?  photo="";
  String?  education="";


  ModelClass({
    this.name,
    this.email,this.address,this.phone,this.photo,this.education});

  @override
  String toString() {
    return 'ModelClass{name: $name, email: $email, address: $address,'
        ' phone: $phone, photo: $photo, education: $education, }';
  }

  Map<String,dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
      'photo': photo,
      'education': education,
    };
  }
  factory ModelClass.fromJson(Map<dynamic, dynamic> json) {
    return ModelClass(

      name: json['name']!=null?json['name'].toString():'',
      email:json['email']!=null? json['email'].toString():'',
      address: json['address']!=null?json['address'].toString():'',
      phone: json['phone']!=null?json['phone'].toString():'',
      photo: json['photo']!=null?json['photo'].toString():'',
      education: json['education']!=null?json['education'].toString():'',
    );
  }

}
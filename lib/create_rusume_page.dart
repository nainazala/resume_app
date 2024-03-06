import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:printing/printing.dart';
import 'package:resume_app/pdfviewr.dart';
import 'package:sqflite/sqflite.dart';

import 'DatabaseHelper.dart';
import 'ModelClass.dart';
import 'ModelResume.dart';

class ResumeCretePage extends StatefulWidget {
  const ResumeCretePage({super.key});

  @override
  State<ResumeCretePage> createState() => _HomePageState();
}

class _HomePageState extends State<ResumeCretePage> {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtEducation = TextEditingController();
  final ImagePicker picker = ImagePicker();
  File? image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Create Resume")),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                image == null
                    ? Center(
                      child: Column(
                        children: [
                          Container(
                            child: Image.asset("images/ic_profile.jpg", width: 200,
                              height: 120,),

                          ),
                          ElevatedButton(
                              onPressed: () {
                                pickImage();
                              },
                              child: Text("Open Gellary")),
                        ],
                      ),
                    )
                    : Center(
                      child: InkWell(
                        onTap: (){
                          pickImage();
                        },
                        child: CircleAvatar(
                            child: ClipOval(
                                child: Image.file(
                              image!,
                              fit: BoxFit.cover,
                              width: 200,
                              height: 120,
                            )),
                            radius: 60,
                          ),
                      ),
                    ),
                Text("Name",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
                TextField(
                  controller: txtname,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Email",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
                TextField(
                  controller: txtEmail,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Phone",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
                TextField(
                  controller: txtPhone,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Address",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
                TextField(
                  controller: txtAddress,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Education",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
                TextField(
                  controller: txtEducation,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: ElevatedButton(
                        onPressed: () {
                          ModelClass model = ModelClass(
                              name: txtname.text,
                              address: txtAddress.text,
                              email: txtEmail.text,
                              education: txtEducation.text,
                              phone: txtPhone.text,
                              photo: image!.path.toString());
                          ModelResume modelresume = ModelResume(
                              name: txtname.text,
                              address: txtAddress.text,
                              email: txtEmail.text,
                              education: txtEducation.text,
                              phone: txtPhone.text,
                              photo:  image!.path.toString());
                          _Insertquery(model);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PDFViewrs(
                                      model: modelresume,
                                    )),
                          );
                        },
                        child: Text("Create Resume")))
              ],
            ),
          ),
        ));
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  _Insertquery(ModelClass modelClass) async {
    // get a reference to the database
    Database? db = await DatabaseHelper.instance.database;
    DatabaseHelper databaseHelper = DatabaseHelper.instance;

    databaseHelper.insert(modelClass);
    // get all rows
    List<Map> result = await db!.query(DatabaseHelper.table);
    // print the results
    // result.forEach((row) => print(row));
    // openseaController.fetchedList.value =
    //     result.map((f) => ModelTODO.fromJson(f)).toList();
    // openseaController.isloading.value = false;
  }
}

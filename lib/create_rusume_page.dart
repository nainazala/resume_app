import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Create Resume")),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                            phone: txtEducation.text,
                            photo: txtPhone.text);
                        ModelResume modelresume = ModelResume(
                            name: txtname.text,
                            address: txtAddress.text,
                            email: txtEmail.text,
                            education: txtEducation.text,
                            phone: txtEducation.text,
                            photo: txtPhone.text);
                        _Insertquery(model);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PDFViewrs( model: modelresume,)),
                        );
                      },
                      child: Text("Create Resume")))
            ],
          ),
        ));
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

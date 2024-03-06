import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:resume_app/create_rusume_page.dart';
import 'package:resume_app/pdfviewr.dart';
import 'package:sqflite/sqflite.dart';

import 'DatabaseHelper.dart';
import 'ModelClass.dart';
import 'ModelResume.dart';
import 'edit_rusume_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ModelResume> fetchedList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _FetchDataFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Resume List"),actions: [  Padding(
        padding: const EdgeInsets.only(right: 10),
        child: ElevatedButton(

            onPressed: () {
              _FetchDataFromDB();

            },

            child: Text("ReFresh")),
      ),]),

      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: fetchedList.length!=0? ListView.builder(
              shrinkWrap: false,
              itemCount: fetchedList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  shadowColor: Colors.black,
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(fetchedList[index].name.toString()),
                            Expanded(child: Container()),
                            Icon(
                              Icons.picture_as_pdf,
                              color: Colors.red,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: Container()),
                            ElevatedButton(

                                onPressed: () {
                                  print(fetchedList[index].photo);

                                  ModelResume model =fetchedList[index];
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PDFViewrs(model: model)),
                                  ).then((value) => {_FetchDataFromDB()});
                                },

                                child: Text("Open")),
                            SizedBox(width: 10,),
                            ElevatedButton(

                                onPressed: () {

                                  ModelResume model = fetchedList[index];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                      builder: (context) => ResumeEditPage(model: model,)));
                                },

                                child: Text("Edit")),
                            SizedBox(width: 10,),
                            ElevatedButton(

                                onPressed: () {
                                  _Deletequery(fetchedList[index].id);

                                },

                                child: Text("delete")),


                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ):Center(child: Text("PDF list is Empty\nPlease Create pdf button Click",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 16),)),
          ),
          Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResumeCretePage()),
                        );
                      },
                      child: Text("Create new Resume"))))
        ],
      ),
    );
  }

  _FetchDataFromDB() async {
    // get a reference to the database
    Database? db = await DatabaseHelper.instance.database;

    // get all rows
    List<Map> result = await db!.query(DatabaseHelper.table);
    // print the results
    result.forEach((row) => print(row));
    fetchedList = result.map((f) => ModelResume.fromJson(f)).toList();

    setState(() {});
  }

  _Deletequery(int? id) async {
    // get a reference to the database
    Database? db = await DatabaseHelper.instance.database;
    DatabaseHelper databaseHelper = DatabaseHelper.instance;
    databaseHelper.delete(id!);
    _FetchDataFromDB();
  }
}

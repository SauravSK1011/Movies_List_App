import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:movies_list_app/Model/movies.dart';
import 'package:movies_list_app/Widget/box.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddMoviePage extends StatefulWidget {
  const AddMoviePage({Key? key}) : super(key: key);

  @override
  State<AddMoviePage> createState() => _AddMoviePageState();
}

class _AddMoviePageState extends State<AddMoviePage> {
  String moviename = "";
  bool isImageLoded = false;
  late File _imagefile;
  final imagepicker = ImagePicker();
  String director_name = "";
  _pickImagefromGallary() async {
    await Future.delayed(Duration(seconds: 1));
    var image = await imagepicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    } else {
      setState(() {
        _imagefile = File(image.path);
        isImageLoded = true;
      });
    }
  }

  _pickImagefromCamara() async {
    await Future.delayed(Duration(seconds: 1));
    var image = await imagepicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    } else {
      setState(() {
        _imagefile = File(image.path);
        isImageLoded = true;
      });
    }
  }

  Future addTransaction(String name, String director, String image) async {
    final movie = movies()
      ..moviename = name
      ..director = director
      ..image = image;

    final box = Boxes.getmovie();
    if (_imagefile.path != "") {
      box.add(movie);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[700],
          content: Text(
            "Please fill a all fealds !",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue.shade900,
        title: Center(
            child: Text(
          "Add Movie",
          style: TextStyle(fontSize: 25.0),
        )),
      ),
      body: Column(
        // shrinkWrap: true,
        // padding: const EdgeInsets.all(
        //   12.0,
        // ),
        children: [
          const Text(
            "\nAdd Movie",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          //
          const SizedBox(
            height: 40.0,
          ),
          //
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Movie Name",
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 24.0,
                  ),
                  onChanged: (val) {
                    moviename = val;
                  },
                ),
              ),
            ],
          ),
          //
          const SizedBox(
            height: 20.0,
          ),
          //
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Enter name of Director",
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 20.0,
              ),
              onChanged: (val) {
                director_name = val;
              },
            ),
          ),
          //
          const SizedBox(
            height: 20.0,
          ),
          //
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RawMaterialButton(
                  fillColor: Colors.blue.shade900,
                  onPressed: () {
                    _pickImagefromCamara();
                  },
                  child: Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
                RawMaterialButton(
                  fillColor: Colors.blue.shade900,
                  onPressed: () {
                    _pickImagefromGallary();
                  },
                  child: Icon(Icons.add_photo_alternate, color: Colors.white),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          isImageLoded
              ? Center(
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: FileImage(_imagefile),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                )
              : Container(),
          //
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 50.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                primary: Colors.blue.shade900,
              ),
              onPressed: () async {
                addTransaction(moviename, director_name, _imagefile.path);
                Navigator.of(context).pop();
              },
              child: const Text(
                "Add",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}

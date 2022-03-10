import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_list_app/Model/movies.dart';
import 'package:movies_list_app/Pages/add_movie.dart';
import 'package:movies_list_app/Widget/box.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue.shade900,
        title: const Center(
            child: Text(
          "Movies List",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
        )),
      ),
      body: ValueListenableBuilder<Box<movies>>(
        valueListenable: Boxes.getmovie().listenable(),
        builder: (context, box, _) {
          final movie = box.values.toList().cast<movies>();
          return buildContent(movie);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade900,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => const AddMoviePage(),
            ),
          )
              .then((value) {
            setState(() {});
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Widget buildContent(List<movies> totalmovies) {
  if (totalmovies.isEmpty) {
    return const Center(
      child: Text(
        'No Movies Added!',
        style: TextStyle(fontSize: 24),
      ),
    );
  } else {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: totalmovies.length,
      itemBuilder: (BuildContext context, int index) {
        final transaction = totalmovies[index];

        return Column(
          children: [
            buildmoviechart(context, transaction),
            SizedBox(
              height: 25,
            )
          ],
        );
      },
    );
  }
}

Widget buildmoviechart(
  BuildContext context,
  movies movie,
) {
  final moviename = movie.moviename;
  final director = movie.director;
  final movieimage = movie.image;

  return Card(
    elevation: 50,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: FileImage(
                          File(movieimage),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        moviename,
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("By " + director, style: TextStyle(fontSize: 15)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          buildButtons(context, movie),
        ],
      ),
    ),
  );
}

Widget buildButtons(BuildContext context, movies movie) => Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 130,
        ),
        TextButton.icon(
          label: Text('Delete'),
          icon: Icon(Icons.delete),
          onPressed: () => movie.delete(),
        )
      ],
    );

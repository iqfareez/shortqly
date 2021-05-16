import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shortqly/views/create.dart';

class Home extends StatefulWidget {
  const Home(this.title);
  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: OpenContainer(
        middleColor: Colors.blueAccent,
        openBuilder: (context, action) {
          return CreatePage();
        },
        // closedColor: Colors.transparent,

        closedElevation: 4.0,
        closedShape: CircleBorder(),
        closedBuilder: (context, action) {
          return FloatingActionButton(
            onPressed: () => action.call(),
            child: Icon(Icons.add),
          );
        },
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              'Ayam $index',
            ),
          );
        },
      ),
    );
  }
}

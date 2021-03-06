// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:wallpaper/modals/wallpaper_model.dart';
import 'package:wallpaper/views/image_view.dart';

Widget brandName() {
  return Center(
    child: RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        children: const <TextSpan>[
          TextSpan(text: 'Wallpaper', style: TextStyle(color: Colors.black87)),
          TextSpan(text: 'Hub', style: TextStyle(color: Colors.blue)),
        ],
      ),
    ),
  );
}

// {named parameter}
Widget wallpaperList({required List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      //! What is ClampingScrollPhysics?
      // It helps in making the scroll smoother.
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio:
          0.6, // 0.6 bcoz it is vertical image. Horizontal Image = 1.6, Square Image = 1
      mainAxisSpacing: 6.0, // Space btw top and bottom image
      crossAxisSpacing: 6.0, // Space btw side to side image
      //! What is wallpaper.map??
      children: wallpapers.map((e) {
        // e is wallpaper
        return GridTile(
            child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ImageView(imgUrl: e.srcModel!.portrait!)));
          },
          child: Hero(
            tag: e.srcModel!.portrait!,
            child: Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    e.srcModel!.portrait!,
                    fit: BoxFit.cover,
                  )), // BoxFit makes the pic fill up the container
            ),
          ),
        ));
      }).toList(), // Children has [] means it is List.
      // wallpapers.map is like .forEach (loop type)
    ),
  );
}

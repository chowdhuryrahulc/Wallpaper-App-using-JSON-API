// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_unnecessary_containers
//! Search.dart and catagorie.dart are simple copies of home.dart with some changes
// Dont spend much time on those

//? Inside JSON we have Map or List of Map
//List is collection of item of one kind
//Map is collection of Key Value pair
//? If JSON starts with { means we are getting a Map back
//? If starts with [ means we are getting a List of Maps back

//In this case we want src => portrait value

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper/data/data.dart';
import 'package:wallpaper/modals/categories_model.dart';
import 'package:wallpaper/modals/wallpaper_model.dart';
import 'package:wallpaper/views/catagorie.dart';
import 'package:wallpaper/views/image_view.dart';
import 'package:wallpaper/views/search.dart';
import 'package:wallpaper/widgets/widget.dart';
import 'package:http/http.dart' as http;

// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:random_string/random_string.dart';
// import 'package:dio/dio.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //WE ADD DATA TO THIS LIST BY EQUATING IT TO RETURN OF data.dart.
  List<CategorieModel> categories = [];
  List<WallpaperModel> wallpapers =
      []; //Same what we did for CatagorieModel in data.dart
  // Getter Example: wallpaper[index].src.portrait
  TextEditingController searchController = TextEditingController();

  getTrendingWallpaper() async {
    //! WTF is Uri.parse????
    // get bcoz this is a GET request
    // In some we pass API key in URL. in some, as this one in hedders
    var response = await http.get(
        Uri.parse('https://api.pexels.com/v1/curated?per_page=15&page=1'),
        headers: {'Authorization': apiKey});
    // print(response.body.toString());
    Map<String, dynamic> jsonData =
        jsonDecode(response.body); //Creates JSON from response.body
    //Key we want is 'photoes'
    //forEach is a Loop
    // If it is a List of Maps [], we go in and take 1st List item, then 2nd, then 3rd and so on
    // Element is 1st List item, and so on
    // but element is compleate list. We need individual values
    jsonData['photos'].forEach((element) {
      WallpaperModel wallpaperModel = WallpaperModel();
      // wallpaperModel = jsonData["id"] => cant do bcoz we need individual values
      //Thsts why we use factory constructor in WallpaperModel
      wallpaperModel =
          WallpaperModel.fromMap(element); //element here is JSON data
      wallpapers.add(wallpaperModel);
    });
    setState(() {});
  }

  @override
  void initState() {
    getTrendingWallpaper(); //TODO for bigger VERTIVAL LISTVIEW
    // FROM data.dart
    categories = getCategories(); //TODO  for small HORIZONTAL LIST VIEW
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                //TODOSEARCH BAR
                decoration: BoxDecoration(
                    color: Color(
                        0xfff5f8fd), //? HexCode of this colour. To Learn (Oxff defines Opacity)
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(horizontal: 24),
                margin: EdgeInsets.symmetric(
                    horizontal: 24), //? Padding is Inside, Margin is Outside
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        //? TextField is an INPUT DETECTOR. It will show in Debug Console
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: "search wallpaper",
                            border: InputBorder.none),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  // onchanged in searchQuery makes update one letter at a time
                                  builder: (context) => Search(
                                        searchQuery: searchController.text,
                                      )));
                        },
                        child: Container(child: Icon(Icons.search)))
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 80,
                //! Where is Navigator.push and Gesture Detector?
                child: ListView.builder(
                    //TODO HORIZONTAL SCROLL VIEW LEADING TO catagorie.dart
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoriesTile(
                          //GETTERS(get the value): categories[index].categorieName!, categories[index].imgUrl!
                          //SETTERS: in data.dart
                          title: categories[index]
                              .categorieName!, //TODO GET DATA FROM LIST
                          imgUrl: categories[index].imgUrl!);
                    }),
              ),
              //TODO LEADS TO widget.dart
              wallpaperList(wallpapers: wallpapers, context: context)
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  const CategoriesTile({Key? key, required this.title, required this.imgUrl})
      : super(key: key);
  //? imgUrl and title are Named Parameters
  final String imgUrl, title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                // onchanged in searchQuery makes update one letter at a time
                builder: (context) => Categorie(catagorieName: title)));
      },
      child: Container(
          margin: EdgeInsets.only(right: 4),
          child: Stack(
            children: [
              ClipRRect(
                  //! What is ClipRReact?
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imgUrl, //TODO comes from catagories.dart
                    height: 50,
                    width: 100,
                    fit: BoxFit.cover,
                  )),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black26,
                ),
                height: 50,
                width: 100,
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
              )
            ],
          )),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, avoid_unnecessary_containers
//? Inside JSON we have Map or List of Map
//List is collection of item of one kind
//Map is collection of Key Value pair
//? If JSON starts with { means we are getting a Map back
//? If starts with [ means we are getting a List of Maps back
// his APIkey:  563492ad6f9170000100000176c2c175fccd4ef49048d87c28263ebf

//In this case we want src => portrait value

import 'package:flutter/material.dart';
import 'package:wallpaper/data/data.dart';
import 'package:wallpaper/modals/categories_model.dart';
import 'package:wallpaper/widgets/widget.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategorieModel> categories = List();

  getTrendingWallpaper() {
    //! WTF is Uri.parse????
    // get bcoz this is a GET request
    var response = http
        .get(Uri.parse('https://api.pexels.com/v1/curated?per_page=15&page=1'));
  }

  @override
  void initState() {
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
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
                      decoration: InputDecoration(
                          hintText: "search wallpaper",
                          border: InputBorder.none),
                    ),
                  ),
                  Icon(Icons.search)
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 80,
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoriesTile(
                        title: categories[index].categorieName!,
                        imgUrl: categories[index].imgUrl!);
                  }),
            )
          ],
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
    return Container(
        margin: EdgeInsets.only(right: 4),
        child: Stack(
          children: [
            ClipRRect(
                //! What is ClipRReact?
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imgUrl,
                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,
                )),
            Container(
              color: Colors.black26,
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
        ));
  }
}

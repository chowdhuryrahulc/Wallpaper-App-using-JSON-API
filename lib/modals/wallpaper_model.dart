//? Here we are trying to get selected value of the fields from our JSON API
// we use Getters, in home.dart and setters in Wallpaper_Model
// set value to these variables
// get value from JSON

class WallpaperModel {
  String? photographer;
  String? photographer_url;
  int? photographer_id;
  SrcModel? srcModel;
// Creating named parameters
  WallpaperModel(
      {this.srcModel,
      this.photographer_url,
      this.photographer_id,
      this.photographer});

  //Accepts JSON and returns wallpaperModel
  //! What is a factory constructor?
  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
        srcModel: SrcModel.fromMap(jsonData["src"]),
        photographer_url: jsonData[
            "photographer_url"], // bcoz we need value of photographer_url from JSON API
        photographer_id: jsonData["photographer_id"],
        photographer: jsonData["photographer"]);
  }
}

// src has a Map {}
// thats why we create another class

class SrcModel {
  String? original;
  String? small;
  String? portrait;

  SrcModel({this.portrait, this.original, this.small});
  // This value comes from above factory constructor
  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(
        original: jsonData["original"],
        small: jsonData["small"],
        portrait: jsonData["portrait"]);
  }
}

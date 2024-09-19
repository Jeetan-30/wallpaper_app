class WallpaperModel{
  String imgURL;
  String photographar;
  String avaColor;
  String discription;

  WallpaperModel({
    required this.imgURL,
    required this.photographar,
    required this.avaColor,
    required this.discription
  });

  factory WallpaperModel.fromMap(Map<String, dynamic>map) {
    return WallpaperModel(
      imgURL: map["src"]["portrait"],
      photographar: map["photographer"],
      avaColor: map["avg_color"],
      discription: map["alt"],
    );
  }
}
import 'package:sky_watch_app/models/models.dart';

class BackgroundImage {
  int? page;
  int? perPage;
  List<Photo>? photos;
  int? totalResults;
  String? nextPage;

  BackgroundImage({
    this.page,
    this.perPage,
    this.photos,
    this.totalResults,
    this.nextPage,
  });

  factory BackgroundImage.fromJson(Map<String, dynamic> json) => BackgroundImage(
        page: json["page"],
        perPage: json["per_page"],
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        totalResults: json["total_results"],
        nextPage: json["next_page"],
      );
}

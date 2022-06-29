class Images {
  String id;
  String imageString;
  // Constractor Class
  Images({
    required this.id,
    required this.imageString,
  });
  // Function Convert Image In Json File
  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      id: json['id'] as String,
      imageString: json['imageCode'] as String,
    );
  }
}

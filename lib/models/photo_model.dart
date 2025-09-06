class PhotoModel {
  final String? url;
  final SrcModel? src;

  PhotoModel({this.url, this.src});

  factory PhotoModel.fromMap(Map<String, dynamic> json) {
    return PhotoModel(
      url: json['url'] as String?,
      src: json['src'] != null ? SrcModel.fromMap(json['src']) : null,
    );
  }
}

class SrcModel {
  final String? large;
  final String? medium;
  final String? small;
  final String? landscape;
  final String? portrait;

  SrcModel({
    this.large,
    this.medium,
    this.small,
    this.landscape,
    this.portrait,
  });

  factory SrcModel.fromMap(Map<String, dynamic> json) {
    return SrcModel(
      large: json['large'] as String?,
      medium: json['medium'] as String?,
      small: json['small'] as String?,
      portrait: json['portrait'] as String?,
      landscape: json['landscape'] as String?,
    );
  }
}

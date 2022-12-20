class VideoModel {
  VideoModel({
    required this.id,
    required this.results,
  });

  VideoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    results = List.from(json['results']).map((e) => VideoModelResults.fromJson(e)).toList();
  }
  late final int id;
  late final List<VideoModelResults> results;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['results'] = results.map((e) => e.toJson()).toList();
    return _data;
  }
}

class VideoModelResults {
  VideoModelResults({
    required this.iso_639_1,
    required this.iso_3166_1,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  VideoModelResults.fromJson(Map<String, dynamic> json) {
    iso_639_1 = json['iso_639_1'];
    iso_3166_1 = json['iso_3166_1'];
    name = json['name'];
    key = json['key'];
    site = json['site'];
    size = json['size'];
    type = json['type'];
    official = json['official'];
    publishedAt = json['published_at'];
    id = json['id'];
  }
  late final String iso_639_1;
  late final String iso_3166_1;
  late final String name;
  late final String key;
  late final String site;
  late final int size;
  late final String type;
  late final bool official;
  late final String publishedAt;
  late final String id;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['iso_639_1'] = iso_639_1;
    _data['iso_3166_1'] = iso_3166_1;
    _data['name'] = name;
    _data['key'] = key;
    _data['site'] = site;
    _data['size'] = size;
    _data['type'] = type;
    _data['official'] = official;
    _data['published_at'] = publishedAt;
    _data['id'] = id;
    return _data;
  }
}

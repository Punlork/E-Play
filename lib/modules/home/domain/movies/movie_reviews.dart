class MovieReviews {
  MovieReviews({
    required this.id,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  MovieReviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    page = json['page'];
    results = List.from(json['results']).map((e) => MovieReviewsResults.fromJson(e)).toList();
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
  late final int id;
  late final int page;
  late final List<MovieReviewsResults> results;
  late final int totalPages;
  late final int totalResults;
}

class MovieReviewsResults {
  MovieReviewsResults({
    required this.author,
    required this.authorDetails,
    required this.content,
    required this.createdAt,
    required this.id,
    required this.updatedAt,
    required this.url,
  });

  MovieReviewsResults.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    authorDetails = AuthorDetails.fromJson(json['author_details']);
    content = json['content'];
    createdAt = json['created_at'];
    id = json['id'];
    updatedAt = json['updated_at'];
    url = json['url'];
  }
  late final String author;
  late final AuthorDetails authorDetails;
  late final String content;
  late final String createdAt;
  late final String id;
  late final String updatedAt;
  late final String url;
}

class AuthorDetails {
  AuthorDetails({
    required this.name,
    required this.username,
    this.avatarPath,
    this.rating,
  });

  AuthorDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    avatarPath = json['avatar_path'];
    rating = json['rating'];
  }
  late final String name;
  late final String username;
  late final String? avatarPath;
  late final num? rating;
}

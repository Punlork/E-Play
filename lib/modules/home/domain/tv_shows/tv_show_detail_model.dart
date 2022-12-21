class TvShowDetailModel {
  TvShowDetailModel({
    this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.homepage,
    this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.seasons,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
  });
  TvShowDetailModel.fromJson(Map<String, dynamic> json)
      : backdropPath = json['backdrop_path'] as String?,
        createdBy = (json['created_by'] as List?)
            ?.map((dynamic e) => CreatedBy.fromJson(e as Map<String, dynamic>))
            .toList(),
        episodeRunTime = (json['episode_run_time'] as List?)?.map((dynamic e) => e as int).toList(),
        firstAirDate = json['first_air_date'] as String?,
        genres = (json['genres'] as List?)
            ?.map((dynamic e) => GenresTvShowDetail.fromJson(e as Map<String, dynamic>))
            .toList(),
        homepage = json['homepage'] as String?,
        id = json['id'] as int?,
        inProduction = json['in_production'] as bool?,
        languages = (json['languages'] as List?)?.map((dynamic e) => e as String).toList(),
        lastAirDate = json['last_air_date'] as String?,
        lastEpisodeToAir = (json['last_episode_to_air'] as Map<String, dynamic>?) != null
            ? LastEpisodeToAir.fromJson(json['last_episode_to_air'] as Map<String, dynamic>)
            : null,
        name = json['name'] as String?,
        nextEpisodeToAir = json['next_episode_to_air'],
        networks = (json['networks'] as List?)
            ?.map((dynamic e) => Networks.fromJson(e as Map<String, dynamic>))
            .toList(),
        numberOfEpisodes = json['number_of_episodes'] as int?,
        numberOfSeasons = json['number_of_seasons'] as int?,
        originCountry = (json['origin_country'] as List?)?.map((dynamic e) => e as String).toList(),
        originalLanguage = json['original_language'] as String?,
        originalName = json['original_name'] as String?,
        overview = json['overview'] as String?,
        popularity = json['popularity'] as double?,
        posterPath = json['poster_path'] as String?,
        productionCompanies = (json['production_companies'] as List?)
            ?.map(
                (dynamic e) => ProductionCompaniesTvShowDetail.fromJson(e as Map<String, dynamic>))
            .toList(),
        productionCountries = (json['production_countries'] as List?)
            ?.map(
                (dynamic e) => ProductionCountriesTvShowDetail.fromJson(e as Map<String, dynamic>))
            .toList(),
        seasons = (json['seasons'] as List?)
            ?.map((dynamic e) => Seasons.fromJson(e as Map<String, dynamic>))
            .toList(),
        spokenLanguages = (json['spoken_languages'] as List?)
            ?.map((dynamic e) => SpokenLanguagesTvShowDetail.fromJson(e as Map<String, dynamic>))
            .toList(),
        status = json['status'] as String?,
        tagline = json['tagline'] as String?,
        type = json['type'] as String?,
        voteAverage = json['vote_average'] as double?,
        voteCount = json['vote_count'] as int?;
  final String? backdropPath;
  final List<CreatedBy>? createdBy;
  final List<int>? episodeRunTime;
  final String? firstAirDate;
  final List<GenresTvShowDetail>? genres;
  final String? homepage;
  final int? id;
  final bool? inProduction;
  final List<String>? languages;
  final String? lastAirDate;
  final LastEpisodeToAir? lastEpisodeToAir;
  final String? name;
  final dynamic nextEpisodeToAir;
  final List<Networks>? networks;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompaniesTvShowDetail>? productionCompanies;
  final List<ProductionCountriesTvShowDetail>? productionCountries;
  final List<Seasons>? seasons;
  final List<SpokenLanguagesTvShowDetail>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;
}

class CreatedBy {
  CreatedBy({
    this.id,
    this.creditId,
    this.name,
    this.gender,
    this.profilePath,
  });
  CreatedBy.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        creditId = json['credit_id'] as String?,
        name = json['name'] as String?,
        gender = json['gender'] as int?,
        profilePath = json['profile_path'] as String?;
  final int? id;
  final String? creditId;
  final String? name;
  final int? gender;
  final String? profilePath;
}

class GenresTvShowDetail {
  GenresTvShowDetail({
    this.id,
    this.name,
  });
  GenresTvShowDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;
  final int? id;
  final String? name;
}

class LastEpisodeToAir {
  LastEpisodeToAir({
    this.airDate,
    this.episodeNumber,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.seasonNumber,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
  });
  LastEpisodeToAir.fromJson(Map<String, dynamic> json)
      : airDate = json['air_date'] as String?,
        episodeNumber = json['episode_number'] as int?,
        id = json['id'] as int?,
        name = json['name'] as String?,
        overview = json['overview'] as String?,
        productionCode = json['production_code'] as String?,
        seasonNumber = json['season_number'] as int?,
        stillPath = json['still_path'] as String?,
        voteAverage = json['vote_average'] as double?,
        voteCount = json['vote_count'] as int?;
  final String? airDate;
  final int? episodeNumber;
  final int? id;
  final String? name;
  final String? overview;
  final String? productionCode;
  final int? seasonNumber;
  final String? stillPath;
  final double? voteAverage;
  final int? voteCount;
}

class Networks {
  Networks({
    this.name,
    this.id,
    this.logoPath,
    this.originCountry,
  });
  Networks.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        id = json['id'] as int?,
        logoPath = json['logo_path'] as String?,
        originCountry = json['origin_country'] as String?;
  final String? name;
  final int? id;
  final String? logoPath;
  final String? originCountry;
}

class ProductionCompaniesTvShowDetail {
  ProductionCompaniesTvShowDetail({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });
  ProductionCompaniesTvShowDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        logoPath = json['logo_path'] as String?,
        name = json['name'] as String?,
        originCountry = json['origin_country'] as String?;
  final int? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;
}

class ProductionCountriesTvShowDetail {
  ProductionCountriesTvShowDetail({
    this.iso31661,
    this.name,
  });
  ProductionCountriesTvShowDetail.fromJson(Map<String, dynamic> json)
      : iso31661 = json['iso_3166_1'] as String?,
        name = json['name'] as String?;
  final String? iso31661;
  final String? name;
}

class Seasons {
  Seasons({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
  });
  Seasons.fromJson(Map<String, dynamic> json)
      : airDate = json['air_date'] as String?,
        episodeCount = json['episode_count'] as int?,
        id = json['id'] as int?,
        name = json['name'] as String?,
        overview = json['overview'] as String?,
        posterPath = json['poster_path'] as String?,
        seasonNumber = json['season_number'] as int?;
  final String? airDate;
  final int? episodeCount;
  final int? id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;
}

class SpokenLanguagesTvShowDetail {
  SpokenLanguagesTvShowDetail({
    this.englishName,
    this.iso6391,
    this.name,
  });
  SpokenLanguagesTvShowDetail.fromJson(Map<String, dynamic> json)
      : englishName = json['english_name'] as String?,
        iso6391 = json['iso_639_1'] as String?,
        name = json['name'] as String?;
  final String? englishName;
  final String? iso6391;
  final String? name;
}

part of 'services.dart';

class MovieServices {
  static Future<List<Movie>> getMovies(int page, {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$page";

    // cek client, kalo null diisi dengan Object Client
    client ??= http.Client();

    var response = await client.get(url);

    if (response.statusCode != 200) {
      return [];
    }

    var data = json.decode(response.body);
    // ambil data dengan key result (karena kalau dari tmdb nya result la hasil perfilm nya)
    List result = data['results'];
    return result.map((e) => Movie.fromJson(e)).toList();
  }
}

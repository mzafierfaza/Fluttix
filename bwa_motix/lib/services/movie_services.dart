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

  // fungsi untuk mendapatkan detail movie.
  static Future<MovieDetail> getDetails(Movie movie,
      {int movieID, http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/${movieID ?? movie.id}?api_key=$apiKey&language=en-US";

    client ??= http.Client();

    var response = await client.get(url);
    var data = json.decode(response.body);

    // kembalian API dari TMDB untuk bagian Genre nya dia list of map. jadi di dalam list masih ada key dan value lagi.
    // sedangkan yang ingin kita ambil cuma value dari 'name' aja contoh thriller,action dll

    List genres = (data as Map<String, dynamic>)['genres'];
    // ^ kita ambil dulu list of genre nya, yang masih ada key dan value nya, beulm dipisahin
    String language;

    // kembalian languange dari API nya berupan kode 'id, en, ja', dll.
    switch ((data as Map<String, dynamic>)['original_language'].toString()) {
      case 'ja':
        language = "Japanese";
        break;
      case 'id':
        language = "Indonesian";
        break;
      case 'ko':
        language = "Korean";
        break;
      case 'en':
        language = "English";
        break;
    }

    // baru di return hasilnya.
    return movieID != null
        ? MovieDetail(Movie.fromJson(data),
            language: language,
            // genre nya di mapping terlebih dahulu.
            genres: genres
                .map((e) => (e as Map<String, dynamic>)['name'].toString())
                .toList())
        : MovieDetail(movie,
            language: language,
            genres: genres
                .map((e) => (e as Map<String, dynamic>)['name'].toString())
                .toList());
  }

  // fungsi get credits untuk mengambil data dari para aktor dan fotonyaa
  static Future<List<Credit>> getCredits(int movieID,
      {http.Client client}) async {
    String url =
        "https://api.themoviedb.org/3/movie/$movieID/credits?api_key=$apiKey";

    client ??= http.Client();

    var response = await client.get(url);
    var data = json.decode(response.body);

    // jadi key nya 'cast' itu berbentuk list of map lagi (key dan value) seperti genre diatas
    // kita ambil saja bagian name dan profile path
    return ((data as Map<String, dynamic>)['cast'] as List)
        .map((e) => Credit(
            name: (e as Map<String, dynamic>)['name'],
            profilePath: (e as Map<String, dynamic>)['profile_path']))
        .take(8) // ambil 8 orang aja.
        .toList(); // dan diconvert jadi List.
  }
}

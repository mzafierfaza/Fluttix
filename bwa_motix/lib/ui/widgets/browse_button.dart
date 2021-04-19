part of 'widgets.dart';

class BrowseButton extends StatelessWidget {
  final String genre;

  BrowseButton(this.genre);

  @override
  Widget build(BuildContext context) {
    // print(genre);
    // return Text(genre);
    return Column(
      children: [
        Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage((genre == "War")
                        ? "assets/ic_war.png"
                        : (genre == "Action")
                            ? "assets/ic_action.png"
                            : (genre == "Drama")
                                ? "assets/ic_drama.png"
                                : (genre == "Horror")
                                    ? "assets/ic_horror.png"
                                    : (genre == "Crime")
                                        ? "assets/ic_crime.png"
                                        : (genre == "Music")
                                            ? "assets/ic_music.png"
                                            : "assets/logo.png")))),
        Text(genre)
      ],
    );
  }
}

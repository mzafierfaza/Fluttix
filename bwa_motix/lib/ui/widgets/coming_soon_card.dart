part of 'widgets.dart';

class ComingSoonCard extends StatelessWidget {
  // movie yabg akan di tampilkan
  final Movie movie;
  final Function onTap;

  ComingSoonCard(this.movie, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: NetworkImage(imageBaseURL + "w780" + movie.posterPath),
              fit: BoxFit.cover)),
      child: Container(
        // Container ini untuk lapisan sesudah gambar yang ada gradasi.
        height: 180,
        width: 210,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.61),
                  Colors.black.withOpacity(0)
                ])),
      ),
    );
  }
}

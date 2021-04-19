part of 'widgets.dart';

class RatingStars extends StatelessWidget {
  final double voteAverage;
  final double
      starSize; // sengaja masukin star size karena di tmpt lain perlu ngubah ukuran bintang dan fontsize nya.
  final double fontSize;
  final Color color;
  final MainAxisAlignment alignment;

  RatingStars(
      {this.voteAverage = 0,
      this.starSize = 20, // ini default nilai starszie dan fontsize nya
      this.fontSize = 12,
      this.color,
      this.alignment = MainAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    int n = (voteAverage / 2)
        .round(); // n untuk menghitung berapa bintang yang nyala
    // vote average kan dari 1 - 10, nah kita map jadi 1-5 bintang

    List<Widget> widgets = List.generate(
        // list widgets ini yang akan berisi bintang2 dan text nya.
        5, // pertama buat 5 bintang dulu
        (index) => Icon(
              index < n ? MdiIcons.star : MdiIcons.starOutline,
              color: secondaryColor,
              size: starSize,
            ));

    widgets.add(SizedBox(
      width: 3, // nambahin jarak space antar bintang
    ));
    widgets.add(Text(
      // ini barub tambahan text nya
      "$voteAverage/10",
      style: whiteTextFont.copyWith(
          color: color ?? Colors.white,
          fontWeight: FontWeight.w300,
          fontSize: fontSize),
    ));

    return Row(
      mainAxisAlignment: alignment,
      children: widgets,
    );
  }
}

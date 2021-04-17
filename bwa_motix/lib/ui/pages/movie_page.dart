part of 'pages.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // pake listview supaya bisa digeser / scroll
      children: [
        // NOTE: Header
        Container(
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 30),
            child: // menampilkan foto user, nama, dan saldo oleh karena itu kita akan ambil dari Bloc User.
                BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
              if (userState is UserLoaded) {
                // jika data user udah ke ambil
                // kalau image nya itu ada (user signup pake gambar) maka akan di upload
                if (imageFileToUpload != null) {
                  uploadImage(imageFileToUpload).then((downloadURL) {
                    imageFileToUpload =
                        null; // buat null lagi kalo selesai upload
                    // setelah selesai kita akan update data user
                    context.bloc<UserBloc>().add(UpdateData(
                        profileImage:
                            downloadURL)); // nampilin foto di mobvie page
                  }); // then kalau sudah selesai ngapain,
                }
                return Row(children: [
                  // NOTE: Profile Picture
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xFF5F558B), width: 1)),
                    child: Stack(children: [
                      SpinKitFadingCircle(
                        // kalau data gambar belum keload, maka tampil spinkit dulss
                        color: secondaryColor,
                        size: 50,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                // cek jika user string kosong / tidak upload foto maka tampilkan user_pic.png
                                image: (userState.user.profilePicture == ""
                                    ? AssetImage("assets/user_pic.png")
                                    : NetworkImage(
                                        userState.user.profilePicture)),
                                fit: BoxFit.cover)),
                      )
                    ]),
                  ),
                  // dari foto ada jarak width ke text
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        // hitung2an nya cek aja di video, itu supaya kalo text panjg bisa dipotong
                        width: MediaQuery.of(context).size.width -
                            2 * defaultMargin -
                            130, // di vidio ini jadi 78 nilai aslinyo
                        child: Text(
                          userState.user.name,
                          style: blackTextFont.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w400),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Text(
                          NumberFormat.currency(
                                  locale: "id_ID",
                                  decimalDigits: 0,
                                  symbol: "IDR ")
                              .format(userState.user.balance),
                          style: blueTextFont.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w800))
                    ],
                  ),
                ]);
              } else {
                // jika belum maka kita kasih indicator
                return SpinKitFadingCircle(
                  color: secondaryColor,
                  size: 50,
                );
              }
            })),
        Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 12),
          child: Text("New Movies",
              style: blackTextFont.copyWith(
                  fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
            height: 140,
            child: BlocBuilder<MovieBloc, MovieState>(builder: (_, movieState) {
              if (movieState is MovieLoaded) {
                List<Movie> movies = movieState.movies.sublist(0, 10);
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (_, index) => Container(
                        margin: EdgeInsets.all(5),
                        child: MovieCard(movies[index])));
              }
            }))
      ],
    );
  }
}

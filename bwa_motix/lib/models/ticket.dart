part of 'models.dart';

// class ticket.
class Ticket extends Equatable {
  final MovieDetail movieDetail; // movie apa
  final Theater theater; // theater mana
  final DateTime time; // waktunya
  final String bookingCode; // kode booking
  final List<String> seats; // bangku
  final String name; // nama pemesan
  final int totalPrice; // total harga

  Ticket(this.movieDetail, this.theater, this.time, this.bookingCode,
      this.seats, this.name, this.totalPrice);

  // method copywith untuk men copy object nya,
  Ticket copyWith(
          {MovieDetail movieDetail,
          Theater theater,
          DateTime time,
          String bookingCode,
          List<String> seats,
          String name,
          int totalPrice}) =>
      Ticket(
          // kita membuat object ticket yang baru dari hasil copyan, dan diubah nilai field nya.
          // jadi ketika ada parameter yang berubah, disini akan dimasukkan perubahannya
          movieDetail ?? this.movieDetail,
          theater ?? this.theater,
          time ?? this.time,
          bookingCode ?? this.bookingCode,
          seats ?? this.seats,
          name ?? this.name,
          totalPrice ?? this.totalPrice);

  // lalu ini ada getter untuk mengembalikan nomor bangku yang dipilih dalam bentuk String
  String get seatsInString {
    String s = '';

    for (var seat in seats) {
      s += seat + ((seat != seats.last) ? ', ' : '');
    }

    return s;
  }

  @override
  List<Object> get props =>
      [movieDetail, theater, time, bookingCode, seats, name, totalPrice];
}

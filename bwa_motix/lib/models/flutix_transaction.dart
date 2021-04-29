// Flutix transcaction ini berfungsi untuk mencatat transaksi yang terjadi di dalam transaksi aplikasi ini.
// yaitu Topup dan Beli Ticket.
//
part of 'models.dart';

class FlutixTransaction extends Equatable {
  final String userID; // user ID yang melakukan transaksi
  final String title; // judul film
  final String subtitle; // sub judul
  final int amount; // jumlah biaya dalam transaksi
  final DateTime time; // waktu transaksi
  final String picture; // kalau beli tiket , maka path poster film.

  FlutixTransaction(
      {@required this.userID,
      @required this.title,
      @required this.subtitle,
      this.amount = 0,
      @required this.time,
      this.picture});

  @override
  List<Object> get props => [userID, title, subtitle, amount, time, picture];
}

part of 'models.dart';

class Theater extends Equatable {
  final String name;

  Theater(this.name);

  @override
  List<Object> get props => [name];
}

List<Theater> dummyTheaters = [
  Theater("CGV Social Market"),
  Theater("XXI Palembang Indah Mall"),
  Theater("XXI Palembang Square"),
  Theater("XXI Palembang Icon")
];

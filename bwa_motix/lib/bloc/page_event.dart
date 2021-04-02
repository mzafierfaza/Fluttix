part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

// ini event-ecvent page dari yang kita buat
class GoToSplashPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToLoginPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToMainPage extends PageEvent {
  @override
  List<Object> get props => [];
}

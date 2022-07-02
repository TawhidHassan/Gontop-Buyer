part of 'game_cubit.dart';

@immutable
abstract class GameState {}

class GameInitial extends GameState {}
class GameCreated extends GameState {}
class GetAllGame extends GameState {
  final GameResponse? gameResponsel;

  GetAllGame({this.gameResponsel});
}

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Data/Model/Game/GameResponse.dart';
import '../../Repository/GameRepository/game_repository.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameRepository gameRepository=GameRepository();
  GameCubit() : super(GameInitial());

  void createGame(String? token, String name,String about,  File? image) {
    gameRepository.createGame(token,name,about,image).then((value) =>{
      emit(GameCreated())
    });
  }

  void getGames(String? token) {
    gameRepository.getGames(token).then((value) =>{
      emit(GetAllGame(gameResponsel: value))
    });
  }
}

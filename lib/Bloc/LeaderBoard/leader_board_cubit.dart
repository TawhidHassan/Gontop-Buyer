import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Data/LeaderBorad/LeaderBoardResponse.dart';
import '../../Repository/UserRepository/user_repository.dart';

part 'leader_board_state.dart';

class LeaderBoardCubit extends Cubit<LeaderBoardState> {
  UserRepository userRepository=UserRepository();
  LeaderBoardCubit() : super(LeaderBoardInitial());

  void getLeaderBoard(String? token) {
    userRepository.getLeaderBoard(token).then((value) => {
      if(value !=null){
        emit(getAllLeaderBoardusers(leaderBoardResponse: value))
      }
    });
  }
}

part of 'leader_board_cubit.dart';

@immutable
abstract class LeaderBoardState {}

class LeaderBoardInitial extends LeaderBoardState {}
class getAllLeaderBoardusers extends LeaderBoardState {
  final LeaderBoardResponse? leaderBoardResponse;

  getAllLeaderBoardusers({this.leaderBoardResponse});
}

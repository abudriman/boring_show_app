import 'package:get/state_manager.dart';

class TicTacToe extends GetxController {
  var board = Rx<List<String?>>(List.generate(9, (index) => null));

  final huPlayer = 'o';
  final aiPlayer = 'x';

  bool get isFinish => _isFull(board.value) || isWinnerDecided;
  bool get isWinnerDecided =>
      winning(board.value, huPlayer) || winning(board.value, aiPlayer);

  void onTap(int position) {
    if (board.value[position] == null && !isFinish) {
      board.value[position] = huPlayer;
      if (!isWinnerDecided && !isFinish) {
        final bestPosition = _minmax([...board.value], aiPlayer)['index'];
        board.value[bestPosition] = aiPlayer;
      }
      update();
    }
  }

  Map _minmax(List<String?> newBoard, String player) {
    var availSpots = _possibleMove(newBoard);

    if (winning(newBoard, huPlayer)) {
      return {'score': -10};
    } else if (winning(newBoard, aiPlayer)) {
      return {'score': 10};
    } else if (availSpots.isEmpty) {
      return {'score': 0};
    }

    var moves = <Map>[];
    for (var i in availSpots) {
      var move = {};
      move['index'] = i;
      newBoard[i] = player;
      if (player == aiPlayer) {
        var result = _minmax(newBoard, huPlayer);
        move['score'] = result['score'];
      } else {
        var result = _minmax(newBoard, aiPlayer);
        move['score'] = result['score'];
      }
      newBoard[i] = null;
      moves.add(move);
    }

    // ignore: prefer_typing_uninitialized_variables
    var bestMove;
    if (player == aiPlayer) {
      var bestScore = -10000;
      for (var i in moves) {
        if (i['score'] > bestScore) {
          bestScore = i['score'];
          bestMove = i;
        }
      }
    } else {
      var bestScore = 10000;
      for (var i in moves) {
        if (i['score'] < bestScore) {
          bestScore = i['score'];
          bestMove = i;
        }
      }
    }

    return bestMove;
  }

  List _possibleMove(board) {
    List<int> possibleMove = [];
    for (int i = 0; i < board.length; i++) {
      if (board[i] == null) {
        possibleMove.add(i);
      }
    }
    return possibleMove;
  }

  bool _isFull(List board) {
    return board.every((element) => element != null);
  }

  bool winning(board, player) {
    if ((board[0] == player && board[1] == player && board[2] == player) ||
        (board[3] == player && board[4] == player && board[5] == player) ||
        (board[6] == player && board[7] == player && board[8] == player) ||
        (board[0] == player && board[3] == player && board[6] == player) ||
        (board[1] == player && board[4] == player && board[7] == player) ||
        (board[2] == player && board[5] == player && board[8] == player) ||
        (board[0] == player && board[4] == player && board[8] == player) ||
        (board[2] == player && board[4] == player && board[6] == player)) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    board.value = List.generate(9, (index) => null);
    update();
  }
}

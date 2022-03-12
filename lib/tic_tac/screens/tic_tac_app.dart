import 'package:boring_show_app/tic_tac/controllers/tictac_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicTacApp extends StatelessWidget {
  const TicTacApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var controller = Get.put(TicTacToe());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tic Tac Toe'),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: GetBuilder<TicTacToe>(builder: (controller) {
              if (controller.winning(
                  controller.board.value, controller.huPlayer)) {
                return const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text('You Won!', style: TextStyle(fontSize: 50)),
                );
              } else if (controller.winning(
                  controller.board.value, controller.aiPlayer)) {
                return const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text('You Lose!', style: TextStyle(fontSize: 50)),
                );
              } else if (controller.isFinish && !controller.isWinnerDecided) {
                return const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text('Draw!', style: TextStyle(fontSize: 50)),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ),
          Align(
            alignment: Alignment.center,
            child: GetBuilder<TicTacToe>(builder: (controller) {
              return ticTacToeBoard(controller);
            }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GetBuilder<TicTacToe>(builder: (controller) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    controller.isFinish
                        ? ElevatedButton(
                            child: Row(
                              children: const [
                                Text('Play again'),
                                Icon(Icons.refresh)
                              ],
                            ),
                            onPressed: () => controller.reset(),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget ticTacToeBoard(TicTacToe controller) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ticTacToeButton(controller, 0),
              horizontalLine(),
              ticTacToeButton(controller, 1),
              horizontalLine(),
              ticTacToeButton(controller, 2),
            ],
          ),
          const Divider(
            color: Colors.grey,
            height: 0,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ticTacToeButton(controller, 3),
              horizontalLine(),
              ticTacToeButton(controller, 4),
              horizontalLine(),
              ticTacToeButton(controller, 5),
            ],
          ),
          const Divider(
            color: Colors.grey,
            height: 0,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ticTacToeButton(controller, 6),
              horizontalLine(),
              ticTacToeButton(controller, 7),
              horizontalLine(),
              ticTacToeButton(controller, 8),
            ],
          ),
        ],
      ),
    );
  }

  Widget ticTacToeButton(TicTacToe controller, int position) {
    return GestureDetector(
      onTap: () {
        controller.onTap(position);
      },
      child: xOrO(controller.board.value[position]),
    );
  }

  Widget horizontalLine() {
    return Container(
      width: 2,
      height: 120,
      color: Colors.grey,
    );
  }

  Widget xOrO(String? value) {
    switch (value) {
      case 'o':
        return const Center(
          child: Icon(
            Icons.circle_outlined,
            size: 120,
            color: Colors.black,
          ),
        );
      case 'x':
        return const Center(
          child: Icon(
            Icons.close,
            size: 120,
            color: Colors.black,
          ),
        );
      default:
        return Container(
          width: 120,
          height: 120,
          color: Colors.white,
        );
    }
  }
}

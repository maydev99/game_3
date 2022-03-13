import 'package:flutter/material.dart';
import 'package:layout/peep_run.dart';

class Hud extends StatefulWidget {
  static const id = 'Hud2';
  final PeepGame gameRef;

  const Hud({Key? key, required this.gameRef}) : super(key: key);

  @override
  _HudState createState() => _HudState();
}

class _HudState extends State<Hud> {
  bool isPaused = false;

  @override
  Widget build(BuildContext context) {
    var gameRef = widget.gameRef;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {
              if (!isPaused) {
                gameRef.pauseEngine();
              } else {
                gameRef.resumeEngine();
              }

              setState(() {
                isPaused = !isPaused;
              });

            },
            child: isPaused
                ? const Icon(
                    Icons.play_circle_outline,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.pause_circle_outline,
                    color: Colors.white,
                    size: 35,
                  )),
      ],
    );
  }
}

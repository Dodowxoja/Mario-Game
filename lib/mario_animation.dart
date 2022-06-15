import 'package:flutter/material.dart';

class MarioAnimation extends StatefulWidget {
  const MarioAnimation({Key? key}) : super(key: key);

  @override
  State<MarioAnimation> createState() => _MarioAnimationState();
}

class _MarioAnimationState extends State<MarioAnimation>
    with TickerProviderStateMixin {
  int ball = 0;
  bool gameOver = false;

  AnimationController? animationControllerMario;
  AnimationController? animationControllerWall;

  @override
  void initState() {
    super.initState();

    animationControllerMario = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: const Duration(milliseconds: 500),
    );

    animationControllerMario!.forward();

    animationControllerMario!.addListener(() {
      gameOverFunc();
      setState(() {});
    });

    animationControllerMario!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationControllerMario!.reverse();
      }
    });

    animationControllerWall = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 400.0,
      duration: const Duration(seconds: 2),
    );

    animationControllerWall!.forward();

    animationControllerWall!.addListener(() {
      gameOverFunc();
      setState(() {});
    });

    animationControllerWall!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationControllerWall!.repeat();
      }
    });
    ballMario();
  }

  ballMario() async {
    for (var i = 0; i <= ball; i++) {
      if (gameOver == false) {
        await Future.delayed(const Duration(milliseconds: 200), () {
          ball += 1;
          setState(() {});
        });
      } else {
        break;
      }
    }
  }

  gameOverFunc() {
    if (animationControllerWall!.value.toInt() >= 270) {
      if (animationControllerWall!.value.toInt() <= 350) {
        if (animationControllerMario!.value.toInt() <= 70) {
          animationControllerMario!.dispose();
          animationControllerWall!.dispose();
          gameOver = true;
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Column(
                    children: [
                      const Text('GAME OVER'),
                      IconButton(
                        color: Colors.green,
                        icon: const Icon(
                          Icons.replay,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MarioAnimation(),
                              ),
                              (route) => false);
                        },
                      )
                    ],
                  ),
                );
              });
          setState(() {});
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    //MARIO ANIMATION
                    Positioned(
                      left: 20,
                      bottom: animationControllerMario!.value,
                      child: Image.asset(
                        'assets/images/run_forward.gif',
                        height: 100,
                      ),
                    ),
                    //WALL ANIMATION
                    Positioned(
                      right: animationControllerWall!.value,
                      child: Image.asset(
                        'assets/images/mario_wall.png',
                        height: 70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.green,
                alignment: Alignment.center,
                child: Text(
                  "$ball",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          animationControllerMario = AnimationController(
            vsync: this,
            lowerBound: 0.0,
            upperBound: 170.0,
            duration: const Duration(milliseconds: 500),
          );
          animationControllerMario!.forward();
          animationControllerMario!.addListener(() {
            setState(() {});
          });
          animationControllerMario!.addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              animationControllerMario!.reverse();
            }
          });
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MarioView extends StatefulWidget {
  const MarioView({Key? key}) : super(key: key);

  @override
  State<MarioView> createState() => _MarioViewState();
}

class _MarioViewState extends State<MarioView> {
  bool gameOver = false;
  int ball = 0;
  double uzunlig = 0;
  double _sakrash = 1;
  double _containerYurishi = 1.6;
  @override
  void initState() {
    super.initState();
    next();
    a(context);
    ballMario();
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
                child: Stack(
                  children: [
                    //mario
                    Container(
                      alignment: Alignment(-0.7, _sakrash),
                      child: Image.asset(
                        'assets/images/run_forward.gif',
                        height: 100,
                      ),
                    ),
                    //Container
                    Align(
                      alignment: Alignment(_containerYurishi, 1),
                      child: Image.asset(
                        'assets/images/mario_wall.png',
                        height: 80,
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
        onTap: () async {
          a(context);
          for (var i = 0; i < 16; i++) {
            if (i < 8) {
              await Future.delayed(
                const Duration(milliseconds: 100),
                () {
                  _sakrash -= 0.1;
                  setState(() {});
                },
              );
            } else {
              await Future.delayed(
                const Duration(milliseconds: 100),
                () {
                  _sakrash += 0.1;
                  a(context);
                  setState(() {});
                },
              );
            }
          }
        },
      ),
    );
  }

  next() async {
    for (var i = 0; i <= i; i++) {
      if (gameOver == false) {
        await Future.delayed(const Duration(milliseconds: 200), () {
          _containerYurishi -= 0.1;
          if (_containerYurishi <= -1.6) {
            _containerYurishi = 1.6;
          }
          a(context);
        });
      } else {
        break;
      }
      setState(() {});
    }
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

  a(BuildContext context) async {
    if (_containerYurishi <= -0.35) {
      uzunlig = _containerYurishi;
      if (uzunlig >= -1) {
        if (_sakrash == 1) {
          gameOver = true;
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("GAME OWER"),
                    Text('You Ball: $ball'),
                    IconButton(
                      color: Colors.green,
                      icon: const Icon(Icons.refresh, size: 30),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const MarioView()),
                            (route) => false);
                      },
                    )
                  ],
                ),
              );
            },
          );
          setState(() {});
        }
      }
    }
    setState(() {});
  }
}

import 'package:flutter/material.dart';

class MarioView extends StatefulWidget {
  const MarioView({Key? key}) : super(key: key);

  @override
  State<MarioView> createState() => _MarioViewState();
}

class _MarioViewState extends State<MarioView> {
  double uzunlig = 0;
  double _sakrash = 1;
  double _containerYurishi = 1.6;
  @override
  void initState() {
    super.initState();
    a(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        child: Column(
          children: [
            Expanded(
              flex: 2,
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
                        height: 100,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Chap
                  InkWell(
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: const Icon(Icons.arrow_back),
                    ),
                    onTap: () {
                      _containerYurishi -= 0.1;
                      if (_containerYurishi <= -1.6) {
                        _containerYurishi = 1.6;
                        print(_containerYurishi);
                      }
                      a(context);
                      setState(() {});
                    },
                  ),
                  //O'ng
                  InkWell(
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: const Icon(Icons.arrow_forward),
                    ),
                    onTap: () {
                      _containerYurishi += 0.1;

                      a(context);
                      setState(() {});
                    },
                  )
                ],
              ),
            )),
          ],
        ),
        onTap: () async {
          a(context);
          for (var i = 0; i < 20; i++) {
            if (i < 10) {
              await Future.delayed(
                const Duration(milliseconds: 10),
                () {
                  _sakrash -= 0.1;
                  setState(() {});
                },
              );
            } else {
              await Future.delayed(
                const Duration(milliseconds: 10),
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

  a(BuildContext context) async {
    print(_containerYurishi);
    if (_containerYurishi <= -0.35) {
      uzunlig = _containerYurishi;
      if (uzunlig >= -1) {
        if (_sakrash == 1) {
          showDialog(
            context: context,
            builder: (_) {
              return const AlertDialog(
                title: Text('Game Ower'),
              );
            },
          );
          print("GAME OWER");
        }
      }
    }
    setState(() {});
  }
}

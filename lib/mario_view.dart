import 'package:flutter/material.dart';

class MarioView extends StatefulWidget {
  MarioView({Key? key}) : super(key: key);

  @override
  State<MarioView> createState() => _MarioViewState();
}

class _MarioViewState extends State<MarioView> {
  double _sakrash = 1;

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
                        alignment: Alignment(-1, _sakrash),
                        child: Image.asset(
                          'assets/images/run_forward.gif',
                          height: 100,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: const Alignment(1, 1),
                        child: Image.asset(
                          'assets/images/mario_wall.png',
                          height: 100,
                        ),
                      ),
                    ],
                  )),
            ),
            Expanded(child: Container(color: Colors.green)),
          ],
        ),
        onTap: () async {
          for (var i = 0; i < 20; i++) {
            if (i < 10) {
              await Future.delayed(
                const Duration(milliseconds: 10),
                () {
                  _sakrash -= 0.1;
                  print('SAKRASH: ' + _sakrash.toString());
                  setState(() {});
                },
              );
            } else {
              await Future.delayed(
                const Duration(milliseconds: 10),
                () {
                  print('SAKRASH: ' + _sakrash.toString());
                  _sakrash += 0.1;
                  setState(() {});
                },
              );
            }
          }
        },
      ),
    );
  }
}

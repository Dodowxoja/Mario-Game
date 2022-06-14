import 'dart:math' as math;
import 'package:flutter/material.dart';

class MarioPage extends StatefulWidget {
  const MarioPage({Key? key}) : super(key: key);

  @override
  State<MarioPage> createState() => _MarioPageState();
}

class _MarioPageState extends State<MarioPage> {
  late Size _size;
  double _xMario = 0.0;
  double _yMario = 1.0;
  double _xBackground = 1.0;
  bool _isJump = false;
  bool _isUp = false;
  bool _isForward = true;
  bool _buttonPressed = false;
  bool _loopActive = false;
  int _counter = 0;
  String _marioImage = "assets/images/mario.png";

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(body: _getBody());
  }

  _getBody() => SizedBox(
        child: Column(
          children: [
            Expanded(flex: 2, child: _getMario()),
            Expanded(
              flex: 1,
              child: Container(color: Colors.green[800], child: _getButtons()),
            ),
          ],
        ),
      );

  _getMario() => Stack(
        alignment: Alignment(_xBackground, 1.0),
        children: [
          Container(
            alignment: Alignment(_xMario, _yMario),
            width: _size.width,
            color: Colors.blue,
            child: SizedBox(
              height: 56.0,
              width: 56.0,
              child: Transform(
                alignment: Alignment.center,
                transform: (!_isForward)
                    ? Matrix4.rotationY(math.pi)
                    : Matrix4.rotationY(0.0),
                child: Image.asset(_marioImage),
              ),
            ),
          ),
          SizedBox(
            width: 45,
            height: 45,
            child: Image.asset("assets/images/mario_wall.png"),
          )
        ],
      );

  _getButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              /// Orqaga yurish uchun button
              Listener(
                onPointerDown: (details) {
                  _buttonPressed = true;
                  _isForward = false;
                  _increaseCounterWhilePressed(false);
                  _marioImage = "assets/images/run_forward.gif";
                },
                onPointerUp: (details) {
                  _buttonPressed = false;
                  _marioImage = "assets/images/mario.png";
                },
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black38,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 12.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  child: const Icon(Icons.arrow_back_ios_outlined),
                  onPressed: () {},
                ),
              ),

              /// Oldinga yurish uchun button
              Listener(
                onPointerDown: (details) {
                  _buttonPressed = true;
                  _isForward = true;
                  _increaseCounterWhilePressed(true);
                  _marioImage = "assets/images/run_forward.gif";
                },
                onPointerUp: (details) {
                  _buttonPressed = false;
                  _marioImage = "assets/images/mario.png";
                },
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black38,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 12.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  child: const Icon(Icons.arrow_forward_ios_outlined),
                  onPressed: () {},
                ),
              ),
            ],
          ),

          /// Hisobni ko`rsatish uchun TEXT
          _setCounter(),

          /// Marioni sakratish uchun Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black38,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12.0),
            ),
            onPressed: _onJumpPressed,
            child: const Icon(Icons.arrow_circle_up_outlined, size: 48.0),
          ),
        ],
      );

  ///
  _onJumpPressed() async {
    for (int i = 0; i < 100; i++) {
      await Future.delayed(
        const Duration(milliseconds: 5),
        () {
          setState(
            () {
              if (_isUp) {
                _yMario -= 0.02;
                if (_yMario <= 0.3) _isUp = false;
              } else if (!_isUp) {
                _yMario += 0.02;
                if (_yMario >= 1.0) {
                  _isUp = true;
                  _isJump = !_isJump;
                }
              }
            },
          );
        },
      );

      /// Agar Marioning pozitsiyasi 0.0 ga teng bo`lsa va harakatlanmayotgan
      /// bo`lsa isJump`ning qiymatini true qiladi va loop`ni sindiradi.
      if (!_isJump) {
        _isJump = !_isJump;
        break;
      }
    }
  }

  /// To`siqdan sakrab o`tganida hisobni oshirish uchun
  _setCounter({color = Colors.white, fontWeight = FontWeight.bold}) {
    if (_xBackground < 0.0 && _xBackground > -0.03) _counter++;
    return Text(
      "$_counter",
      style: TextStyle(color: color, fontSize: 24.0, fontWeight: fontWeight),
    );
  }

  /// Button bosib turilganida ishlaydi.
  void _increaseCounterWhilePressed(bool isForward) async {
    // make sure that only one loop is active
    if (_loopActive) return;

    _loopActive = true;

    while (_buttonPressed) {
      // do your thing
      setState(
        () {
          for (var i = 0; i < 1; i++) {
            if (isForward) {
              if (!(_xMario >= 0.0)) {
                _xMario += 0.03;
              } else {
                _xBackground -= 0.03;
                if (_xBackground <= -1.3) _xBackground = 1.3;
              }
            } else {
              if (!(_xMario <= -1.0)) _xMario -= 0.03;
            }
            i = 0;
          }
        },
      );

      // wait a bit
      await Future.delayed(const Duration(milliseconds: 40));
    }

    _loopActive = false;
  }
}

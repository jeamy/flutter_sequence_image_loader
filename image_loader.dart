import 'package:flutter/material.dart';
import 'dart:async';

class ImageLoader extends StatefulWidget {
  @override
  _ImageLoaderState createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _opacityTween;
  Timer _timer;
  int _imageIndex;

  final List<String> _sliderNetList = [
    'http://www.example.com/img/start_slider/slide_00001.png',
    'http://www.example.com/img/start_slider/slide_00002.png',
    'http://www.example.com/img/start_slider/slide_00003.png',
    'http://www.example.com/img/start_slider/slide_00004.png',
    'http://www.example.com/img/start_slider/slide_00005.png',
  ];

  final List<String> _sliderAssetList = [
    'img/start_slider/slide_00001.png',
    'img/start_slider/slide_00002.png',
    'img/start_slider/slide_00003.png',
    'img/start_slider/slide_00004.png',
    'img/start_slider/slide_00005.png',
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
        value: 0,
        lowerBound: 0,
        upperBound: 1);
    _opacityTween =
        CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    _controller.forward();
    _imageIndex = _sliderAssetList.length;
    startTimer();
  }

  void startTimer() {
    const timer = const Duration(milliseconds: 1000);
    _timer = new Timer.periodic(
      timer,
      (Timer timer) {
        print(_imageIndex);
        if (_imageIndex == 1) {
          setState(() {
            _imageIndex = _sliderAssetList.length;
          });
        } else {
          setState(() {
            _imageIndex--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityTween,
      child: Container(
        alignment: Alignment.center,
        child: Image.asset(
          _sliderAssetList[_imageIndex - 1],
          width: MediaQuery.of(context).size.width * 0.55,
          height: MediaQuery.of(context).size.height * 0.55,
          semanticLabel: 'Schaufenster',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

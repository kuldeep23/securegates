import 'package:flutter/material.dart';

class CallAcceptDenySlider extends StatefulWidget {
  final VoidCallback onAccept;
  final VoidCallback onDeny;

  const CallAcceptDenySlider({
    Key? key,
    required this.onAccept,
    required this.onDeny,
  }) : super(key: key);

  @override
  _CallAcceptDenySliderState createState() => _CallAcceptDenySliderState();
}

class _CallAcceptDenySliderState extends State<CallAcceptDenySlider> {
  double _sliderWidth = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: const ListTile(
            leading: Icon(Icons.call),
            title: Text('Incoming Call'),
          ),
        ),
        Positioned(
          right: 0,
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                _sliderWidth =
                    (_sliderWidth + details.delta.dx).clamp(0.0, 160.0);
              });
            },
            onHorizontalDragEnd: (details) {
              if (_sliderWidth >= 80) {
                widget.onDeny();
              }
              setState(() {
                _sliderWidth = 0;
              });
            },
            child: Container(
              color: Colors.red,
              width: _sliderWidth,
              height: 56,
              child: const Center(
                child: Text(
                  'Deny',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: _sliderWidth,
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                _sliderWidth =
                    (_sliderWidth + details.delta.dx).clamp(0.0, 160.0);
              });
            },
            onHorizontalDragEnd: (details) {
              if (_sliderWidth < 80) {
                widget.onAccept();
              }
              setState(() {
                _sliderWidth = 0;
              });
            },
            child: Container(
              color: Colors.green,
              width: 160 - _sliderWidth,
              height: 56,
              child: const Center(
                child: Text(
                  'Accept',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

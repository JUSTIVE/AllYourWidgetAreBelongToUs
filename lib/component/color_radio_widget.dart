import 'dart:async';

import 'package:flutter/material.dart';

class ColorRadio extends StatefulWidget {
  @override
  _ColorRadioState createState() => _ColorRadioState();
}

class _ColorRadioState extends State<ColorRadio> {
  StreamController<int> _streamController = StreamController<int>.broadcast();
  int currentColorId = 0;
  List<ColorListItem> _colorListItem;
  Color getCurrentColor() => colorTable[currentColorId];
  final List<Color> colorTable = [
    Colors.blue.shade300,
    Colors.red.shade300,
    Colors.amber.shade300,
    Colors.purpleAccent.shade400
  ];

  void onTouch(int id) {
    setState(() {
      this.currentColorId = id;
      _streamController.add(this.currentColorId);
    });
  }

  @override
  void initState() {
    _colorListItem = this
        .colorTable
        .asMap()
        .map((index, color) => MapEntry(
            index,
            ColorListItem(
              stream: _streamController.stream,
              color: color,
              colorId: index,
              onTouch: (int id) {
                this.currentColorId = id;
                print(this.currentColorId);
              },
            )))
        .values
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: _colorListItem,
      ),
    );
  }
}

class ColorListItem extends StatefulWidget {
  final Color color;
  final int colorId;
  final Stream<int> stream;
  final Function(int) onTouch;
  final ColorRadio parent;

  ColorListItem(
      {@required this.parent,
      @required this.color,
      @required this.colorId,
      @required this.onTouch,
      @required this.stream});
  @override
  _ColorListItemState createState() =>
      _ColorListItemState();
}

class _ColorListItemState extends State<ColorListItem> {
  bool _selected = false;
  
  void updateSelected(bool newSelected) {
    setState(() {
      _selected = newSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Stack(children: [
        InkWell(
          onTap: () {
            widget.onTouch(widget.colorId);
            widget.stream.listen((parentId) {
              _selected = parentId == widget.colorId;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: widget.color, borderRadius: BorderRadius.circular(16)),
            height: 48,
            width: 48,
          ),
        ),
        Visibility(
          visible: _selected,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16)),
            height: 48,
            width: 48,
            child: Center(
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
        )
      ]),
    );
  }
}

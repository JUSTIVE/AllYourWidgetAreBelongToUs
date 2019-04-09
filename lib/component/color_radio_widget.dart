import 'dart:async';

import 'package:flutter/material.dart';

class ColorRadio extends StatefulWidget {
  static int currentColorId = 0;
  static final List<Color> colorTable = [
    Colors.blue.shade300,
    Colors.red.shade300,
    Colors.amber.shade300
  ];

  static Color getCurrentColor() => colorTable[currentColorId];

  @override
  _ColorRadioState createState() => _ColorRadioState();
}

class _ColorRadioState extends State<ColorRadio> {
  List<ColorListItem> _colorListItem;

  StreamController<List<bool>> _updater = StreamController<List<bool>>();

  void onTouch(int id) {
    ColorRadio.currentColorId = id;

  }

  @override
  void initState() {
    _colorListItem = ColorRadio.colorTable
        .asMap()
        .map((index, color) => MapEntry(
            index,
            ColorListItem(
              color: color,
              colorId: index,
              onTouch: (int id) {},
              stream: _updater.stream
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
  final Function(int) onTouch;
  final Stream<List<bool>> stream;
  ColorListItem(
      {@required this.color,
      @required this.colorId,
      @required this.onTouch,
      @required this.stream});
  @override
  _ColorListItemState createState() => _ColorListItemState();
}

class _ColorListItemState extends State<ColorListItem> {

  bool _selected=false;

  void updateSelected(bool newSelected){
    setState((){
      _selected = newSelected;
    });
  }

  @override
  void initState() {
    widget.stream.listen((selected){updateSelected(selected[widget.colorId]);});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Stack(children: [
        InkWell(
          onTap: widget.onTouch(widget.colorId),
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

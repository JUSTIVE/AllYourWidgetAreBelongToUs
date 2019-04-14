import 'package:flutter/material.dart';

class ColorRadio extends StatefulWidget {
  static List<Color> colorTable = [
    Colors.blue.shade300,
    Colors.red.shade300,
    Colors.amber.shade300,
    Colors.purple.shade300
  ];
  ColorRadio({Key key}) : super(key: key);
  @override
  ColorRadioState createState() => ColorRadioState();
}

class ColorRadioState extends State<ColorRadio> {
  int currentColorId;
  List<ColorRadioItem> _colorListItem = [];

  void itemTouchAction(int id) {
    setState(() {
      currentColorId = id;
      _colorListItem = ColorRadio.colorTable
          .asMap()
          .map((index, color) => MapEntry(
              index,
              ColorRadioItem(
                colorId: index,
                color: color,
                selected: index == currentColorId,
                action: itemTouchAction,
              )))
          .values
          .toList();
      debugPrint(currentColorId.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    currentColorId = 0;
    _colorListItem = ColorRadio.colorTable
        .asMap()
        .map((index, color) => MapEntry(
            index,
            ColorRadioItem(
              colorId: index,
              color: color,
              selected: index == currentColorId,
              action: itemTouchAction,
            )))
        .values
        .toList();
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

class ColorRadioItem extends StatefulWidget {
  final Color color;
  final int colorId;
  final bool selected;
  final Function(int) action;
  ColorRadioItem(
      {@required this.color,
      @required this.colorId,
      @required this.selected,
      @required this.action});

  @override
  _ColorRadioItemState createState() => _ColorRadioItemState();
}

class _ColorRadioItemState extends State<ColorRadioItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: Stack(children: [
        InkWell(
          onTap: () {
            widget.action(widget.colorId);
          },
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: widget.color),
          ),
        ),
        Visibility(
          visible: widget.selected,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white.withOpacity(0.5)),
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

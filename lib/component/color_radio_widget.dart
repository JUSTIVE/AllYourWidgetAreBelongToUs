import 'package:flutter/material.dart';

class ColorRadio extends StatefulWidget {
  static int currentColorId=0;
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

  @override
  void initState() {
    _colorListItem = ColorRadio.colorTable
        .asMap()
        .map((index, color) => MapEntry(
            index,
            ColorListItem(
              color: color,
              colorId: index,
            )))
        .values
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: _colorListItem,
    );
  }
}

class ColorListItem extends StatefulWidget {
  final Color color;
  final int colorId;

  ColorListItem({
    @required this.color,
    @required this.colorId,
  });
  @override
  _ColorListItemState createState() => _ColorListItemState();
}

class _ColorListItemState extends State<ColorListItem> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Stack(children: [
        InkWell(
          onTap: () {
            
          },
          child: Container(
            decoration: BoxDecoration(
                color: widget.color, borderRadius: BorderRadius.circular(16)),
            height: 48,
            width: 48,
          ),
        ),
        Visibility(
          // visible: colorId == widget.colorId,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16)),
            height: 48,
            width: 48,
          ),
        )
      ]),
    );
  }
}

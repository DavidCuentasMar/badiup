import 'package:badiup/colors.dart';
import 'package:flutter/material.dart';

class QuantityController extends ValueNotifier<int> {
  QuantityController({int value, this.maxCounterValue}) : super(value);

  int get quantity => value;

  final int maxCounterValue;

  set quantity(int newValue) {
    value = newValue;
  }
}

class QuantitySelector extends StatefulWidget {
  QuantitySelector({
    Key key,
    this.controller,
    this.orientation,
    this.iconSize = 24.0,
  })  : assert(controller != null),
        assert(orientation != null),
        super(key: key);

  final QuantityController controller;
  final Orientation orientation;
  final double iconSize;

  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  double buttonIconSize;
  double buttonSize;

  @override
  void initState() {
    buttonIconSize = 0.875 * widget.iconSize;
    buttonSize = widget.iconSize;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = widget.orientation == Orientation.landscape
        ? <Widget>[
            _buildDecreaseQuantityButton(),
            _buildQuantityDisplay(),
            _buildIncreaseQuantityButton(),
          ]
        : <Widget>[
            _buildIncreaseQuantityButton(),
            _buildQuantityDisplay(),
            _buildDecreaseQuantityButton(),
          ];

    return Padding(
      padding: EdgeInsets.all(0),
      child: widget.orientation == Orientation.landscape
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widgetList,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widgetList,
            ),
    );
  }

  Widget _buildQuantityDisplay() {
    double shortSideSize = widget.iconSize;
    double longSideSize = 2 * shortSideSize;

    return Container(
      alignment: AlignmentDirectional.center,
      color: kPaletteWhite,
      height: widget.orientation == Orientation.landscape
          ? shortSideSize
          : longSideSize,
      width: widget.orientation == Orientation.landscape
          ? longSideSize
          : shortSideSize,
      child: Text(
        widget.controller.value.toString(),
        style: TextStyle(
          color: paletteBlackColor,
          fontWeight: FontWeight.bold,
          fontSize: 0.625 * widget.iconSize,
        ),
      ),
    );
  }

  Widget _buildIncreaseQuantityButton() {
    return GestureDetector(
      onTap: () {
        if (widget.controller.value < widget.controller.maxCounterValue) {
          setState(() {
            widget.controller.value++;
          });
        }
      },
      child: _buildIncreaseQuantityButtonVisuals(),
    );
  }

  Widget _buildIncreaseQuantityButtonVisuals() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
          height: buttonSize,
          width: buttonSize,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: widget.controller.value >= widget.controller.maxCounterValue
                ? paletteDarkGreyColor
                : paletteForegroundColor,
            borderRadius: widget.orientation == Orientation.landscape
                ? BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
          ),
        ),
        Icon(
          Icons.add,
          color: kPaletteWhite,
          size: buttonIconSize,
        ),
      ],
    );
  }

  Widget _buildDecreaseQuantityButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.controller.value =
              widget.controller.value <= 1 ? 1 : widget.controller.value - 1;
        });
      },
      child: _buildDecreaseQuantityButtonVisuals(),
    );
  }

  Widget _buildDecreaseQuantityButtonVisuals() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
          height: buttonSize,
          width: buttonSize,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: widget.controller.value <= 1
                ? paletteDarkGreyColor
                : paletteBlackColor,
            borderRadius: widget.orientation == Orientation.landscape
                ? BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  )
                : BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
          ),
        ),
        Icon(
          Icons.remove,
          color: kPaletteWhite,
          size: buttonIconSize,
        ),
      ],
    );
  }
}

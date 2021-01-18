import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holding_gesture/holding_gesture.dart';

class ComboSliderDouble extends StatefulWidget {
  ComboSliderDouble(this.label, this.value, this.minValue, this.maxValue, this.step, this.onChangedCallBack, {Key key})
      : super(key: key);

  final double step;
  final double value;
  final double minValue;
  final double maxValue;
  final String label;
  final Function(double) onChangedCallBack;

  @override
  _ComboSliderDoubleState createState() => _ComboSliderDoubleState();
}

class _ComboSliderDoubleState extends State<ComboSliderDouble> {
  String valueText;
  var editController = TextEditingController(text: '');
  var editFocusNode = FocusNode();

  void onChanged(double value) {
    setState(() {
      widget.onChangedCallBack(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    int divisions = (widget.maxValue - widget.minValue).floor() ~/ widget.step;
    valueText = widget.value.round().toString();
    editController.text = valueText;
    editFocusNode.addListener(() {
      if(editFocusNode.hasFocus) {
        editController.selection = TextSelection(
          baseOffset: 0,
          extentOffset: valueText.length,
        );
      }
      else
        editController.selection = TextSelection(
          baseOffset: 0,
          extentOffset: 0,
        );
    });

    return Container(
        constraints: BoxConstraints(maxWidth: 1200.0, maxHeight: 700.0),
        padding: EdgeInsets.all(8.0),
        color: Colors.blueGrey[300],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
                flex: 5,
                child: Text(
                  widget.label,
                  style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
                )),
            Flexible(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      HoldDetector(
                        holdTimeout: Duration(milliseconds: 100),
                        onHold: () => onChanged(widget.value - widget.step),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(5.0)),
                              minimumSize: MaterialStateProperty.all<Size>(Size.square(50))),
                          onPressed: () => onChanged(widget.value - widget.step),
                          child: Text(
                            "-",
                            style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              focusNode: editFocusNode,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              onSubmitted: (newText) {

                                double parsedValue = double.tryParse(newText.substring(0, newText.length - 1)).floorToDouble();
                                if (parsedValue != null) {
                                  if (parsedValue > widget.maxValue) parsedValue = widget.maxValue;

                                  if (parsedValue < widget.minValue) parsedValue = widget.minValue;

                                  widget.onChangedCallBack(parsedValue);
                                }
                                else
                                  editController.text = widget.value.toString();
                              },
                              textAlign: TextAlign.center,
                              controller: editController,
                              style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
                            ),
                          )),
                      HoldDetector(
                        holdTimeout: Duration(milliseconds: 100),
                        onHold: () => onChanged(widget.value + widget.step),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(5.0)),
                              minimumSize: MaterialStateProperty.all<Size>(Size.square(50))),
                          onPressed: () => onChanged(widget.value + widget.step),
                          child: Text(
                            "+",
                            style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Flexible(
                flex: 1,
                child: Slider(
                    value: widget.value,
                    min: widget.minValue,
                    max: widget.maxValue,
                    divisions: divisions,
                    onChanged: (double value) {
                      setState(() {
                        widget.onChangedCallBack(value);
                      });
                    }))
          ],
        ));
  }

  @override
  void dispose() {
    editController.dispose();
    super.dispose();
  }
}

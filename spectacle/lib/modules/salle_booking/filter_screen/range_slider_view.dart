import 'package:flutter/material.dart';

class RangeSliderView extends StatefulWidget {
  final Function(RangeValues) onChangeRangeValues;
  final RangeValues values;
  RangeSliderView({Key? key, required this.onChangeRangeValues, required this.values}) : super(key : key);

  @override
  State<RangeSliderView> createState() => _RangeSliderViewState();
}

class _RangeSliderViewState extends State<RangeSliderView> {
  late RangeValues _values;

  @override
  void initState() {
    _values = widget.values;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Row(
                children: [
                  Expanded(child: SizedBox(),
                  flex: _values.start.round(),
                  ),
                  Container(
                    width: 54,
                    child: Text("\$${_values.start.round()}", textAlign: TextAlign.center,),
                  ),
                  Expanded(
                    flex: 1000 - _values.start.round(),
                    child: SizedBox(),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: _values.end.round(),
                    child: SizedBox(),
                  ),
                  Container(
                    width: 54,
                    child: Text(
                      "\$${_values.end.round()}",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1000 - _values.end.round(),
                    child: SizedBox(),
                  )
                ],
              )
            ],
          ),

          SliderTheme(
            data: SliderThemeData(),
            child: RangeSlider(
              values: _values,
              min: 10.0,
              max: 1000.0,
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Colors.grey.withOpacity(0.4),
              divisions: 1000,
              onChanged: (RangeValues values) {
                try{
                  setState(() {
                    _values = values;
                  });
                  widget.onChangeRangeValues(_values);
                }catch(e){}
              },
             ))
        ],
      ),
    );
  }
}
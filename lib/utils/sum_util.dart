import 'package:flutter/widgets.dart';

class SumUtil extends StatefulWidget {
  final Iterable<int> arrayOfNumbers;
  final TextStyle style;
  const SumUtil({ Key? key, required this.arrayOfNumbers, this.style = const TextStyle(fontSize: 30) }) : super(key: key);

  @override
  _SumUtilState createState() => _SumUtilState();
}

class _SumUtilState extends State<SumUtil> {
  @override
  Widget build(BuildContext context) {
    String sum = widget.arrayOfNumbers.reduce((a, b) => a + b).toString();

    return Text(sum, style: widget.style,);
  }
}
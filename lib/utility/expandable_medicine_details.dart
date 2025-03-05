import 'package:flutter/material.dart';

class ExpandableMedicineDetails extends StatefulWidget {
  bool isExpanded = false;
  final Widget? collapsedChild;
  final Widget? expandedChild;

  ExpandableMedicineDetails({Key? key, this.collapsedChild, this.expandedChild})
    : super(key: key);

  @override
  State<ExpandableMedicineDetails> createState() =>
      _ExpandableMedicineDetailsState();
}

class _ExpandableMedicineDetailsState extends State<ExpandableMedicineDetails> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isExpanded = !widget.isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: widget.isExpanded ? widget.expandedChild : widget.collapsedChild,
      ),
    );
  }
}

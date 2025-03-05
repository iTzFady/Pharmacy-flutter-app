import 'package:flutter/material.dart';

class ExpandableStockDetails extends StatefulWidget {
  bool isExpanded = false;
  final Widget? collapsedChild;
  final Widget? expandedChild;
  final VoidCallback onTap;
  ExpandableStockDetails({
    Key? key,
    this.collapsedChild,
    this.expandedChild,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ExpandableStockDetails> createState() => _ExpandableStockDetailsState();
}

class _ExpandableStockDetailsState extends State<ExpandableStockDetails> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          widget.isExpanded = !widget.isExpanded;
        });
      },
      onTap: () {
        widget.onTap();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: widget.isExpanded ? widget.expandedChild : widget.collapsedChild,
      ),
    );
  }
}

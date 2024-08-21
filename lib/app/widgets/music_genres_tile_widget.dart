import 'package:flutter/material.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';

class MusicGenreTileWidget extends StatefulWidget {
  final List<String> options;
  final ValueChanged<String> onSelected;
  final List<String> initialSelected;

  const MusicGenreTileWidget({
    super.key,
    required this.options,
    required this.onSelected,
    required this.initialSelected,
  });

  @override
  _MusicGenreTileWidgetState createState() => _MusicGenreTileWidgetState();
}

class _MusicGenreTileWidgetState extends State<MusicGenreTileWidget> {
  late List<String> selectedOptions;

  @override
  void initState() {
    super.initState();
    selectedOptions = widget.initialSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start, // Aligns tiles to the start (left-aligned)
      spacing: 8.0, // Increased horizontal spacing
      runSpacing: 6.0, // Increased vertical spacing
      children: widget.options.map((option) {
        bool isSelected = selectedOptions.contains(option);
        return ElevatedButton(
          onPressed: () {
            setState(() {
              isSelected
                  ? selectedOptions.remove(option)
                  : selectedOptions.add(option);
            });
            widget.onSelected(option);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor:
            isSelected ? VoidColors.whiteColor : VoidColors.secondary,
            backgroundColor:
            isSelected ? VoidColors.secondary : Colors.white,
            side: BorderSide(color: VoidColors.secondary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0), // Adjust padding for better button sizing
          ),
          child: Text(
            option,
            style: TextStyle(fontSize: 14.0), // Ensure text is easily readable
          ),
        );
      }).toList(),
    );
  }
}

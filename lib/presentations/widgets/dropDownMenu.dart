import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dropdownmenu extends StatefulWidget {
  const Dropdownmenu({
    super.key,
    required this.onChanged,
    required this.items,
    required this.hint,
    required this.bordercolor,
    required this.verticalpadding,
  });

  final void Function(String? value) onChanged;
  final List<String> items;
  final String hint;
  final Color bordercolor;
  final double verticalpadding;

  @override
  State<Dropdownmenu> createState() => _DropdownmenuState();
}

String Gordita = "Gordita";

class _DropdownmenuState extends State<Dropdownmenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.white,
      elevation: 16,
      isExpanded: true,
      borderRadius: BorderRadius.circular(10),
      icon: Icon(CupertinoIcons.chevron_down),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: widget.verticalpadding,
        ),
        fillColor: Colors.white,
        filled: true,
        // hintText: widget.hint,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: widget.bordercolor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: widget.bordercolor),
        ),
      ),
      hint: Text(
        widget.hint,
        style: TextStyle(
          color: Colors.grey,
          fontFamily: "Gordita",
          fontSize: 14,
        ),
      ),
      iconSize: 20,
      style: TextStyle(
        color: Colors.black,
        fontFamily: "Gordita",
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: widget.onChanged,
    );
  }
}

import 'package:flutter/material.dart';

class TextfieldW extends StatelessWidget {
  const TextfieldW({super.key, required this.titleController});
  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: titleController,
      style: TextStyle(color: Colors.black, fontSize: 20),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8),
        fillColor: Colors.grey.shade100,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: 'Add your To-Dos',
        prefixIcon: Icon(Icons.pending_actions_rounded),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      autofillHints: [],
      keyboardType: TextInputType.text,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubit/states.dart';
import 'package:notes_app/home.dart';
import 'package:notes_app/shared/components.dart';

import '../cubit/cubit.dart';

class NoteScreen extends StatelessWidget {
  int? id;
  String? noteText;
  String? noteDate;
  NoteScreen({super.key, this.noteText, this.noteDate, this.id});

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = BlocProvider.of<AppCubit>(context);
    TextEditingController mycontroller = TextEditingController();
    mycontroller.text = noteText!;
    // TextEditingController? noteController = TextEditingController();
    // noteController.text =
    //     'contes about the notes and its contentcontes about the notes and its contentcontes about the notes and its contentcontes about the notes and its contentcontes about the notes and its contentcontes about the notes and its contentcontes about the notes and its content';
    return BlocConsumer<AppCubit, NotesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    cubit.deleteData(id: id!);
                    navigateAndFinish(context, HomePage());
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    noteDate!,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                    // maxLines: null,
                    controller: mycontroller,
                    style: TextStyle(fontSize: 20),
                    onChanged: (String value) {
                      AppCubit.get(context).updateData(
                          body: mycontroller.text,
                          date: DateTime.now().toString(),
                          id: id!);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubit/states.dart';

import '../cubit/cubit.dart';

class NoteScreen extends StatelessWidget {
  String? noteText;
  NoteScreen({super.key, this.noteText});

  @override
  Widget build(BuildContext context) {
    // TextEditingController? noteController = TextEditingController();
    // noteController.text =
    //     'contes about the notes and its contentcontes about the notes and its contentcontes about the notes and its contentcontes about the notes and its contentcontes about the notes and its contentcontes about the notes and its contentcontes about the notes and its content';
    return BlocConsumer<AppCubit, NotesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of<AppCubit>(context);
        cubit.noteController.text= noteText!;
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    '{4 April}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    maxLines: 100,
                    controller:cubit.noteController ,
                    style: TextStyle(fontSize: 20),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubit/states.dart';
import 'package:notes_app/home.dart';
import 'package:notes_app/shared/components.dart';

import '../cubit/cubit.dart';

class AddNoteScreen extends StatelessWidget {
  AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, NotesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        TextEditingController _Controller = TextEditingController();
        AppCubit cubit = BlocProvider.of<AppCubit>(context);

        return Scaffold(
          appBar: AppBar(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_Controller.text != "") {
                cubit.insertDataBase(
                    body: _Controller.text, date: DateTime.now().toString());
                cubit.noteController.text = _Controller.text;
              }
              navigateAndFinish(context, HomePage());
            },
            child: Center(
                child: Text(
              'Add Note',
              textAlign: TextAlign.center,
            )),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              autofocus: true,
              
              decoration: InputDecoration(border: InputBorder.none),
              maxLines: null,
              controller: _Controller,
            ),
          )),
        );
      },
    );
  }
}

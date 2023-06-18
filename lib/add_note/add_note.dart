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
                cubit.insertDataBase(body: _Controller.text, date: '4 april');
                cubit.noteController.text = _Controller.text;
              }
              navigateAndFinish(context, HomePage());
            },
            child: Text('Add Note'),
            shape: StadiumBorder(),
          ),
          body: SingleChildScrollView(
              child: TextField(
            maxLines: 100,
            controller: _Controller,
          )),
        );
      },
    );
  }
}

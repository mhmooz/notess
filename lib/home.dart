import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/add_note/add_note.dart';
import 'package:notes_app/cubit/states.dart';
import 'package:notes_app/note_screen/note_screen.dart';
import 'package:notes_app/shared/components.dart';

import 'cubit/cubit.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, NotesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of<AppCubit>(context);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple[200],
            title: Text(
              'Notes App',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigateTo(context, AddNoteScreen());
            },
            child: Icon(Icons.add),
          ),
          body: GridView.count(
            crossAxisCount: 2,
            // mainAxisSpacing: 40,
            // crossAxisSpacing: 20,
            childAspectRatio: 1 / 1.5,
            children: List.generate(
                cubit.notes.length,
                (index) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          int id = cubit.notes[index]['id'];
                          String noteText = cubit.notes[index]['body'];
                          String noteDate = DateFormat.yMMMd().format(
                              DateTime.parse(cubit.notes[index]['date']));
                          navigateTo(
                              context,
                              NoteScreen(
                                  noteText: noteText, noteDate: noteDate , id: id));
                        },
                        child: Container(
                          width: 100,
                          height: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   "note title",
                              //   style: TextStyle(
                              //       color: Colors.black,
                              //       fontSize: 20,
                              //       fontWeight: FontWeight.bold),
                              // ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              Container(
                                width: double.infinity,
                                height: 220,
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${cubit.notes[index]['body']}",
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              Spacer(),
                              Center(
                                  child: Text(DateFormat.yMMMd().format(
                                      DateTime.parse(
                                          cubit.notes[index]['date'])))),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
          ),
        );
      },
    );
  }
}

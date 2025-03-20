import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _taskcontroller = TextEditingController();
  List<String> listTugas = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Page'), centerTitle: true
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Form(
                    key: _key,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _taskcontroller,
                            decoration: InputDecoration(
                              label: Text('Tugas'),
                              hintText: 'Masukkan tugas yang ingin dilakukan'
                            ),
                            validator: (value) {
                              if(value!.isEmpty){
                                return 'Tugas tidak boleh kosong';
                              }
                              return null;
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                          )
                        )
                      ],
                    )
                  ),
                  FilledButton(onPressed: (){}, child: Text('Submit'))
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}
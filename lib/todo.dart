import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _taskcontroller = TextEditingController();
  final TextEditingController _datecontroller = TextEditingController();
  List<String> listTugas = [];

  void addData(){
    setState(() {
      listTugas.add(_taskcontroller.text);
      _taskcontroller.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tugas berhasil ditambahkan!'),
        duration: Duration(seconds: 3),
      )
    );
  }
  Future<void> _selectDateTime(BuildContext context)async{
    List<DateTime>? dateTimeList = await showOmniDateTimeRangePicker(
      context: context,
      is24HourMode: true,
      minutesInterval: 1,
      isForce2Digits: true,
    );
    if(dateTimeList != null && dateTimeList.isNotEmpty){
      setState(() {
        _datecontroller.text =
        "${dateTimeList.first.toLocal()} - ${dateTimeList.last.toLocal()}";
      });
    }
  }
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
                        ),
                        FilledButton(onPressed: (){
                          if(_key.currentState!.validate()){
                            addData();
                          }
                        }, child: Text('Submit')),
                      ],
                    )
                  ),

              Expanded(
                child: ListView.builder(
                  itemCount: listTugas.length,
                  itemBuilder: (context, index){
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.pink.shade100,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nama Tugas'), Text(listTugas[index])
                        ],
                      ),
                    );
                  },
                ))
            ],
          ),
        )
      ),
    );
  }
}
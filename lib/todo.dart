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
  List<Map<String, dynamic>> listTugas = [];

  void addData(){
    setState(() {
      listTugas.add({
        "task": _taskcontroller.text,
        "date": _datecontroller.text,
        "completed": false,
      });
      _taskcontroller.clear();
      _datecontroller.clear();
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          TextFormField(
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
                          ),
                          TextFormField(
                            controller: _datecontroller,
                            decoration: InputDecoration(
                              labelText: "Tanggal dan Waktu",
                              hintText: "Pilih tanggal dan waktu",
                              suffixIcon: IconButton(
                                onPressed: () =>_selectDateTime(context), 
                                icon: Icon(Icons.calendar_today)
                              )
                            ),
                            validator: (value) {
                              if (value!.isEmpty){
                                return 'Tanggal tidak boleh kosong';
                              }
                              return null;
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            readOnly: true,
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
                      child: Row(
                        children: [
                          Checkbox(
                            value: listTugas[index]["completed"] ?? false,
                            onChanged: (bool? value){
                              setState(() {
                                listTugas[index]["completed"] = value ?? false;
                              });
                            },
                          ),
                          Expanded(
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nama Tugas:'), 
                              Text(listTugas[index]["task"]!),
                              Text('Tanggal & Waktu'),
                              Text(listTugas[index]["date"]!),
                              SizedBox(height: 5),
                              Text(
                                listTugas[index]["completed"] ? 'Completed' : 'Not Completed',
                                style: TextStyle(
                                  color: listTugas[index]["completed"] ? Colors.green.shade400 : Colors.red,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ]
                            
                            )
                          ),
                          IconButton(onPressed: (){
                            setState(() {
                              listTugas.removeAt(index);
                            });
                          }, icon: Icon(Icons.delete, color: Colors.grey,))
                        ],
                      ),
                      
                    );
                  },
                )
              )
            ],
          ),
        )
      ),
    );
  }
}
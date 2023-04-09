import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_first_app/app_large_text.dart';
import 'package:my_first_app/app_small_text.dart';
import 'package:my_first_app/person_list.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<PersonList> _personList = [
    PersonList(name: 'Pourou', description: 'ML Engineer'),
    PersonList(name: 'Amara', description: 'EEE Engineer'),
    PersonList(name: 'Rahul', description: 'Software Engineer'),
    PersonList(name: 'Fru', description: 'Data Scientist'),
    PersonList(name: 'Ali', description: 'EEE Engineer'),
    PersonList(name: 'Vincent', description: 'Civil Engineer'),
    PersonList(name: 'Fulgence', description: 'Mechanical Engineer'),
    PersonList(name: 'Silvain', description: 'EEE Engineer'),
    PersonList(name: 'Tani', description: 'Architect'),
    PersonList(name: 'Thomas', description: 'Mechatronic Engineer'),
    PersonList(name: 'Rachid', description: 'Mechatronic Engineer'),
    PersonList(name: 'Shifiu', description: 'Radiologist'),
  ];

  var _startPops;

  @override
  void initState() {
    super.initState();
    _startPops = _personList.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 30, left: 5, right: 5),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: _personList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  print('You tapped on list tile ${index}');
                },
                onLongPress: () {
                  print('You lonpressed on list tile ${index}');
                },
                leading: CircleAvatar(
                  child: AppLargeText(
                    text: _personList[index].name.toString()[0],
                    size: 20,
                  ),
                  backgroundColor: Colors.amberAccent,
                ),
                title: AppLargeText(
                  text: _personList[index].name,
                  size: 20,
                ),
                subtitle: AppSmallText(
                  text: _personList[index].description,
                  size: 15,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteMessage(context, index);
                  },
                ),
              );
            }),
      ),
    );
  }

  _deleteMessage(BuildContext context, int index) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: AppLargeText(
              text: 'Delete this message',
              size: 15,
            ),
            content: AppSmallText(
              text: 'Do you want to delete this message ?',
              size: 20,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _personList.length < _startPops
                      ? ScaffoldMessenger.of(context).removeCurrentSnackBar()
                      : null;
                  _performDeletion(context, index);
                },
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.amber.withOpacity(1.0)),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'No',
                  style: TextStyle(color: Colors.amber.withOpacity(1.0)),
                ),
              ),
            ],
          );
        });
  }

  void _performDeletion(BuildContext context, int index) async {
    var _undoLength;
    var _delLength;
    Navigator.of(context).pop();
    var deletedRecord = _personList[index];
    setState(() {
      _personList.removeAt(index);
      _delLength = _personList.length;
    });
    final snackBar = SnackBar(
      duration: Duration(seconds: 4),
      backgroundColor: Colors.amberAccent,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Text(
        'deletion of ${deletedRecord.name}',
        style: TextStyle(color: Colors.black),
      ),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _personList.insert(index, deletedRecord);
            _undoLength = _personList.length;
          });
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //_personList.length < _startPops ? Navigator.of(context).pop() : null;

    await Future.delayed(Duration(seconds: 5));
    _personList.length == _undoLength
        ? null
        : Fluttertoast.showToast(msg: 'Deleted successful');
  }
}

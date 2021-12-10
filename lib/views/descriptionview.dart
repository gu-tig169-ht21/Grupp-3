import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/model.dart';
import 'package:provider/provider.dart';

class DescriptionView extends StatefulWidget {
  final task;

  DescriptionView(this.task);

  @override
  State<DescriptionView> createState() {
    return DescriptionViewState(task);
  }
}

class DescriptionViewState extends State<DescriptionView> {
  final task;
  DescriptionViewState(this.task);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Granska uppgift'),
        actions: [
          ElevatedButton(
            onPressed: () {
              print('edit');
            },
            child: Text('Ändra', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 23),
              margin: EdgeInsets.only(top: 30),
              child: Text('Titel',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ),
            titleViewWidget(),
            Container(
              padding: EdgeInsets.only(left: 23),
              margin: EdgeInsets.only(top: 20),
              child: Text('Deadline',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ),
            deadlineViewWidget(),
            Container(
              padding: EdgeInsets.only(left: 23),
              margin: EdgeInsets.only(top: 20),
              child: Text('Beskrivning',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ),
            descriptionViewWidget(),
          ],
        ),
      ),
    ); //Ändra editknapp
  }

  Widget titleViewWidget() {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.indigo),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: ListTile(
        title: Text(task.title),
      ),
    );
  }

  Widget deadlineViewWidget() {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.indigo),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: ListTile(
        title: Text(task.deadline),
      ),
    );
  }

  Widget descriptionViewWidget() {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.indigo),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: ListTile(
        title: Text(task.description),
      ),
    );
  }
}

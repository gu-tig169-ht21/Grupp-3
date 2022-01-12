import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/model.dart';
import 'package:my_first_app/views/taskviews/edittaskview.dart';
import 'package:provider/provider.dart';

////Sida för att granska en uppgift
class DescriptionView extends StatefulWidget {
  final task;
  const DescriptionView(this.task);

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
        title: const Text('Review assignment'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              var updatedItem = await Navigator.push( 
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditTaskView((TaskItem( //Koppling till värdena i TaskItem
                          id: task.id,
                          title: task.title,
                          deadline: task.deadline,
                          description: task.description)))));
              if (updatedItem != null) { //När en uppgift är ändrad uppdateras den
                Provider.of<MyState>(context, listen: false)
                    .updateTask(updatedItem);
                Navigator.pop(context);
              }
            },
            child: const Text('Edit',
                style: TextStyle(color: Colors.white, fontSize: 17)),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 23),
              margin: const EdgeInsets.only(top: 30),
              child: const Text('Title',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ),
            titleViewWidget(),
            Container(
              padding: const EdgeInsets.only(left: 23),
              margin: const EdgeInsets.only(top: 20),
              child: const Text('Deadline',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ),
            deadlineViewWidget(),
            Container(
              padding: const EdgeInsets.only(left: 23),
              margin: const EdgeInsets.only(top: 20),
              child: const Text('Description',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ),
            descriptionViewWidget(),
          ],
        ),
      ),
    );
  }

  //Fältet för att visa titeln
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

  //Fältet för att visa deadline
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

  //Fältet för att visa description
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

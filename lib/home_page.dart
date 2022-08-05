import 'package:flutter/material.dart';
import 'package:votebreakfast/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

final _fireStore = FirebaseFirestore.instance;
Future<void> getData() async {
  // Get docs from collection reference
  QuerySnapshot querySnapshot = await _fireStore.collection('BreakFastItems').get();

  // Get data from docs and convert map to List
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  //for a specific field
  final alData =
  querySnapshot.docs.map((doc) => doc.get('fieldname')).toList();

  print(alData);
}

class _HomePageState extends State<HomePage>{
   late TextEditingController controller;
   late TextEditingController controller1;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TextEditingController();
    controller1 = TextEditingController();
  }
  List<String> n = ["Bread", "Jam", "Milk"];
   List<int> e = [1,2,1];
  @override
  void dispose() {
    controller.dispose();
    controller1.dispose();
    super.dispose();
  }
  String N = FirebaseAuth.instance.currentUser!.displayName!;
  String N1 = FirebaseAuth.instance.currentUser!.email!;
   int count=0;
  String name="";
   String name1="";
  //String? user = FirebaseAuth.instance.currentUser!.email ?? FirebaseAuth.instance.currentUser!.displayName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(
              N == null ? " ": N,
              style: const TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              N1 == null? " ":N1,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              padding: const EdgeInsets.all(10),
              color: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child: const Text(
                'Breakfast options',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('BreakfastItems'),
                      content: setup(),
                    ));
              },
            ),
            MaterialButton(
              padding: const EdgeInsets.all(10),
              color: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child: const Text(
                'Add Breakfast Options',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Add Item'),
                      content: TextField(
                        controller: controller,
                        decoration: InputDecoration(hintText: 'Enter the item you want to add'),
                      ),
                      actions: [
                        TextButton(onPressed: submit , child: Text('Submit'))
                      ],
                    ));
              },
            ),
            MaterialButton(
              padding: const EdgeInsets.all(10),
              color: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child: const Text(
                'Vote',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              onPressed: () {
                count==0? showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Vote'),
                      content: TextField(
                        controller: controller1,
                        decoration: InputDecoration(hintText: 'Enter the item you want to vote'),
                      ),
                      actions: [
                        TextButton(onPressed: submit1 , child: Text('Submit'))
                      ],
                    )) : showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Vote'),
                      content: Text('You have already voted')
                    ));
              },
            ),
            MaterialButton(
              padding: const EdgeInsets.all(10),
              color: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child: const Text(
                'LOG OUT',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              onPressed: () {
                AuthService().signOut();
              },
            ),
          ],
        ),
      ),
    );
  }

   Widget setup() {
     return Container(
       height: 200.0, // Change as per your requirement
       width: 200.0, // Change as per your requirement
       child: ListView.builder(
         itemCount: n.length,
         itemBuilder: (BuildContext context, int index) {
           return ListTile(
             title: Text(n.elementAt(index)+"    Current Vote - "+e.elementAt(index).toString()),
           );
         },
       ),
     );
   }

  void submit(){
     name = controller.text;
     n.add(name);
     e.add(0);
     Navigator.of(context).pop();
  }

   void submit1(){
     name1 = controller1.text;
     count=1;
     e[n.indexOf(name1)]++;
     Navigator.of(context).pop();
   }
}

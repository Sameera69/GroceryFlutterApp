import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocary/Models/GItem.dart';
import 'package:grocary/Models/GList.dart';
import 'package:grocary/Pages/AddIPage.dart';
import 'package:grocary/Pages/ItemPage.dart';
import 'package:uuid/uuid.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  List<GItem> GListItem = [];
  List<GList> GItemList = [];
  List<String> list = ['خيار','جزر','طماطم','طماطم كرزية','ليمون','جرجير','بصل اخضر',
  'بقدونس','فجل','كوسا','فلفل','فلفل طرشي',
  'باذنجان','بطاطس','خس','كرنب','بصل','ثوم','ذره','ذره مثلجة','فاصوليا','بزاليا','دجاج',
  'لحم مفرومه','ملخية','باميا','بنجر','فاصوليا حمرا','بيض',
  'تونه','سالمون','جبنه بيضاء','جبنة الطيبات','فليديلفيا','جبنه صفرا','جبنه بقره','جبنه سايله',
  'زيتون','مقدوس','قشطه','دقيق','شوفان','صلصة','رز الوليمه',
  'رز','زيت قلي','زيت','ملح','سكر','نسكايه','2 في 1','حليب ناديك','حليب ابو قوس','لبن'];
  @override
  void initState() {
    listenToGItem();
    listenToGList();
    super.initState();
  }

  listenToGItem() {
    FirebaseFirestore.instance.collection('GItem').snapshots().listen((event) {
      List<GItem> newList = [];
      for (final doc in event.docs) {
        final itemList = GItem.fromMap(doc.data());
        newList.add(itemList);
      }
      GListItem = newList;
      setState(() {});
    });
  }

  listenToGList() {
    FirebaseFirestore.instance.collection('GList').snapshots().listen((event) {
      List<GList> newList2 = [];
      for (final doc in event.docs) {
        final itemList = GList.fromMap(doc.data());
        newList2.add(itemList);
      }
      GItemList = newList2;
      setState(() {});
    });
  }

  Future<List<GItem>> getGItem() async {
    final collection = await FirebaseFirestore.instance.collection('GItem').get();
    List<GItem> newList = [];
    for (final doc in collection.docs) {
      final restaurant = GItem.fromMap(doc.data());
      newList.add(restaurant);
    }
    return newList;
  }

  Future<List<GList>> getGList() async {
    final collection = await FirebaseFirestore.instance.collection('GList').get();
    List<GList> newList2 = [];
    for (final doc in collection.docs) {
      final restaurant = GList.fromMap(doc.data());
      newList2.add(restaurant);
    }
    return newList2;
  }
  
  setlist(){
    for (var n in list){
      var uuid = Uuid();
      final Nitem = GList(id: uuid.v4(), name: n, a: 255, r: 255, g: 255, b: 255);
      final GItemCollection = FirebaseFirestore.instance.collection('GList');
      final GItemDoc = GItemCollection.doc(Nitem.id);
      GItemDoc.set(Nitem.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
         iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(widget.title, style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Wrap(
                  spacing: 4.0, // gap between adjacent chips
                  runSpacing: 4.0, // gap between lines
                  children: <Widget>[
                  for (var item in GItemList)
                      Container(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(item.a, item.r, item.g, item.b),
                          border: Border.all(color: Color.fromARGB(189, 84, 83, 83)),
                          borderRadius: const BorderRadius.all(Radius.circular(5))),
                        child: InkWell(
                            onTap: () {
                              setState(() {
                              if (item.r == 171){
                                item.r = 255;
                                item.g = 255;
                                item.b = 255;
                              }else{
                                item.r = 171;
                                item.g = 188;
                                item.b = 196;
                              }
                              FirebaseFirestore.instance.collection('GList').doc(item.id).update({'r': item.r, 'g':item.g, 'b':item.b});
                              },);
                            },
                            child: Text(
                              item.name,
                              style: TextStyle(color: Color.fromARGB(255, 81, 78, 78)),
                            )),
                    )
                  ]
                )
              ),             
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    border: Border.all(color: const Color.fromARGB(190, 200, 200, 200)),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddIPage(
                                    i: 'New Item',
                                  )));
                    },
                    child: const Text(
                      'Add new to the list',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Text('List Count: ${GListItem.length}', style: const TextStyle(color: Colors.black)),
              const SizedBox(
                height: 10,
              ),
              for (var item in GListItem)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ItemPage(
                                              i: item,
                                            )));
                              },
                              child: SizedBox(
                                width: 100,
                                child: Text(
                                  item.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              )),
                          InkWell(
                            onTap: () {
                              showAlertDialog(context, item);
                              setState(() {});
                            },
                            child: const Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, GItem i) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Delete"),
      
      onPressed: () {
        // Appdata.glist.remove(i);
        final GItemCollection = FirebaseFirestore.instance.collection('GItem');
        final GItemDoc = GItemCollection.doc(i.id);
        GItemDoc.delete();
        setState(() {});
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete"),
      content: Text("Would you like to delete ${i.name}?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

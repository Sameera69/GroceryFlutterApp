import 'package:flutter/material.dart';
import 'package:grocary/Models/GItem.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key, required this.i});

  final GItem i;
  @override
  State<ItemPage> createState() => _ItemPage();
}

class _ItemPage extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(widget.i.name, style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.network(
                widget.i.imageUrl,
                width: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.i.name,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

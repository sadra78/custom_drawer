import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: myApp(),
  ));
}

class myApp extends StatefulWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> with SingleTickerProviderStateMixin {
  var childRadius = 0.0;
  var maxSlide = 225.0;
  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000));

  void toggle() {
    if (_animationController.isDismissed) {
      childRadius = 30.0;
      _animationController.forward();
    } else {
      _animationController.reverse().whenComplete(() => childRadius = 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: toggle,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            var slide = _animationController.value * maxSlide;
            var scale = 1 - (_animationController.value * 0.3);

            return Stack(
              children: [
                myDrawer(),
                Transform(
                  transform: Matrix4.identity()
                    ..translate(slide)
                    ..scale(scale),
                  alignment: Alignment.centerLeft,
                  child: myChild(),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget myDrawer() {
    return Container(
      color: Colors.blueAccent[700],
      child: Row(
        children: [
          Flexible(
            flex: 55,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    "Drawer Header",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Home"),
                  ),
                  ListTile(
                    title: Text("Shop"),
                  ),
                  ListTile(
                    title: Text("News"),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Logout"),
                  ),
                  ListTile(
                    title: Text("Exit"),
                  ),
                  ElevatedButton(onPressed: () {}, child: Text("Subscribe")),
                ],
              ),
            ),
          ),
          Flexible(
            child: Container(),
            flex: 45,
          )
        ],
      ),
    );
  }

  Widget myChild() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(blurRadius: 30.0, color: Colors.black)],
        borderRadius: BorderRadius.all(Radius.circular(childRadius)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(childRadius)),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  toggle();
                },
                icon: const Icon(Icons.view_headline)),
          ),
          body: Container(
            decoration: const BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 30.0, color: Colors.black)],
              gradient: LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.redAccent,
                ],
                begin: Alignment.topLeft,
              ),
            ),
            child: const Center(
              child: Text(
                "Custom Drawer Animation Test",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

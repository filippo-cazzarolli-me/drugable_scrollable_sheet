import 'package:flutter/material.dart';

class DraggableScrollable extends StatelessWidget {
  const DraggableScrollable({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              child: Image.asset(
            height: size.height,
            "assets/img/map.png",
            fit: BoxFit.cover,
          )),
          Positioned(
              child: DraggableScrollableSheet(
                  maxChildSize: 0.9,
                  minChildSize: 0.2,
                  builder: (context, controller) {
                    return Material(
                      elevation: 15,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(40)),
                      color: Colors.white,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          children: [
                            Center(
                              child: Container(
                                height: 3,
                                width: 50,
                                color: Colors.black45,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text("Are you ready to start your journey"),
                            const Text("Where are you going?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 28)),
                            ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: 25,
                                controller: controller,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: const Icon(
                                      Icons.location_on_outlined,
                                      size: 30,
                                    ),
                                    title: Text(
                                      "Item $index",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text("Subtitle $index"),
                                  );
                                }),
                          ],
                        ),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}

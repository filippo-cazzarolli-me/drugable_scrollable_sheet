import 'package:flutter/material.dart';

class DraggableScrollable2 extends StatelessWidget {
  const DraggableScrollable2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DraggableScrollableSheet(
          builder: (BuildContext context, ScrollController controller) {
            return Container(
              color: Colors.orange,
              child: ListView.builder(
                controller: controller,
                itemCount: 25,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const Icon(
                      Icons.location_on_outlined,
                      size: 30,
                    ),
                    title: Text(
                      'Location $index',
                      style: const TextStyle(fontSize: 20),
                    ),
                    subtitle: const Text('Subtitle'),
                    onTap: () {
                      print('Location $index');
                    },
                  );
                },
              ),
            );
          }
      ),
    );
  }
}

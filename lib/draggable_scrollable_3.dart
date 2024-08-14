import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DraggableScrollable3 extends StatefulWidget {
  const DraggableScrollable3({super.key});

  @override
  State<DraggableScrollable3> createState() => _DraggableScrollable3State();
}

class _DraggableScrollable3State extends State<DraggableScrollable3> {
  var index = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: Colors.grey.shade100,
            indicatorColor: Colors.blue.shade50,
            labelTextStyle: WidgetStateProperty.all(
                const TextStyle(color: Colors.black54, fontSize: 14)),
          ),
          child: NavigationBar(
            height: 65,
            selectedIndex: index,
            onDestinationSelected: (index) {
              setState(() {
                this.index = index;
              });
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.place_outlined),
                selectedIcon: Icon(Icons.place),
                label: 'Esplora',
              ),
              NavigationDestination(
                  icon: Icon(Icons.apartment_outlined),
                  selectedIcon: Icon(Icons.apartment),
                  label: 'Edifici'),
              NavigationDestination(
                icon: Icon(Icons.upload_outlined),
                selectedIcon: Icon(Icons.upload),
                label: 'Carica',
              ),
              NavigationDestination(
                  icon: Icon(Icons.person_outlined),
                  selectedIcon: Icon(Icons.person),
                  label: 'Profilo')
            ],
          )),
      // backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Image.asset(
            height: size.height,
            "assets/img/map_2.png",
            fit: BoxFit.cover,
          ),

          if (index == 1)
            const DraggableSheet(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Edifici",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 3),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Seleziona un edificio dalla lista",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TabBarEdifici(),
                  // BottomSheetDummyUI(),
                  // BottomSheetDummyUI(),
                  // BottomSheetDummyUI(),
                  // BottomSheetDummyUI(),
                  // BottomSheetDummyUI(),
                  // BottomSheetDummyUI(),
                  // BottomSheetDummyUI(),
                  // BottomSheetDummyUI(),
                  // BottomSheetDummyUI(),
                ],
              ),
            ),

          if (index == 3)
            AnimatedOpacity(
              opacity: index == 3 ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 100),
              child: Container(
                color: Colors.blueAccent,
              ),
            )

          // if (index == 3)
          //   Positioned(
          //     child: Container(
          //       color: Colors.blueAccent,
          //     ),
          //   )

          // const DraggableSheet(
          //   child: Column(
          //     children: [
          //       BottomSheetDummyUI(),
          //       BottomSheetDummyUI(),
          //       BottomSheetDummyUI(),
          //       BottomSheetDummyUI(),
          //       BottomSheetDummyUI(),
          //       BottomSheetDummyUI(),
          //       BottomSheetDummyUI(),
          //       BottomSheetDummyUI(),
          //       BottomSheetDummyUI(),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

class DraggableSheet extends StatefulWidget {
  final Widget child;

  const DraggableSheet({super.key, required this.child});

  @override
  State<DraggableSheet> createState() => _DraggableSheetState();
}

class _DraggableSheetState extends State<DraggableSheet> {
  final sheet = GlobalKey();
  final controller = DraggableScrollableController();

  @override
  void initState() {
    controller.addListener(onChanged);

    super.initState();
  }

  void onChanged() {
    final currentSize = controller.size;
    if (currentSize <= 0.05) collapse();
  }

  void collapse() => animateSheet(getSheet.snapSizes!.first);

  void anchor() => animateSheet(getSheet.snapSizes!.last);

  void expand() => animateSheet(getSheet.maxChildSize);

  void hide() => animateSheet(getSheet.minChildSize);

  void animateSheet(double size) {
    controller.animateTo(size,
        duration: const Duration(microseconds: 50), curve: Curves.easeInOut);
  }

  DraggableScrollableSheet get getSheet =>
      (sheet.currentWidget as DraggableScrollableSheet);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (builder, constraints) {
      return DraggableScrollableSheet(
          key: sheet,
          initialChildSize: 0.5,
          maxChildSize: 1,
          minChildSize: 0.1,
          expand: true,
          snap: true,
          snapSizes: [
            0.1,
            0.5,
            1,
          ],
          builder:
              (BuildContext buildContext, ScrollController scrollController) {
            return DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, 1),
                  )
                ],
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  topButtonIndicator(),
                  SliverToBoxAdapter(
                    child: widget.child,
                  )
                ],
              ),
            );
          });
    });
  }

  SliverToBoxAdapter topButtonIndicator() {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Wrap(
              children: [
                Container(
                  width: 50,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSheetDummyUI extends StatelessWidget {
  const BottomSheetDummyUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: Colors.black12,
                    height: 100,
                    width: 100,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        color: Colors.black12,
                        height: 20,
                        width: 190,
                      ),
                    ),
                    const SizedBox(height: 5),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        color: Colors.black12,
                        height: 20,
                        width: 140,
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10)
          ],
        ));
  }
}

class TabBarEdifici extends StatefulWidget {
  const TabBarEdifici({super.key});

  @override
  State<TabBarEdifici> createState() => _TabBarEdificiState();
}

class _TabBarEdificiState extends State<TabBarEdifici>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey.shade50,
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              color: Colors.grey.shade100,
              child: TabBar(
                dividerColor: Colors.transparent,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue.shade100),
                controller: tabController,
                tabs: const [
                  Tab(text: 'Riservate', height: 27),
                  Tab(text: 'Tutte', height: 27)
                ],
              ),
            ),
          ),
        ),

        const CustomTile(
          title: "Via Cristoforo Colombo, 16",
          subtitle: "Valeggio sul Mincio (VR)",
          distance: '2 mt',
          iconColor: Colors.green,
        ),
        const CustomTile(
          title: "Via Giuseppe Mazzini, 10",
          subtitle: "Valeggio sul Mincio (VR)",
          distance: '200 mt',
          iconColor: Colors.green,
        ),
        const CustomTile(
          title: "Via Lungaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          subtitle: "Valeggio sul Mincio (VR)",
          distance: '250 mt',
          iconColor: Colors.green,
        ),
        const CustomDivider(title: "distanti piu' di 5 km"),

        const CustomTileExpander(
          title: "Via Mazzini",
          subtitle: "Verona (VR)",
          distance: '29 km',
          children: [
            CustomTile(
              title: "Via Mazzini, 1",
              subtitle: "Verona (VR)",
              distance: '29 km',
              iconColor: Colors.blue,
            ),
            CustomTile(
              title: "Via Mazzini, 3",
              subtitle: "Verona (VR)",
              distance: '29 km',
              iconColor: Colors.blue,
            ),
            CustomTile(
              title: "Via Mazzini, 5",
              subtitle: "Verona (VR)",
              distance: '29 km',
              iconColor: Colors.blue,
            ),
            CustomTile(
              title: "Via Mazzini, 7",
              subtitle: "Verona (VR)",
              distance: '29 km',
              iconColor: Colors.blue,
            ),
          ],
        ),

        const CustomTileExpander(
          title: "Corso Cavour",
          subtitle: "Verona (VR)",
          distance: '35 km',
          children: [
            CustomTile(
              title: "Corso Cavour, 6",
              subtitle: "Verona (VR)",
              distance: '35 km',
              iconColor: Colors.blue,
            ),
            CustomTile(
              title: "Corso Cavour, 18",
              subtitle: "Verona (VR)",
              distance: '35 km',
              iconColor: Colors.blue,
            ),
          ],
        ),
        // const BottomSheetDummyUI(),
      ],
    );
  }
}

class CustomTile extends StatelessWidget {
  const CustomTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.distance,
      required this.iconColor});

  final String title;
  final String subtitle;
  final String distance;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: SizedBox(
        width: 35,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(Icons.route, color: iconColor),
            Icon(Icons.apartment, color: iconColor),
            const SizedBox(height: 4),
            Text(
              distance,
              style: const TextStyle(fontSize: 9),
            ),
          ],
        ),
      ),
      trailing: Wrap(
          spacing: 12, // space between two icons
          children: <Widget>[
            const Icon(Icons.location_on_outlined), // icon-1
            ClipOval(
              child: Material(
                color: Colors.grey, // Button color
                child: InkWell(
                  splashColor: Colors.red, // Splash color
                  onTap: _googleMapsNav,
                  child: const SizedBox(
                      width: 25,
                      height: 25,
                      child: Icon(
                        Icons.turn_right,
                        size: 12,
                        color: Colors.white,
                      )),
                ),
              ),
            )
            // Icon(Icons.turn_right), // icon-2
          ]),
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitle,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
      ),
    );
  }

  _googleMapsNav() async {
    String query = "45.43720521692013, 10.98617932578361";
    Uri uri =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');

    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}

class CustomTileExpander extends StatelessWidget {
  const CustomTileExpander(
      {super.key,
      this.title,
      this.subtitle,
      required this.children,
      this.distance});

  final title;
  final subtitle;
  final distance;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        shape: const Border(),
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        ),
        leading: SizedBox(
          width: 35,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon(Icons.route, color: iconColor),
              const Icon(Icons.group_work_rounded, color: Colors.blue),
              const SizedBox(height: 4),
              Text(
                distance,
                style: const TextStyle(fontSize: 9),
              ),
            ],
          ),
        ),
        children: [
          Container(
            color: Colors.grey.shade50,
            child: Column(
              children: children,
            ),
          )
        ]);
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      color: Colors.grey.shade50,
      child: Row(children: <Widget>[
        const Expanded(child: Divider()),
        const SizedBox(width: 7),
        Text(
          title,
          style: const TextStyle(color: Colors.grey, fontSize: 13),
        ),
        const SizedBox(width: 7),
        const Expanded(child: Divider()),
      ]),
    );
  }
}

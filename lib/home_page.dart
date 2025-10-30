import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  late Box _countrysBox;

  @override
  void initState() {
    super.initState();
    _countrysBox = Hive.box("country-list");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Enter country",
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    final userData = _controller.text.trim();
                    if (userData.isNotEmpty) {
                      _countrysBox.add(userData);
                      _controller.clear();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  icon: Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _countrysBox.listenable(),
                builder: (context, box, widget) {
                  if (box.isEmpty) {
                    return const Center(child: Text("No countries added yet"));
                  }

                  final items = box.values.toList().reversed.toList();

                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final actualIndex = box.length - 1 - index;

                      return Card(
                        child: ListTile(
                          title: Text('${index + 1}. $item'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.edit_outlined),
                              ),
                              IconButton(
                                onPressed: () => box.deleteAt(actualIndex),
                                icon: const Icon(Icons.remove_outlined),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _updateController = TextEditingController();
  late final Box _countriesBox;

  @override
  void initState() {
    super.initState();
    _countriesBox = Hive.box("country-list");
  }

  void _addCountry() {
    final userData = _controller.text.trim();
    if (userData.isEmpty) return;

    _countriesBox.add(userData);
    _controller.clear();
  }

  void _updateCountry(int index, int actualIndex) {
    final newName = _updateController.text.trim();
    if (newName.isEmpty) return;

    _countriesBox.putAt(actualIndex, newName);
    _updateController.clear();
    Navigator.pop(context);
  }

  void _showUpdateDialog(int index, int actualIndex, String currentValue) {
    _updateController.text = currentValue;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update Country"),
        content: TextField(
          controller: _updateController,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: "Enter new name",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton.icon(
            onPressed: () => _updateCountry(index, actualIndex),
            icon: const Icon(Icons.update, size: 18),
            label: const Text("Update"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hive Country List")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Input + Add button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: "Enter country name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSubmitted: (_) => _addCountry(),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: _addCountry,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      Colors.blue,
                    ),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // Country list
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _countriesBox.listenable(),
                builder: (context, Box box, _) {
                  if (box.isEmpty) {
                    return const Center(
                      child: Text(
                        "No countries added yet.",
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }

                  final items = box.values.toList().reversed.toList();

                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final country = items[index];
                      final actualIndex = box.length - 1 - index;

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text('${index + 1}. $country'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_outlined),
                                onPressed: () => _showUpdateDialog(
                                  index,
                                  actualIndex,
                                  country,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () => box.deleteAt(actualIndex),
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

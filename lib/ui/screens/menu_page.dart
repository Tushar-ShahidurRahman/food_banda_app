import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuPage extends StatefulWidget {
  final String role;

  MenuPage({required this.role});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<String> menuItems = [
    'Item 1',
    'Item 2',
    'Item 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (widget.role == 'buyer')
                  ElevatedButton(
                    onPressed: () {
                      // Add new item
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Add New Item'),
                          content: TextField(
                            decoration: InputDecoration(
                              hintText: 'Item Name',
                            ),
                            onChanged: (value) {
                              // Update item name
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // Save item
                                Navigator.pop(context);
                              },
                              child: Text('Add'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text('Add Item'),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(menuItems[index]),
                  onTap: () {
                    // Item tap action
                    if (widget.role == 'buyer') {
                      // Action for buyer
                    } else if (widget.role == 'seller') {
                      // Action for seller
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

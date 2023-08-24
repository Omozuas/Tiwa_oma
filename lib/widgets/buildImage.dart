import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

class Mine extends StatelessWidget {
  const Mine({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyTabbedScreen(),
    );
  }
}

class MyTabbedScreen extends StatefulWidget {
  const MyTabbedScreen({super.key});

  @override
  _MyTabbedScreenState createState() => _MyTabbedScreenState();
}

class _MyTabbedScreenState extends State<MyTabbedScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const TabScreenA(),
    const TabScreenB(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tabbed Navigation')),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Tab A',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Tab B',
          ),
        ],
      ),
    );
  }
}

class TabScreenA extends StatefulWidget {
  const TabScreenA({super.key});

  @override
  _TabScreenAState createState() => _TabScreenAState();
}

class _TabScreenAState extends State<TabScreenA> {
  bool _showButtons = true;

  void _removeButtons() {
    setState(() {
      _showButtons = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_showButtons)
            Column(
              children: [
                ElevatedButton(
                  onPressed: _removeButtons,
                  child: const Text('Remove Buttons'),
                ),
                ElevatedButton(
                  onPressed: _removeButtons,
                  child: const Text('Remove Buttons'),
                ),
              ],
            )
          else
            const Text('Buttons Removed'),
        ],
      ),
    );
  }
}

class TabScreenB extends StatelessWidget {
  const TabScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Tab B Content'),
    );
  }
}

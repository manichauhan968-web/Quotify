import 'package:flutter/material.dart';

// 🔹 App starts from here
void main() {
  runApp(const QuotifyApp());
}

// 🔹 Root App Widget
class QuotifyApp extends StatelessWidget {
  const QuotifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // removes debug banner
      title: 'Quotify',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, // app theme color
      ),
      home: const MainShell(), // main screen
    );
  }
}

// ================= MAIN SHELL =================

// 🔹 This controls bottom navigation + screens
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {

  int _currentIndex = 0; // stores selected tab index

  // 🔹 List of screens for bottom navigation
  final List<Widget> _screens = const [
    HomeScreen(),
    ExploreScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // 🔹 APPBAR
      appBar: AppBar(
        title: const Text("Quotify"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,

        // 🔹 Action icons on right side
        actions: [
          IconButton(
              onPressed: () {}, 
              icon: const Icon(Icons.favorite_border)), // like button
          IconButton(
              onPressed: () {}, 
              icon: const Icon(Icons.share)), // share button
        ],
      ),

      // 🔹 DRAWER (side menu)
      drawer: Drawer(
        child: ListView(
          children: [
            // 🔹 User info at top
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              accountName: Text("User Name"),
              accountEmail: Text("user@email.com"),
            ),

            // 🔹 Home option
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () => Navigator.pop(context),
            ),

            // 🔹 Settings option
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),

      // 🔹 BODY (changes based on selected tab)
      body: _screens[_currentIndex],

      // 🔹 Floating Button (center button)
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.format_quote),
      ),

      // 🔹 Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // selected tab
        onTap: (i) => setState(() => _currentIndex = i), // change tab
        selectedItemColor: Colors.deepPurple,

        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: "Home"),

          BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              label: "Explore"),

          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: "Profile"),
        ],
      ),
    );
  }
}

// ================= HOME SCREEN =================

// 🔹 Home screen shows quotes
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // 🔹 List of quotes
  List<Map<String, String>> quotes = [
    {"text": "Do the best you can until you know better. Then when you know better, do better", "author": "Maya Angelou"},
    {"text": "An investment in knowledge pays the best interest", "author": "Benjamin Franklin"},
    {"text": "It is never too late to be who you might have been.", "author": "George Eliot"},
    {"text": "The only way to do great work is to love what you do.", "author": "Steve Jobs"},
    {"text": "The future belongs to those who believe in the beauty of their dreams.", "author": "Eleanor Roosevelt"},
    {"text": "The best way to predict the future is to create it.", "author": "Peter Drucker"},
    {"text": "Success isn't about the end result, it's about what you learn along the way.", "author": "Vera Wang"},
    {"text": "The greatest glory in living lies not in never falling, but in rising every time we fall.", "author": "Nelson Mandela"}
  ];

  int index = 0; // current quote index

  // 🔹 Function to change quote
  void newQuote() {
    setState(() {
      index = (index + 1) % quotes.length; // loop through quotes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              // 🔹 Quote text
              Text(
                quotes[index]["text"]!,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              // 🔹 Author name
              Text("- ${quotes[index]["author"]}"),

              const SizedBox(height: 20),

              // 🔹 Button to change quote
              ElevatedButton(
                onPressed: newQuote,
                child: const Text("New Quote"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ================= EXPLORE =================

// 🔹 Explore screen with categories
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return GridView.count(
      crossAxisCount: 2, // 2 columns

      children: List.generate(
        6,
        (index) => Card(
          margin: const EdgeInsets.all(10),

          child: Center(
            child: Text("Category ${index + 1}"),
          ),
        ),
      ),
    );
  }
}

// ================= PROFILE =================

// 🔹 Profile screen UI
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        // 🔹 Top banner
        Container(
          height: 150,
          color: Colors.deepPurple,
        ),

        const SizedBox(height: 10),

        // 🔹 Profile avatar
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.deepPurple.shade100,

          child: CircleAvatar(
            radius: 45,
            backgroundColor: Colors.white,

            child: Icon(
              Icons.person,
              size: 50,
              color: Colors.deepPurple,
            ),
          ),
        ),

        const SizedBox(height: 10),

        // 🔹 Username
        const Text(
          "User Name",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

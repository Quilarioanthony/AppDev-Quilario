import 'package:flutter/material.dart';
import 'EditProfile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 1;
  bool _showFab = true;

  void _onItemTapped(int index) {
    if (index == 0) {
      setState(() {
        _showFab = true; // Show FAB on Home page
        _selectedIndex = index;
      });

      Future.delayed(const Duration(milliseconds: 10), () {
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
    } else {
      setState(() {
        _showFab = false; // Hide FAB on other pages
        _selectedIndex = index;
      });
    }
  }

  Widget _buildPost({
    required String username,
    required String handle,
    required String text,
    required String imageUrl,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.network(
              'https://i.imgur.com/Qxfk4Jl.png',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$username @$handle",
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(text, style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Removed 3 dots icon as requested
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: 120, color: Colors.grey[900]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    transform: Matrix4.translationValues(0, -40, 0),
                    child: ClipOval(
                      child: Image.network(
                        'https://i.imgur.com/Qxfk4Jl.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    transform: Matrix4.translationValues(0, -20, 0),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfile(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Edit Profile'),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Alfender",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("@alfender.bluesky.social",
                      style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 4),
                  Text("Digital and Traditional artist",
                      style: TextStyle(color: Colors.white)),
                  SizedBox(height: 16),
                  Divider(color: Colors.grey),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Posts",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            _buildPost(
              username: "Alfender",
              handle: "alfender.bluesky.social",
              text: "Neon dive",
              imageUrl:
              'https://i.imgur.com/Mgsapad.jpeg',
            ),
            _buildPost(
              username: "Alfender",
              handle: "alfender.bluesky.social",
              text: "Miriam",
              imageUrl:
              'https://i.imgur.com/Nq3OGDe.jpeg',
            ),
            _buildPost(
              username: "Alfender",
              handle: "alfender.bluesky.social",
              text: "Sketching day",
              imageUrl:
              'https://i.imgur.com/mkPm7sK.jpeg',
            ),
            _buildPost(
              username: "Alfender",
              handle: "alfender.bluesky.social",
              text: "City lights at night",
              imageUrl:
              'https://images.unsplash.com/photo-1468071174046-657d9d351a40?auto=format&fit=crop&w=800&q=80',
            ),
          ],
        ),
      ),
      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: (_selectedIndex == 0 && _showFab)
            ? FloatingActionButton(
          key: const ValueKey('homeFab'),
          onPressed: () {
            // Define the action, e.g., create post
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.edit, color: Colors.white),
        )
            : SizedBox(
          key: const ValueKey('emptyFab'),
          width: 56,
          height: 56,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

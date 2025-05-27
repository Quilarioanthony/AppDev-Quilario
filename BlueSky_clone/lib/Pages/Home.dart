import 'package:flutter/material.dart';
import 'Profile.dart';
import 'CreatePost.dart'; // Make sure this path is correct

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> posts = [
    {
      "username": "Alfender",
      "handle": "@alfender.bluesky.social",
      "caption": "Neon dive",
      "image": "https://i.imgur.com/Mgsapad.jpeg",
    },
    {
      "username": "Alfender",
      "handle": "@alfender.bluesky.social",
      "caption": "Miriam",
      "image": "https://i.imgur.com/Nq3OGDe.jpeg",
    },
    {
      "username": "Virtue",
      "handle": "@Virtue",
      "caption": "Into the Abyss 🌌",
      "image": "https://i.imgur.com/HKnungO.jpeg",
    },
    {
      "username": "Shadow",
      "handle": "@Shadow.art",
      "caption": "Death",
      "image": "https://i.imgur.com/1CXEVjQ.jpeg",
    },
    {
      "username": "EchoVibe",
      "handle": "@echovibe.music",
      "caption": "Lost in the beat 🎧",
      "image": "https://i.imgur.com/1EBZ6tj.jpeg",
    },
    {
      "username": "Virtue",
      "handle": "@Virtue",
      "caption": "Void",
      "image": "https://i.imgur.com/vBsp0VR.jpeg",
    },
  ];

  late List<bool> liked;
  int _selectedIndex = 0;
  bool _showFab = true;

  @override
  void initState() {
    super.initState();
    liked = List<bool>.filled(posts.length, false);
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _showFab = false;
      });

      Future.delayed(const Duration(milliseconds: 300), () {
        if (index == 1) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const ProfilePage()))
              .then((_) {
            setState(() {
              _selectedIndex = 0;
              _showFab = true;
            });
          });
        } else {
          setState(() {
            _selectedIndex = index;
            _showFab = true;
          });
        }
      });
    }
  }

  String? getProfileImageUrl(String username) {
    switch (username) {
      case "Virtue":
        return "https://i.imgur.com/39X9Z8o.jpeg";
      case "Shadow":
        return "https://i.imgur.com/HKnungO.jpeg";
      case "EchoVibe":
        return "https://i.imgur.com/HKnungO.jpeg";
      case "Alfender":
        return "https://i.imgur.com/Qxfk4Jl.png";
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Column(
          children: [
            Image.network(
              'https://ppc.land/content/images/size/w2000/2024/02/Bluesky-logo.webp',
              height: 30,
            ),
            const Text(
              "Discover",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          final imageUrl = getProfileImageUrl(post['username']!);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: imageUrl != null
                    ? ClipOval(
                  child: Image.network(
                    imageUrl,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                )
                    : const CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text(post['username']!,
                    style: const TextStyle(color: Colors.white)),
                subtitle: Text(post['handle']!,
                    style: const TextStyle(color: Colors.grey)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(post['caption']!,
                    style: const TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 8),
              Image.network(
                post['image']!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, color: Colors.red),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.chat_bubble_outline,
                            color: Colors.grey, size: 20),
                        SizedBox(width: 4),
                        Text('25k', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const Row(
                      children: [
                        Icon(Icons.repeat, color: Colors.grey, size: 20),
                        SizedBox(width: 4),
                        Text('1.2k', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          liked[index] = !liked[index];
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            liked[index]
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: liked[index] ? Colors.red : Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          const Text('402k',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey.shade800),
            ],
          );
        },
      ),
      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(scale: animation, child: child),
          );
        },
        child: (_selectedIndex == 0 && _showFab)
            ? FloatingActionButton(
          key: const ValueKey('homeFab'),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CreatePostPage()),
            );
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.edit, color: Colors.white),
        )
            : const SizedBox(
          key: ValueKey('emptyFab'),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _postController = TextEditingController();

  void _submitPost() {
    final text = _postController.text.trim();
    if (text.isNotEmpty) {
      // TODO: Handle post submission (e.g., save to Firebase or state)
      print("Post submitted: $text");
      Navigator.pop(context); // Close the page after posting
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Post cannot be empty"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leadingWidth: 80,
        leading: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        title: const Text(
          "What's up?",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: _submitPost,
            child: const Text(
              'Post',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Avatar + user info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: Image.network(
                    'https://i.imgur.com/Qxfk4Jl.png',
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Alfender',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.public, color: Colors.grey[500], size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Public',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// Post input
            Expanded(
              child: TextField(
                controller: _postController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "What's on your mind?",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ),

            const Divider(color: Colors.grey),

            /// Action buttons
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      // TODO: Add media functionality
                    },
                    icon: const Icon(Icons.photo_library, color: Colors.green),
                    label: const Text('Media', style: TextStyle(color: Colors.white)),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // TODO: Add tagging functionality
                    },
                    icon: const Icon(Icons.tag, color: Colors.blue),
                    label: const Text('Tag', style: TextStyle(color: Colors.white)),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // TODO: Add more actions
                    },
                    icon: const Icon(Icons.more_horiz, color: Colors.grey),
                    label: const Text('More', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

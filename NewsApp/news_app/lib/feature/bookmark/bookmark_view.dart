import 'package:flutter/material.dart';

class BookmarkView extends StatefulWidget {
  const BookmarkView({super.key});

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> {
  final List<Map<String, String>> bookmarks = [
    {
      'image': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
      'title': 'How to Setup Your Workspace',
      'category': 'Interior',
    },
    {
      'image': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
      'title': 'Discovering Hidden Gems: 8 Off-The-Beaten-Path...',
      'category': 'Travel',
    },
    {
      'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
      'title': 'Exploring the World’s Best Beaches: Top 5 Picks',
      'category': 'Travel',
    },
    {
      'image': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
      'title': 'Travel Destinations That Won’t Break the Bank',
      'category': 'Travel',
    },
    {
      'image': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
      'title': 'How Working Remotely Will Make You More Happy',
      'category': 'Business',
    },
    {
      'image': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
      'title': 'Destinations for Authentic Local Experiences',
      'category': 'Travel',
    },
    {
      'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
      'title': 'A Guide to Seasonal Gardening',
      'category': 'Travel',
    },
  ];

  int? _deleteIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Bookmark',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: EdgeInsets.only(bottom: 70),
            itemCount: bookmarks.length,
            itemBuilder: (context, index) {
              final item = bookmarks[index];
              return Dismissible(
                key: Key(item['title']!),
                direction: DismissDirection.startToEnd,
                background: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  final removedItem = bookmarks[index];
                  final removedIndex = index;

                  setState(() {
                    bookmarks.removeAt(index); // Remove temporarily
                    _deleteIndex = removedIndex; // Show custom dialog
                  });

                  // Restore if user clicks No
                  Future.delayed(Duration.zero, () async {
                    while (_deleteIndex == removedIndex) {
                      await Future.delayed(Duration(milliseconds: 50));
                    }
                    if (!bookmarks.contains(removedItem)) {
                      setState(() {
                        bookmarks.insert(removedIndex, removedItem);
                      });
                    }
                  });
                },
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Text(
                    item['title'] ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  subtitle: Text(
                    item['category'] ?? '',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  trailing: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item['image'] ?? '',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
          if (_deleteIndex != null) _buildDeleteDialog(context, _deleteIndex!),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), label: 'Bookmark'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildDeleteDialog(BuildContext context, int index) {
    final item = bookmarks[index];
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 10),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sure you want to delete this item?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 12),
              Text(
                item['title'] ?? '',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                item['category'] ?? '',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item['image'] ?? '',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      setState(() {
                        bookmarks.removeAt(index);
                        _deleteIndex = null;
                      });
                    },
                    child: Text('Yes, Delete'),
                  ),
                  SizedBox(width: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      setState(() {
                        _deleteIndex = null; // Cancel
                      });
                    },
                    child: Text('No', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

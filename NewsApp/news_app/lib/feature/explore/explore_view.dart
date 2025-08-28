import 'package:flutter/material.dart';

class ExploreView extends StatelessWidget {
  final List<String> categories = ['Travel', 'Technology', 'Business'];
  final List<Map<String, String>> articles = [
    {
      'image': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
      'title': 'Uncovering the Hidden Gems of the Amazon Forest',
      'author': 'Mary',
      'date': 'Sep 12, 2023',
    },
    {
      'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
      'title': 'Experience the Serenity of Japan’s Tradition',
      'author': 'Luc Chiba',
      'date': 'Sep 10, 2023',
    },
    {
      'image': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
      'title': 'A Journey Through Time: Discovering the New Year',
      'author': 'John Doe',
      'date': 'Sep 8, 2023',
    },
    {
      'image': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
      'title': 'Chasing the Northern Lights: A Winter in Finland',
      'author': 'Jane Smith',
      'date': 'Sep 6, 2023',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Explore', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return Chip(
                    label: Text(categories[index]),
                    backgroundColor: Colors.grey[200],
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            _featuredArticleCard(),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return _articleListItem(article);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Bookmark'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _featuredArticleCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Uncovering the Hidden Gems of the Amazon Forest',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _articleListItem(Map<String, String> article) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          article['image'] ?? '',
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(article['title'] ?? '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      subtitle: Text('${article['author']} • ${article['date']}', style: TextStyle(color: Colors.grey, fontSize: 12)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    );
  }
}

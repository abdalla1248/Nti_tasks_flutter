import 'package:flutter/material.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            // Top image
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.network(
                "https://images.unsplash.com/photo-1465101046530-73398c7f28ca",
                fit: BoxFit.cover,
              ),
            ),
        
            // Back button
            Positioned(
              top: 40,
              left: 16,
              child: _circleButton(
                icon: Icons.arrow_back,
                onPressed: () => Navigator.pop(context),
              ),
            ),
        
            // Bookmark + Share buttons
            Positioned(
              top: 40,
              right: 16,
              child: Row(
                children: [
                  _circleButton(icon: Icons.bookmark_border, onPressed: () {}),
                  SizedBox(width: 8),
                  _circleButton(icon: Icons.share, onPressed: () {}),
                ],
              ),
            ),
        
            // Scrollable white article container
            Positioned.fill(
              top: 200,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight, // 👈 force full height
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                'See How the Forest is Helping Our World',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  height: 1.3,
                                ),
                              ),
                              SizedBox(height: 12),
        
                              // Author & Date
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundImage: NetworkImage(
                                      'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d',
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Harry Harper',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Icon(Icons.calendar_today,
                                      size: 14, color: Colors.grey[600]),
                                  SizedBox(width: 4),
                                  Text(
                                    'Apr 12, 2023',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
        
                              // Article text
                              Text(
                                'Forests are one of the most important natural resources that our planet possesses. '
                                'Not only do they provide us with a diverse range of products such as timber, medicine, and food, '
                                'but they also play a vital role in mitigating climate change and maintaining the overall health of '
                                'our planet\'s ecosystems.\n\n'
                                'One of the most important roles that forests play is in absorbing carbon dioxide from the atmosphere. '
                                'The trees absorb carbon dioxide through photosynthesis and store it in their trunks, branches, and leaves '
                                'while releasing oxygen back into the atmosphere. This process is crucial for maintaining the balance of gases '
                                'in our atmosphere and combating climate change.\n\n'
                                'Additionally, forests provide habitat for a vast array of wildlife, helping to preserve biodiversity and protect '
                                'endangered species. They also play a key role in regulating the water cycle, preventing soil erosion, and maintaining '
                                'the health of our planet\'s ecosystems.\n\n'
                                'In conclusion, forests are an invaluable resource that must be protected and preserved for future generations. '
                                'By understanding the many ways in which they benefit our world, we can work towards a more sustainable and environmentally-friendly future.',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                  height: 1.6,
                                ),
                              ),
                              SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleButton({required IconData icon, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black87),
        onPressed: onPressed,
      ),
    );
  }
}

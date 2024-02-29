import 'package:flutter/material.dart';
import 'package:pollution_project/ui/widgets/MyNavigationBar.dart';

class ResourceListPage extends StatefulWidget {
  ResourceListPage({Key? key}) : super(key: key);

  @override
  _ResourceListPageState createState() => _ResourceListPageState();
}

class _ResourceListPageState extends State<ResourceListPage> {
  @override
  Widget build(BuildContext context) {
    return Resources();
  }
}

class Resources extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resources'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.softLight),
          ),
        ),
        child: ListView(
          children: [
            _buildNewsItem(
              topic: 'Topic 1',
              imageUrl: 'assets/news1.jpg', // Placeholder image path
            ),
            _buildNewsItem(
              topic: 'Topic 2',
              imageUrl: 'assets/news2.jpg', // Placeholder image path
            ),
            _buildNewsItem(
              topic: 'Topic 3',
              imageUrl: 'assets/news3.jpg', // Placeholder image path
            ),
            _buildNewsItem(
              topic: 'Topic 4',
              imageUrl: 'assets/news4.jpg', // Placeholder image path
            ),
            _buildNewsItem(
              topic: 'Topic 5',
              imageUrl: 'assets/news5.jpg', // Placeholder image path
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyNavigationBar(),
    );
  }

  Widget _buildNewsItem({required String topic, required String imageUrl}) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              topic,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

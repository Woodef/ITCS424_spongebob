import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollution_project/ui/widgets/MyNavigationBar.dart';

class ResourcePage extends StatefulWidget {
  String articleName;
  String author;
  String updatedDate;
  String content;
  String image;
  ResourcePage(
      {Key? key,
      required this.articleName,
      required this.author,
      required this.updatedDate,
      required this.content,
      required this.image})
      : super(key: key);

  @override
  _ResourcePageState createState() => _ResourcePageState();
}

class _ResourcePageState extends State<ResourcePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'Air Pollution',
              style: GoogleFonts.birthstone(
                textStyle: const TextStyle(fontSize: 25, color: Colors.black),
              ),
            ),
            Text(
              'Resource',
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
      body: Resource(
          resourceName: widget.articleName,
          authorName: widget.author,
          updatedDate: widget.updatedDate,
          content: widget.content,
          image: widget.image),
      bottomNavigationBar: const MyNavigationBar(index: 2),
    );
  }
}

class Resource extends StatelessWidget {
  String resourceName = "Resource Name";
  String updatedDate = "Updated Apr 8, 2024 | 10:00 AM";
  String authorName = "John Doe";
  String content = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
      "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
      "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. "
      "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. "
      "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
  String image = '';

  Resource({
    Key? key,
    required this.resourceName,
    required this.updatedDate,
    required this.authorName,
    required this.content,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resourceName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      updatedDate,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      'Authored By: $authorName',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

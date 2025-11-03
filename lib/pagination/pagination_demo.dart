import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Post {
  final int id;
  final String title;

  Post({required this.id, required this.title});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(id: json['id'], title: json['title']);
  }
}

class ApiPaginationDemo extends StatefulWidget {
  const ApiPaginationDemo({super.key});

  @override
  State<ApiPaginationDemo> createState() => _ApiPaginationDemoState();
}

class _ApiPaginationDemoState extends State<ApiPaginationDemo> {
  List<Post> posts = [];
  int currentPage = 1;
  int limit = 10;
  int totalCount = 0;
  bool isLoading = false;
  bool hasMore = true;

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchPosts();
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels >=
        _controller.position.maxScrollExtent - 100) {
      if (hasMore && !isLoading) {
        fetchPosts();
      }
    }
  }

  Future<void> fetchPosts() async {
    if (isLoading) return;

    setState(() => isLoading = true);

    final response = await http.get(
      Uri.parse(
        "https://jsonplaceholder.typicode.com/posts?_page=$currentPage&_limit=$limit",
      ),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      // Fake total count (JSONPlaceholder always has 100 posts max)
      totalCount = int.parse(response.headers["x-total-count"] ?? "100");

      final newPosts = data.map((json) => Post.fromJson(json)).toList();

      setState(() {
        posts.addAll(newPosts.cast<Post>());
        currentPage++;
        hasMore = posts.length < totalCount;
      });
    }

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = (totalCount / limit).ceil();

    return Scaffold(
      appBar: AppBar(title: const Text("API Pagination Demo")),
      body: Column(
        children: [
          // Header with count & pages
          Container(
            color: Colors.grey.shade200,
            padding: const EdgeInsets.all(12),
            child: Text(
              "Total: $totalCount items | Page $currentPage of $totalPages",
              style: const TextStyle(fontSize: 16),
            ),
          ),

          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: posts.length + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < posts.length) {
                  final post = posts[index];
                  return ListTile(
                    leading: CircleAvatar(child: Text(post.id.toString())),
                    title: Text(post.title),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

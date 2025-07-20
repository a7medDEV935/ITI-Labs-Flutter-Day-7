import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../core/constants/app_colors.dart';
import '../../../core/db/shared_preference_db.dart';
import '../data/models/post_model.dart';
import 'widgets/custom_search_delegate.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  List<PostModel> posts = [];
  bool isLoading = true;
  Set<int> favoritePostIds = {};

  List<PostModel> favouritePosts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      final fetched = (json.decode(response.body) as List)
          .map((e) => PostModel.fromJson(e))
          .toList();

      final favIds = <int>{};
      final favPosts = <PostModel>[];

      for (final post in fetched) {
        final isFav =
            await SharedPreferenceDB.getBool('favorite_post_${post.id}');
        if (isFav) {
          favIds.add(post.id);
          favPosts.add(post);
        }
      }

      setState(() {
        posts = fetched;
        favoritePostIds = favIds;
        favouritePosts = favPosts;
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load posts')),
        );
      }
    }
  }

  void toggleFavorite(int postId) async {
    final key = 'favorite_post_$postId';
    final isCurrentlyFav = await SharedPreferenceDB.getBool(key);
    final post = posts.firstWhere((p) => p.id == postId);

    setState(() {
      if (isCurrentlyFav) {
        favoritePostIds.remove(postId);
        favouritePosts.removeWhere((p) => p.id == postId);
        SharedPreferenceDB.saveFavoritePosts(favouritePosts);
        SharedPreferenceDB.setData("favourite_posts_count", favouritePosts.length);
        SharedPreferenceDB.setData(key, false);
      } else {
        favoritePostIds.add(postId);
        favouritePosts.add(post);
        SharedPreferenceDB.saveFavoritePosts(favouritePosts);
        SharedPreferenceDB.setData("favourite_posts_count", favouritePosts.length);
        SharedPreferenceDB.setData(key, true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.kPrimary,
        title:
            const Text('Posts', style: TextStyle(color: AppColors.kOnPrimary)),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: AppColors.kOnPrimary),
            onPressed: () async {
              await showSearch<PostModel?>(
                context: context,
                delegate: CustomSearchDelegate(searchList: posts),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.red),
            )
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                final isFav = favoritePostIds.contains(post.id);
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 4,
                  child: ListTile(
                    title: Text(
                      post.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(post.body),
                    trailing: IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : Colors.grey,
                      ),
                      onPressed: () => toggleFavorite(post.id),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/db/shared_preference_db.dart';
import '../data/models/post_model.dart';

class FavouritePosts extends StatefulWidget {
  const FavouritePosts({super.key});
  @override
  State<FavouritePosts> createState() => _FavouritePostsState();
}

class _FavouritePostsState extends State<FavouritePosts> {

  List<PostModel> favouritePosts = [];

  @override
  void initState() {
    super.initState();
    loadFavourites();
  }

  Future<void> loadFavourites() async {
    favouritePosts = await SharedPreferenceDB.loadFavoritePosts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.kPrimary,
        iconTheme: IconThemeData(color: AppColors.kOnPrimary),
        title: const Text('Favourite Posts', style: TextStyle(color: AppColors.kOnPrimary)),
      ),
      body: ListView.builder(
        itemCount: favouritePosts.length,
        itemBuilder: (BuildContext context, int index) {
          final post = favouritePosts[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            child: ListTile(
              title: Text(post.title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(post.body),
            ),
          );
        },
      ),
    );
  }
}

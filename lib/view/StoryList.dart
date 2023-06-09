import 'package:codeway_case/view/StoryAvatar.dart';
import 'package:flutter/cupertino.dart';

class StoryList extends StatelessWidget {

  final List<String> stories = [
    "https://media.licdn.com/dms/image/D4D35AQHMrhP1UvdAYA/profile-framedphoto-shrink_200_200/0/1685189997533?e=1686855600&v=beta&t=uEfumVvqD-Y39RwiESkY6XvQo2yB2S2lIYcM0nnmxJs",
    "https://pbs.twimg.com/profile_images/1419944321135042560/Gc1o742l_400x400.jpg",
    "https://pbs.twimg.com/profile_images/1513049258622078976/s2E2CQys_400x400.jpg",
    "https://pbs.twimg.com/profile_images/1411737423961337856/5azd5lwo_400x400.jpg",
    "https://media.licdn.com/dms/image/D4D35AQHMrhP1UvdAYA/profile-framedphoto-shrink_200_200/0/1685189997533?e=1686855600&v=beta&t=uEfumVvqD-Y39RwiESkY6XvQo2yB2S2lIYcM0nnmxJs",
    "https://pbs.twimg.com/profile_images/1419944321135042560/Gc1o742l_400x400.jpg",
    "https://pbs.twimg.com/profile_images/1513049258622078976/s2E2CQys_400x400.jpg",
    "https://pbs.twimg.com/profile_images/1411737423961337856/5azd5lwo_400x400.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: stories.length,
      itemBuilder: (context, index) {
        return StoryAvatar(imageUrl: stories[index]);
      },
    );
  }
}
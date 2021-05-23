import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fritter/client.dart';
import 'package:fritter/database/entities.dart';
import 'package:fritter/home_model.dart';
import 'package:fritter/tweet.dart';
import 'package:fritter/ui/futures.dart';
import 'package:provider/provider.dart';

class SavedContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var model = context.read<HomeModel>();

    return Container(
      child: FutureBuilderWrapper<List<SavedTweet>>(
        future: model.listSavedTweets(),
        onEmpty: () => Text('No saved tweets could be found, which should never happen. Please report a bug, if possible!'),
        onError: (error, stackTrace) => Text('Unable to find your saved tweets. The error was $error'),
        onReady: (data) {
          if (data.isEmpty) {
            return Center(child: Text("You haven't saved any tweets yet!"));
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var item = data[index];
              var tweet = TweetWithCard.fromJson(jsonDecode(item.content));

              return TweetTile(tweet: tweet, clickable: true);
            },
          );
        },
      )
    );
  }
}

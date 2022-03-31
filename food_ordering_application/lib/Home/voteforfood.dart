import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:polls/polls.dart';

import '../constant.dart';
import '../widgets/viewvotes.dart';
import '../widgets/voteitem.dart';

class VoteFood extends StatefulWidget {
  @override
  _VoteFoodState createState() => _VoteFoodState();
}

class _VoteFoodState extends State<VoteFood> {
  @override
  void initState() {
    super.initState();
    getVotingDetails();
  }

  double option1 = 1.0;
  double option2 = 0.0;
  double option3 = 1.0;
  int item = 0;
  int votelenth = 0;
  List<VoteItem> VItems = [];

  String user = "king@mail.com";
  Map usersWhoVoted = {
    'sam@mail.com': 3,
    'mike@mail.com': 4,
    'john@mail.com': 1,
    'kenny@mail.com': 1
  };
  String creator = "eddy@mail.com";

  void getVotingDetails() async {
    FirebaseFirestore.instance
        .collection('votes')
        .get()
        .then((QuerySnapshot querySnapshot) {
      votelenth = querySnapshot.size;
      for (int i = 0; i < querySnapshot.size; i++) {}
      querySnapshot.docs.forEach((doc) {
        int i = 0;
        VItems = [
          VoteItem(name: doc["name"], value: double.parse(doc["value"])),
        ];
        ViewVotes.add(VItems[i]);
        print(ViewVotes.getVoteItems[i].name);
        i++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Vote'),
        backgroundColor: Sushi,
      ),
      body: SafeArea(
        child: Container(
          child: Polls(
            children: [
              // This cannot be less than 2, else will throw an exception
              for (int i = 0; i < ViewVotes.VoteItems.length; i++)
                Polls.options(
                    title: ViewVotes.getVoteItems[i].name,
                    value: ViewVotes.getVoteItems[i].value),
            ],
            question: Text(
              'What would you like to eat tommorrow?',
              style: normalText,
            ),
            currentUser: this.user,
            creatorID: this.creator,
            voteData: usersWhoVoted,
            userChoice: usersWhoVoted[this.user],
            onVoteBackgroundColor: Sushi,
            leadingBackgroundColor: Sushi,
            backgroundColor: Sushi,
            onVote: (choice) {
              print(choice);
              setState(() {
                this.usersWhoVoted[this.user] = choice;
              });
              if (choice == 1) {
                setState(() {
                  option1 += 1.0;
                });
              }
              if (choice == 2) {
                setState(() {
                  option2 += 1.0;
                });
              }
              if (choice == 3) {
                setState(() {
                  option3 += 1.0;
                });
              }
            },
          ),
        ),
      ),
    );
  }
}

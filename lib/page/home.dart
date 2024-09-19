import 'package:api_hand_made_no_frommap/model/user_model.dart';
import 'package:api_hand_made_no_frommap/service/user_service.dart';
import 'package:flutter/material.dart';

class UsersName extends StatelessWidget {
  const UsersName({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Users Details',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<UserModel>>(
        future: UserServices().fetchUserData(5),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow,
                ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title:
                  Text("${user.title} ${user.firstName} ${user.lastName}"),
                );
              },
            );
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}

import 'package:avestan_test/Constants/constants.dart';
import 'package:flutter/material.dart';

Widget drawer(BuildContext context) {
  return Drawer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header of the Drawer
        Material(
          color: Color.fromRGBO(28, 79, 122, 1),
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 20,
                  bottom: 24,
                  left: 20,
                  right: 20),
              child: Row(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Priya',
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Priya@gmail.com',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: "Roboto"),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  CircleAvatar(
                    radius: 52,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHNtaWx5JTIwZmFjZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'),
                  ),
                ],
              ),
            ),
          ),
        ),

        /// Header Menu items
        Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.home_outlined,
                color: mainColor7,
              ),
              title: Text('Home'),
              onTap: () {
                /// Close Navigation drawer before
                Navigator.pop(context);
                Navigator.pushNamed(context, "/home");
              },
            ),
            ListTile(
              leading: Icon(
                Icons.favorite_border,
                color: mainColor7,
              ),
              title: Text('Favourites'),
              onTap: () {
                /// Close Navigation drawer before
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.workspaces,
                color: mainColor7,
              ),
              title: Text('Apply'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/apply');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.payments_outlined,
                color: mainColor7,
              ),
              title: Text('Payments'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/payment');
              },
            ),
            const Divider(
              color: Colors.black45,
            ),
            ListTile(
              leading: Icon(
                Icons.account_tree_outlined,
                color: mainColor7,
              ),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications_outlined, color: mainColor7),
              title: Text('Notifications'),
              onTap: () {},
            ),
          ],
        ),
      ],
    ),
  );
}

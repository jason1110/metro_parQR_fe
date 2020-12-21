// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// final String baseURL = "https://metro-parqr.herokuapp.com";
// final String usersURL = "$baseURL/users";

// class HttpService {




// SHOW

// // Future<Album> fetchAlbum() async {
// //   final response =
// //       await http.get('https://metro-parqr.herokuapp.com/users/1');
// //       print(response.body);
// //   if (response.statusCode == 200) {
// //     // If the server did return a 200 OK response,
// //     // then parse the JSON.
// //     return Album.fromJson(jsonDecode(response.body));
// //   } else {
// //     // If the server did not return a 200 OK response,
// //     // then throw an exception.
// //     throw Exception('Failed to load album');
// //   }
// // }

// class MyFetch extends StatefulWidget {
//   MyFetch({Key key}) : super(key: key);

//   @override
//   _MyFetchState createState() => _MyFetchState();
// }

// class _MyFetchState extends State<MyFetch> {
//   Future<User> futureUser;

//   @override
//   void initState() {
//     super.initState();
//     futureUser = fetchUser();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'User Profile',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('User Profile'),
//         ),
//         body: Center(
//           child: FutureBuilder<User>(
//             future: futureUser,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 print(snapshot.data.email);
//                 return Text( snapshot.data.email);
//               } else if (snapshot.hasError) {
//                 return Text("${snapshot.error}");
//               }

//               // By default, show a loading spinner.
//               return CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }






// INDEX
// Future<List<User>> fetchUsers() async {
//   final response =
//       await http.get('https://metro-parqr.herokuapp.com/users');
//       print(response.body);
//     if (response.statusCode == 200) {
//       List body = jsonDecode(response.body)['users'];
//       List users = body
//       .map(
//         (dynamic user) => User.fromJson(user),
//         )
//         .toList();
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return users;
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load Users');
//   }
// }
// class AllFetch extends StatefulWidget {
//   // AllFetch({Key key}) : super(key: key);

//   @override
//   _AllFetchState createState() => _AllFetchState();
// }

// class _AllFetchState extends State<AllFetch> {
//   var futureUsers;

//   @override
//   void initState() {
//     super.initState();
//     futureUsers = fetchUsers();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'User Profile',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('User Profile'),
//         ),
//         body: Center(
//           child: FutureBuilder<List<User>>(
//             future: futureUsers,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 List<User> users = snapshot.data;
//                 print(users.map((user)=> user.name));
//                 return new Card(
//                   child: ListTile(
//                     title: Text("${users.map((user)=> user.name)}"),
//                   )
//                 );
//               } else if (snapshot.hasError) {
//                 return Text("${snapshot.error}");
//               }

//               // By default, show a loading spinner.
//               return CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
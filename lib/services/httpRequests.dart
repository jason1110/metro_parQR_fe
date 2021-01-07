import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/meter.dart';

// final String baseURL = "https://metro-parqr.herokuapp.com";
// final String usersURL = "$baseURL/users";
// final String metersURL = "$baseURL/meters";

class NetworkHelper {

NetworkHelper(this.url);

final String url;

// // SHOW METER

Future fetchMeter() async {
  http.Response response =
      await http.get(url);
  if (response.statusCode == 200) {
    String data = response.body;
    var decodedData = jsonDecode(data);
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return decodedData;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Meter');
  }
}


// Future<Meter> fetchMeter() async {
//   final response =
//       await http.get('https://metro-parqr.herokuapp.com/meters/1');
//       print(response.body);
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Meter.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load Meter');
//   }
// }

// class GetMeter extends StatefulWidget {
//   GetMeter({Key key}) : super(key: key);

//   @override
//   _GetMeterState createState() => _GetMeterState();
// }

// class _GetMeterState extends State<GetMeter> {
//   Future<Meter> futureMeter;

//   @override
//   void initState() {
//     super.initState();
//     futureMeter = fetchMeter();
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
//           child: FutureBuilder<Meter>(
//             future: futureMeter,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 print(snapshot.data.freeTime);
//                 return Text( snapshot.data.freeTime);
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
}








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
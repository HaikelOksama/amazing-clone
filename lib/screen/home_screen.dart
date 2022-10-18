import 'package:amazon/resources/cloud_firestore_methods.dart';
import 'package:amazon/utils/colors_theme.dart';
import 'package:amazon/utils/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _search;
  final screenSize = Utils().getScreenSize();
  late final CollectionReference users;
  @override
  void initState() {
    _search = TextEditingController();
    users = FirebaseFirestore.instance.collection('users');
    super.initState();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  int notificationCounter = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: [
            ClipOval(
              clipper: MyClipper(),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black45,
                      spreadRadius: 2,
                      blurRadius: 8,
                    )
                  ],
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: const Alignment(0.8, 1),
                      colors: <Color>[activeCyanColor, lightCyan]),
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: const Alignment(0.8, 1),
                        colors: <Color>[activeCyanColor, Colors.cyan[300]!]),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: screenSize.width * 0.5,
                        child: TextField(
                          controller: _search,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(top: 8),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Search Anything',
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.orange, width: 2)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: activeCyanColor),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            prefixIcon: const Icon(
                              Icons.search,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        iconSize: 30,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.receipt_long_outlined,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        iconSize: 30,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.mail_outline_outlined,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            notificationCounter++;
                          });
                        },
                        child: Stack(alignment: Alignment.topRight, children: [
                          IconButton(
                            iconSize: 30,
                            onPressed: () {
                              setState(() {
                                notificationCounter++;
                              });
                            },
                            icon: const Icon(
                              Icons.notifications_none_outlined,
                              color: Colors.white,
                            ),
                          ),
                          notificationCounter != 0
                              ? Container(
                                  margin: EdgeInsets.only(top: 8),
                                  height: 16,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    child: Text(
                                      notificationCounter.toString(),
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                )
                              : const SizedBox()
                        ]),
                      ),
                      IconButton(
                        iconSize: 30,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notes_outlined,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: screenSize.width * 1,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                      FutureBuilder(
                        future: CloudFirestoreMethods().getUserAddress(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text("Something went wrong",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w100));
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return RichText(
                                text: TextSpan(
                                    style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w100),
                                    text: 'Your Address : ',
                                    children: <TextSpan>[
                                  TextSpan(
                                    text: snapshot.data,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]));
                          }
                          return const Text('Please Wait',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w100));
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: screenSize.width * 0.8,
                  padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 2,
                          blurRadius: 10,
                        )
                      ],
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.account_balance_wallet_outlined,
                              color: activeCyanColor,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Rp0',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Your Wallet is Empty',
                                style: TextStyle(color: Colors.grey[400]!),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.receipt_outlined,
                              color: Color(0xffa0e9ce),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // const Text(
                              //   '0',
                              //   style: TextStyle(
                              //       fontSize: 12, fontWeight: FontWeight.bold),
                              // ),
                              Text(
                                'No Coupon Available',
                                style: TextStyle(color: Colors.grey[400]!),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        const SingleChildScrollView()
      ],
    );
  }
}

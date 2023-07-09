import 'dart:ffi';

import 'package:debt_tracker_mobile/application/debt/debt_bloc.dart';
import 'package:debt_tracker_mobile/application/user/profile/profile_bloc.dart';
import 'package:debt_tracker_mobile/data/local/shared_preferences/preference_service.dart';
import 'package:debt_tracker_mobile/domain/debt/debt.dart';
import 'package:debt_tracker_mobile/domain/user/user_profile.dart';
import 'package:debt_tracker_mobile/presentation/profile/profile_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestDebtPage extends StatefulWidget {
  const RequestDebtPage({super.key});

  @override
  State<RequestDebtPage> createState() => _RequestDebtPageState();
}

class _RequestDebtPageState extends State<RequestDebtPage> {
  UserProfile? lender;
  String username = '';
  int amount = 0;
  String description = '';
  bool showSuggestions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black87,
                  ),
                  child: InkWell(
                    enableFeedback: false,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text('Request Debt',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Stack(children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Lender",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 10,
                            ),
                            (lender != null)
                                ? ProfileChip((lender) as UserProfile, () {
                                    setState(() {
                                      lender = null;
                                    });
                                  })
                                : Container(),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: 'Username'),
                                onChanged: (value) {
                                  username = value;
                                  if (username.length > 0) {
                                    BlocProvider.of<ProfileBloc>(context)
                                        .add(SearchUsername(username));
                                    setState(() {
                                      showSuggestions = true;
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Amount',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.money),
                                    hintText: 'Amount',
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none),
                                onChanged: (value) {
                                  if (value.length > 0) {
                                    amount = int.tryParse(value) ?? 0;
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Description',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 2),
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                maxLines: 7,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none),
                                onChanged: (value) {
                                  description = value;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            BlocConsumer<DebtBloc, DebtState>(
                              listener: (context,state) {
                                if (state is DebtSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Debt Requested'))
                                  );
    
                                  BlocProvider.of<DebtBloc>(context).add(GetDebts());
                                }
                              },
                              builder: (context, state) {
                                return Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (lender != null) {
                                      BlocProvider.of<DebtBloc>(context).add(
                                      RequestDebt(
                                        RequestDebtForm(
                                          lenderId: lender!.id,
                                          amount: amount,
                                          description: description,
                                        )
                                      )
                                    );
                                    }
                                  },
                                  child: (state is DebtLoading) ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                      strokeWidth: 1,
                                    ),
                                  ) : Text('Request'),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black87,
                                      padding: EdgeInsets.symmetric(vertical: 15),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10))),
                                ),
                              );
                              }  
                            )
                          ]),
                      BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                        if (state is ProfileSuccessMultiple && showSuggestions && username.length > 0) {
                          return Positioned(
                              top: 100,
                              child: SingleChildScrollView(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(maxHeight: 300),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width - 40,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: FutureBuilder(
                                        future: PreferenceService.getUser(),
                                        builder: ((context, snapshot) {
                                          if (snapshot.hasData) {
                                            String me = snapshot.data!.id;
    
                                            return ListView.separated(
                                              shrinkWrap: true,
                                              itemCount: state.profiles.length,
                                              itemBuilder: (context, index) {
                                                UserProfile profile =
                                                    state.profiles[index];
                                                if (profile.id != me)
                                                  return Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          lender = profile;
                                                          showSuggestions = false;
                                                        });
                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        width: double.infinity,
                                                        color: Colors.white,
                                                        child: Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 20,
                                                              backgroundColor:
                                                                  Colors.black12,
                                                            ),
                                                            SizedBox(width: 20),
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  profile.name,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                                Text(
                                                                  '@${profile.username}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                return Container();
                                              },
                                              separatorBuilder: (context, index) {
                                                if (state.profiles[index].id !=
                                                    me) {
                                                  return Divider();
                                                }
                                                return Container();
                                              },
                                            );
                                          }
                                          return Container();
                                        })),
                                  ),
                                ),
                              ));
                        } else {
                          return Container();
                        }
                      })
                    ])),
              ),
            )
          ],
        ),
      ),
    );
  }
}

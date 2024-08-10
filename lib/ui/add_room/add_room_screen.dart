import 'dart:async';

import 'package:chattapp/model/category.dart';
import 'package:chattapp/ui/add_room/add_room_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_room_navigator.dart';
import 'package:chattapp/utils.dart' as Utils;

class AddRoom extends StatefulWidget {
  static const String routeName = 'AddRoom';

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> implements AddRoomNavigator {
  AddRoomViewModel viewModel = AddRoomViewModel();
  String roomTitle = '';
  String roomDescription = '';
  var formKey = GlobalKey<FormState>();
  var categoryList = Category.getCategory();
  late Category selectedItem;
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
    selectedItem = categoryList[0];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Image.asset(
            'assets/images/background.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text('Add Room'),
              centerTitle: true,
            ),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 18, vertical: 32),
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ]),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Creat New Room',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Image.asset("assets/images/room.png"),
                      TextFormField(
                        decoration:
                            InputDecoration(hintText: 'Enter Room Title'),
                        onChanged: (text) {
                          roomTitle = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return " Please enter room title";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<Category>(
                                  value: selectedItem,
                                  items: categoryList
                                      .map((category) =>
                                          DropdownMenuItem<Category>(
                                              value: category,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(category.title),
                                                  Image.asset(category.image),
                                                ],
                                              )))
                                      .toList(),
                                  onChanged: (newCategory) {
                                    if (newCategory == null) return;
                                    selectedItem = newCategory;
                                    setState(() {});
                                  }),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter Room Description',
                        ),
                        onChanged: (text) {
                          roomDescription = text;
                        },
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return " Please enter room Description";
                          }
                          return null;
                        },
                        maxLines: 4,
                        minLines: 4,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            validateForm();
                          },
                          child: Text('Add Room'))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void validateForm() {
    if (formKey.currentState?.validate() == true) {
      // add room
      viewModel.addRoom(roomTitle, roomDescription, selectedItem.id);
    }
  }

  @override
  void hideLoading() {
    Utils.hideLoading(context);
  }

  @override
  void showLoading() {
    Utils.showLoading(context, 'Loading');
  }

  @override
  void showMessage(String message) {
    Utils.showMessage(context, message, 'ok', (context) {
      Navigator.pop(context);
    });
  }

  @override
  void navigatorToHome() {
    Timer(Duration(seconds: 3), () {
      Navigator.pop(context);
    });
  }
}

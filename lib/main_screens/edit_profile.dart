// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';
import 'package:multi_store_app/widgets/snackbar.dart';
import 'package:multi_store_app/widgets/yellow_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditProfile extends StatefulWidget {
  final dynamic data;
  const EditProfile({Key? key, this.data}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late String profileName;
  late String profileImage;
  late String profilePhone;
  late String profileAddress;
  bool processing = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final ImagePicker _picker = ImagePicker();

  XFile? imageFileImage;
  dynamic _pickedImageError;

  pickProfileImage() async {
    try {
      final pickedProfileImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        imageFileImage = pickedProfileImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  Future uploadProfileImage() async {
    if (imageFileImage != null) {
      try {
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref('cust-images/${widget.data['email']}.jpg');

        await ref.putFile(File(imageFileImage!.path));

        profileImage = await ref.getDownloadURL();
      } catch (e) {
        print(e);
      }
    } else {
      profileImage = widget.data['profileimage'];
    }
  }

  editProfileData() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('customers')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      transaction.update(documentReference, {
        'name': profileName,
        'profileimage': profileImage,
        'phone': profilePhone,
        'address': profileAddress,
      });
    }).whenComplete(() => Navigator.pop(context));
  }

  saveChanges() async {
    if (formKey.currentState!.validate()) {
      // continue
      formKey.currentState!.save();
      setState(() {
        processing = true;
      });
      await uploadProfileImage().whenComplete(
          () async => editProfileData());
    } else {
      MyMessageHandler.showSnackBar(_scaffoldKey, 'Please fill all fiels');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppBarBackButton(),
          elevation: 0,
          backgroundColor: Colors.white,
          title: const AppBarTitle(
            title: 'Edit Profile',
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Column(
                  children: [
                    const Text(
                      'Profile Image',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            widget.data['profileimage'],
                          ),
                        ),
                        Column(
                          children: [
                            YellowButton(
                              label: 'Change',
                              onPressed: () {
                                pickProfileImage();
                              },
                              width: 0.25,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            imageFileImage == null
                                ? const SizedBox()
                                : YellowButton(
                                    label: 'Reset',
                                    onPressed: () {
                                      setState(() {
                                        imageFileImage = null;
                                      });
                                    },
                                    width: 0.25,
                                  ),
                          ],
                        ),
                        imageFileImage == null
                            ? const SizedBox()
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(
                                  File(
                                    imageFileImage!.path,
                                  ),
                                ),
                              ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Divider(
                        color: Colors.yellow,
                        thickness: 2.5,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please Enter profile name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      profileName = value!;
                    },
                    initialValue: widget.data['name'],
                    decoration: textFormDecoration.copyWith(
                      labelText: 'Profile Name',
                      hintText: 'Enter Profile Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please Enter Phone Number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      profilePhone = value!;
                    },
                    initialValue: widget.data['phone'],
                    decoration: textFormDecoration.copyWith(
                      labelText: 'Phone Number',
                      hintText: 'Enter Phone Number',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please Enter Phone ';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      profileAddress = value!;
                    },
                    initialValue: widget.data['address'],
                    decoration: textFormDecoration.copyWith(
                      labelText: 'Address ',
                      hintText: 'Enter Address ',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      YellowButton(
                          label: 'Cancel',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          width: 0.25),
                      processing == true
                          ? YellowButton(
                              label: 'Please Wait ...',
                              onPressed: () {
                                null;
                              },
                              width: 0.5)
                          : YellowButton(
                              label: 'Save Changes',
                              onPressed: () {
                                saveChanges();
                              },
                              width: 0.5),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: 'price',
  hintText: 'price .. \$',
  labelStyle: const TextStyle(color: Colors.purple),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.yellow, width: 1),
      borderRadius: BorderRadius.circular(10)),
  focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
      borderRadius: BorderRadius.circular(10)),
);

// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../model/server.dart';

class ConnectionDatabase extends StatefulWidget {
  const ConnectionDatabase({Key? key}) : super(key: key);
  @override
  _ConnectionDatabaseState createState() => _ConnectionDatabaseState();
}

class _ConnectionDatabaseState extends State<ConnectionDatabase> {
  File? image;
  bool _isLoading = false;
  Uint8List? decodedBytes;
  List _images = [];

  Future<void> _getPosts() async {
    setState(() {
      _isLoading = true;
    });
    await Services.getAllPosts().then((posts) {
      setState(() {
        _images = posts;
        _isLoading = false;
      });
    });
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        print("Not Selected Images : ");
        return;
      } else {
        final imageTemporary = File(image.path);
        setState(() {
          this.image = imageTemporary;
          convertImage(imageTemporary);
        });
      }
    } on PlatformException catch (e) {
      return ("Error: $e");
    }
  }

  Future convertImage(File image) async {
    Uint8List imageBytes = await image.readAsBytes();
    String base64string = base64.encode(imageBytes);
    _addPost(base64string);
  }

  _createTable() {
    Services.creatTable().then((result) {
      if ('success' == result) {
        print('Success Create Table');
        return;
      } else {
        print('Not Create Table');
      }
    });
  }

  _addPost(String imageCode) async {
    setState(() {
      _isLoading = true;
    });
    await Services.addImage(imageCode).then((result) {
      if ('success' == result) {
        print("Image Uploaded : ");
        _getPosts();
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xFF09D5A2),
            content: Row(
              children: const [
                Icon(Icons.thumb_up_off_alt_rounded, color: Colors.white),
                Text(
                  'Yes Image Uploading',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      }
    });
  }

  // ================================================ //
  @override
  void initState() {
    super.initState();
    _createTable();
  }

  // ================================================ //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pickImage();
        },
        child: Icon(Icons.add_a_photo),
      ),
      appBar: AppBar(
        title: Text('Images'),
        actions: [
          _isLoading
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Container(),
        ],
      ),
      body: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: _images.length,
          itemBuilder: (context, index) {
            return SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        MemoryImage(base64Decode(_images[index].imageString)),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

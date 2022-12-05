import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'styles/main_title_text.dart';
import 'styles/sub_title_text.dart';
import './models/post.dart';
import './models/main_user.dart';

class NewPostPage extends StatefulWidget {
  final MainUser user;
  final Function callback;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final picker = ImagePicker();

  NewPostPage(this.callback, {required this.user, Key? key}) : super(key: key);

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  bool isAnonymous = true;
  bool published = true;
  List<Image> images = [];
  List<String> imageLinks = [];

  void _transition(BuildContext context) {
    if (widget._titleController.text.isEmpty) {
      _showDialog("제목을 입력해주세요", context: context);
      return;
    }
    if (widget._contentController.text.isEmpty) {
      _showDialog("내용을 입력해주세요", context: context);
      return;
    }

    widget.callback(
      Post(
        id: "",
        title: widget._titleController.text,
        description: widget._contentController.text,
        published: published,
        uid: "",
        userName: "",
        userPhotoUrl: "",
        anonymous: isAnonymous,
        createdAt: DateTime.now(),
        likes: 0,
        liked: false,
        images: imageLinks,
        comments: [],
      ),
    );
    Navigator.pop(context);
  }

  void _showDialog(String contents, {required context}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(contents),
          actions: <Widget>[
            TextButton(
              child: const Text("닫기"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future getImage() async {
    XFile? image = await widget.picker.pickImage(source: ImageSource.gallery);
    //print(image);
    if (image == null) {
      return;
    }
    /*
    final filePath = image.path;

    var dio = Dio();
    var formData =
        FormData.fromMap({'file': await MultipartFile.fromFile(filePath)});

    // 업로드 요청
    final response = await dio.post('/upload', data: formData);
    */
    setState(() {
      images.add(Image.file(File(image.path))); // 가져온 이미지를 _image에 저장
    });
  }

  Widget imageBlock(Image image) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        image,
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child:
                const Text("X", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          onPressed: () {
            setState(() {
              images.remove(image);
            });
          },
        ),
      ],
    );
  }

  Widget _title() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          MainTitle(
            title: "WRITE POST",
            theme: Color(0xFF3D5D54),
          ),
          SubTitle(
            title: "글쓰기",
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          // head
          newPostHead(),
          //textbox
          const SizedBox(height: 10),
          newPostBody(),
          //button
          Padding(
            padding: const EdgeInsets.all(40),
            child: SizedBox(
              child: _TransitionButton(
                () => _transition(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget newPostHead() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 70,
      child: Row(
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: Image.network(widget.user.photoUrl),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(fontFamily: 'Roboto'),
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      hintText: '제목',
                      hintStyle: TextStyle(fontFamily: 'Roboto'),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF3D5D54)),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF3D5D54)),
                      ),
                    ),
                    controller: widget._titleController,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: getImage,
                      icon: const Icon(
                        Icons.camera_alt,
                        size: 20,
                      ),
                    ),
                    Checkbox(
                      value: isAnonymous,
                      activeColor: Colors.white,
                      checkColor: Colors.grey,
                      onChanged: (bool? value) {
                        setState(() {
                          isAnonymous = value!;
                        });
                      },
                    ),
                    const MainTitle(
                      title: "익명",
                      size: 15,
                      theme: Color(0xFF3D5D54),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget newPostBody() {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFE4F0ED),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: widget._contentController,
                style:
                    const TextStyle(color: Colors.black, fontFamily: 'Roboto'),
                maxLines: null,
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: images.isEmpty ? 0 : 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return imageBlock(images[index]);
                },
                itemCount: images.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _title(),
            _body(context),
          ],
        ),
      ),
    );
  }
}

class _TransitionButton extends StatelessWidget {
  final VoidCallback _callback;

  const _TransitionButton(this._callback, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(148, 34),
        backgroundColor: const Color(0xFF3D5D54),
        side: const BorderSide(
          color: Colors.white,
          width: 0.5,
        ),
      ),
      onPressed: _callback,
      child: const MainTitle(
        title: "글쓰기",
        size: 15,
        theme: Colors.white,
      ),
    );
  }
}

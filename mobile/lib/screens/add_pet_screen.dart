import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:vetlink/screens/pet_screen.dart';

import '../model/pet.dart';
import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

class AddPetScreen extends StatefulWidget {
  final Pet? pet;
  const AddPetScreen({Key? key, this.pet}) : super(key: key);

  @override
  _AddPetScreenState createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  Uint8List? _file;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _raceController = TextEditingController();
  final TextEditingController _subRaceController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _allergyController = TextEditingController();
  final TextEditingController _healthProblemsController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState()  {
    super.initState();
    initializePetData();
  }

  Future<void> initializePetData() async {
    if (widget.pet != null) {
      setState(() {
        _isEditing = true;
        _nameController.text = widget.pet!.name;
        _raceController.text = widget.pet!.race;
        _subRaceController.text = widget.pet!.subRace;
        _typeController.text = widget.pet!.type;
        _allergyController.text = widget.pet!.allergy;
        _healthProblemsController.text = widget.pet!.healthProblems;
        _ageController.text = widget.pet!.age;
      });


      setState(() {});
    }
  }




  bool _isLoading = false;
  void addOrUpdatePet(String uid, String username) async {
    if (_nameController.text.isEmpty ||
        _raceController.text.isEmpty ||
        _subRaceController.text.isEmpty ||
        _typeController.text.isEmpty ||
        _allergyController.text.isEmpty ||
        _healthProblemsController.text.isEmpty ||
        _ageController.text.isEmpty) {
      showSnackBar("Please fill in all fields", context);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      if (_isEditing && widget.pet?.id != null) {

        await FirestoreMethods().updatePet(
          widget.pet!.id!,
            _nameController.text,
            _raceController.text,
            _subRaceController.text,
            _typeController.text,
            _ageController.text,
            _allergyController.text,
            _healthProblemsController.text,
            uid);
      } else {
        // If adding a new pet
        String res = await FirestoreMethods().addPet(
          _nameController.text,
          _raceController.text,
          _subRaceController.text,
          _file!,
          _typeController.text,
          _ageController.text,
          _allergyController.text,
          _healthProblemsController.text,
          uid,
        );
        if (res != "succes") {
          showSnackBar(res, context);
        }
      }

      setState(() {
        _isLoading = false;
      });
      showSnackBar("Saved", context);
      clearImage();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          )));
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(err.toString(), context);
    }
  }


  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Animal nou"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Fa o fotografie"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.camera,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Alege din galerie"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.gallery,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Anuleaza"),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _raceController.dispose();
    _subRaceController.dispose();
    _typeController.dispose();
    _allergyController.dispose();
    _healthProblemsController.dispose();
    _ageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    var screenHeight = MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("Animal nou"),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () => addOrUpdatePet(
                userProvider.getUser!.uid, userProvider.getUser!.username),
            child: const Text(
              'Adauga',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: Stack(
            children: [
            Positioned.fill(
              child: Image.asset(
                'assets/dark_background.png',
                fit: BoxFit.cover,
              ),
            ),
            Column(children: [
              _isLoading
                  ? const LinearProgressIndicator()
                  : const Padding(
                padding: EdgeInsets.only(top: 0),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: "Nume",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9 ,
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.category,
                              color: Color.fromARGB(255, 0, 0, 0)),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: TextField(
                              controller: _typeController,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                hintText: "Tip animal",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 12.0),
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 13.0, vertical: 25),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                const Icon(Icons.pets,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: TextField(
                                    controller: _raceController,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      hintText: "Rasa",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                      contentPadding:
                                      EdgeInsets.symmetric(vertical: 12.0),
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 25),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                const Icon(Icons.filter_list,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: TextField(
                                    controller: _subRaceController,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                      hintText: "Subrasa",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                      contentPadding:
                                      EdgeInsets.symmetric(vertical: 12.0),
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9 ,
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.hourglass_top,
                              color: Color.fromARGB(255, 0, 0, 0)),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: TextField(
                              controller: _ageController,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                hintText: "Varsta",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 12.0),
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.89,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _allergyController,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                hintText: " Adauga alergii",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 13.0, horizontal: 7.0),
                              ),
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.89,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _healthProblemsController,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                hintText: " Adauga probleme de sanatate ",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 13.0, horizontal: 7.0),
                              ),
                              maxLines: 5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
              _file == null
                  ? Center(
                child: Container(
                  width: 300.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.upload),
                    onPressed: () => _selectImage(context),
                  ),
                ),
              )
                  : Center(
                child:  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 46),
                      width: 300.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        border:
                        Border.all(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(_file!),
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),

              ),
            ]),
          ],
        ),
      ),
      ),
    );
  }
}

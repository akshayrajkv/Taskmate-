// import 'dart:io';

// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';

// class Cloudineryservises {
//   File? imagefile;
//   String? imageurl;
//   Future<void>pickimage(ImageSource source)async{
//     final ImagePicker picker =ImagePicker();
//     final XFile? pickfile =await picker.pickImage(source: source);
//     if(pickfile!=null)imagefile=File(pickfile.path);
  

//   }

//   Future<void>uploadimage()async{
//     final url =Uri.parse('https//api.cloudinary.com/v1_1/dm3ylk878/upload');
//     final request = http.MultipartRequest('POST', url)..fields['upload_preset']='taskmateprofile'
//     ..files.add(await http.MultipartFile.fromPath('file', imagefile!.path));
//     final response =await request.send();
//     if(response.stream==200){
//       final responsedata = await response.stream.toBytes();
//       final responseString = String.fromCharCode(responsedata);
//     }
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class CloudinaryServices {
  File? imageFile;
  String? imageUrl;

  // Pick Image from camera or gallery
  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
  }

  // Upload Image to Cloudinary
  Future<void> uploadImage() async {
    if (imageFile == null) {
      print("No image selected");
      return;
    }

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dm3ylk878/upload');

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'taskmateprofile'
      ..files.add(await http.MultipartFile.fromPath('file', imageFile!.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final jsonData = jsonDecode(responseData);
      imageUrl = jsonData['secure_url'];
      print("Image uploaded: $imageUrl");
    } else {
      print("Image upload failed: ${response.statusCode}");
    }
  }
}



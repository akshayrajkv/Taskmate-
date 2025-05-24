import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:task_mate2/features/todo_screen/services/cloudinery.dart';
import 'package:task_mate2/features/todo_screen/view_model/todo_viewmodel.dart';
import 'package:task_mate2/util/consts.dart';
import 'package:task_mate2/widgets/customtext.dart';

class Profilepage extends StatelessWidget {
  Profilepage({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    CloudinaryServices _cloudinery =CloudinaryServices();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme:const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        title: const Customtext(
          text: 'Profile ',
          color: Colors.white,
          size: 26,
        ),
      ),
      body: Container(
        decoration:const BoxDecoration(
          image: DecorationImage(image:backgroundimage,fit: BoxFit.cover)
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Consumer<TodoViewModel>(builder: (context, values, _) {
            final User = values.user;
            return Column(
              children: [
                SizedBox(height: 150,),
                Container(
                  height: 250,
                  width: double.infinity,
                  child: Center(
                    child: Stack(children: [
                        CircleAvatar(
                        
                        radius: 80,
                        backgroundColor: Colors.amberAccent,
                        backgroundImage:User?.profileimage==null?const AssetImage('assets/istockphoto-1337144146-612x612.jpg',
                      )
                        : NetworkImage(
                            '${User!.profileimage}'),
                      ),
                      Positioned(
                          right: 10,
                          bottom: 2,
                          child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color:bottombuttoncolor,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 3,
                                      )),
                              child: Center(
                                  child: IconButton(
                                      onPressed: ()async {
                                    await   _cloudinery.pickImage(ImageSource.gallery);
                                    await _cloudinery.uploadImage();
                                    if(_cloudinery.imageUrl!=null){
                                      print(_cloudinery.imageUrl);
                                      await Provider.of<TodoViewModel>(context,listen: false).updateuser(_cloudinery.imageUrl!);
                                    }
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        size: 20,
                                        color: Colors.white,
                                      )))))
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: const Icon(Icons.person_2_outlined,color: Colors.white,),
                  title: Text(User?.name ?? "Name",style:const TextStyle(color: Colors.white),),
                ),
                ListTile(
                  leading: const Icon(Icons.email_outlined,color: Colors.white,),
                  title: Text(User?.email ?? 'Email',style:const TextStyle(color: Colors.white),),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/aboutpage');
                  },
                  leading: const Icon(Icons.info_outline,color: Colors.white,),
                  title: const Text('about',style: TextStyle(color: Colors.white),),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}

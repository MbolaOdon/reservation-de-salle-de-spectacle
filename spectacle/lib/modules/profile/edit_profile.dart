import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectacle/languages/appLocalizations.dart';
import 'package:spectacle/routes/route_names.dart';
import 'package:spectacle/utils/localfiles.dart';
import 'package:spectacle/utils/themes.dart';
import 'package:spectacle/widgets/common_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile>createState() => _EditProfileState();

}



class _EditProfileState extends State<EditProfile> {
  @override
   void initState() {
    // TODO: implement initState
   
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
   
    super.dispose();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed:() {Navigator.pop(context);}, icon: Icon(FontAwesomeIcons.angleLeft)),
        title: Text(AppLocalizations(context).of('edit_profile'), style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(image: AssetImage(Localfiles.avatar1)),
                    )
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppTheme.primaryColor
                      ),
                      child: Icon( Icons.camera_alt, size: 20, color: AppTheme.primaryTextColor),
                    ),
                  )
                ],
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text(AppLocalizations(context).of('full_name')),
                        prefixIcon: Icon(FontAwesomeIcons.user)
                        ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text(AppLocalizations(context).of('email')),
                        prefixIcon: Icon(FontAwesomeIcons.user)
                        ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text(AppLocalizations(context).of('phone')),
                        prefixIcon: Icon(FontAwesomeIcons.user)
                        ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                        label: Text(AppLocalizations(context).of('password')),
                        prefixIcon: Icon(FontAwesomeIcons.user),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: BorderSide(width:2, color: AppTheme.secondaryTextColor)),
                        ),
                    ),
                    SizedBox(height: 20,),

                     CommonButton(
                      padding: EdgeInsets.only(left: 24, right: 24, bottom: 16),
                      buttonText: AppLocalizations(context).of("edit_profile"),
                      onTap: () {
                       
                          NavigationServices(context).gotoHomePage();
                      },
                    ),
                  ],
                ),
                ),

            ]
            
          ),
        ) ,
        ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LocationPage extends StatefulWidget {
  LocationPage({
    super.key,
  });

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final user = FirebaseAuth.instance.currentUser!;

  TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address'),
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              placesAutoCompleteTextField(),
              Container(
                margin: EdgeInsets.all(18),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    saveLocation();

                  },
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 22),
                  ),
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      minimumSize: Size.fromHeight(80),
                      backgroundColor: Theme.of(context).colorScheme.secondary),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  placesAutoCompleteTextField() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: GooglePlaceAutoCompleteTextField(
            textEditingController: controller,
            googleAPIKey: dotenv.env['GOOGLE_API_KEY']??'',
            inputDecoration: InputDecoration(
              hintText: "Search your location",
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            debounceTime: 400,
            countries: ["my"],
            isLatLngRequired: true,
            getPlaceDetailWithLatLng: (Prediction prediction) {
              print("placeDetails" + prediction.lat.toString());
            },

            itemClick: (Prediction prediction) {
              controller.text = prediction.description ?? "";
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: prediction.description?.length ?? 0));
              FocusScope.of(context).unfocus();
            },
            seperatedBuilder: Divider(),
            containerHorizontalPadding: 10,

            itemBuilder: (context, index, Prediction prediction) {
              return Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(
                    width: 7,
                  ),
                  Expanded(child: Text("${prediction.description ?? ""}"))
                ],
              );
            },

            isCrossBtnShown: true,
            focusNode: focusNode,

            // default 600 ms ,
          ),
        ),
        // SizedBox(height: 10,),
        //   TextButton(onPressed: (){}, child: Text('save'))
      ],
    );
  }

  Future<void> saveLocation() async {
    try{
    if (controller.text.trim().isNotEmpty) {
      // Fetch dc id
      final snapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .collection("Profile")
          .get();

      if (snapshot.docs.isNotEmpty) {
        //getters
        final profileDocId = snapshot.docs.first.id;

        // Update the field in the Profile document
        FirebaseFirestore.instance
            .collection("Users")
            .doc(user.uid)
            .collection("Profile")
            .doc(profileDocId)
            .update({'location': controller.text});
      }
      print('Successfully created Location');
    }
  }catch(e){
    print('Oh You suck!! $e');
  }
  }
}

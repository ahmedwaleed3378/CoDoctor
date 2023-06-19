import 'package:flutter/material.dart';
import 'package:flutter_project/views/custom_widgets/theme.dart';

class SearchField extends StatefulWidget {
   SearchField({
    required this.controller,
    Key? key,
  }) : super(key: key);
  TextEditingController controller=TextEditingController();

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child:  TextField(
          onTap: () {
            
          },
          onSubmitted: (value) {
            setState(() {
              isLoading=true;
            });
            print(widget.controller.text);
          },
          controller: widget.controller,
          decoration: InputDecoration(
              fillColor:const Color.fromRGBO(0, 0, 0, 0.25),
              filled: true,
              hintText: 'Search for Doctors',
              hintStyle: subtitleStyle.copyWith(color: Colors.white30),
              border:const OutlineInputBorder(borderSide: BorderSide.none),
              prefixIcon: Padding(
                  padding:const EdgeInsets.all(14), child:isLoading?CircularProgressIndicator() :Icon(Icons.search))),
        ),
      ),
    );
  }
}

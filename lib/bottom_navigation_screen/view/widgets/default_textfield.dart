import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final void Function()? onTapSuffixIcon;
  final String? Function(String? v,)? validator;
  final void Function(String v,)? onChanged;
  final void Function(String v,)? onFieldSubmitted;
  final void Function(String? v,)? onSaved;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  const DefaultTextField({super.key,required this.label,this.prefixIcon,this.suffixIcon,this.onTapSuffixIcon,this.keyboardType,this.controller ,this.validator,this.onChanged,this.onFieldSubmitted,this.onSaved,this.onTap,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted:onFieldSubmitted ,
      onSaved: onSaved,
      onTap: onTap,
      keyboardType: keyboardType,
      decoration:InputDecoration(
        prefixIcon: Icon(prefixIcon),
        suffixIcon: GestureDetector(onTap: onTapSuffixIcon,child: Icon(suffixIcon,),),
        labelText: label,
        border:OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.grey,width: 1,)
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.grey,width: 1,)
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.grey,width: 1,)
      ),
       ),

    );
  }
}
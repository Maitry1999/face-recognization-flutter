import 'package:attandence_system/domain/core/math_utils.dart';
import 'package:attandence_system/presentation/common/widgets/base_text.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class CommonCountryCodePicker extends StatelessWidget {
  final Function(Country) onChanged;
  final String? initialSelection;
  const CommonCountryCodePicker({
    super.key,
    required this.onChanged,
    this.initialSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getSize(20)),
      child: GestureDetector(
        onTap: () {
          showFlag(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseText(
              text: '+ $initialSelection',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              width: getSize(10),
            ),
            Icon(Icons.keyboard_arrow_down_rounded),
            SizedBox(
              width: getSize(15),
            ),
          ],
        ),
      ),
    );
  }

  void showFlag(BuildContext context) {
    showCountryPicker(
      context: context,

      exclude: <String>['KN', 'MF'],
      favorite: <String>['SE'],
      //Optional. Shows phone code before the country name.
      showPhoneCode: true,
      onSelect: onChanged,
      countryListTheme: CountryListThemeData(
        inputDecoration: InputDecoration(
          //labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
                // color: ColorConstants.unableColor,
                ),
          ),
          focusedBorder: UnderlineInputBorder(
              // borderSide: BorderSide(color: ColorConstants.unableColor),
              ),
          enabledBorder: UnderlineInputBorder(
              // borderSide: BorderSide(color: ColorConstants.unableColor),
              ),
        ),
      ),
    );
  }
}

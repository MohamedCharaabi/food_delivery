import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/pages/profile/widgets/AppTheme.dart';
import 'package:food_delivery_flutter/utils/SizeConfig.dart';
import 'package:food_delivery_flutter/utils/values/values.dart';
// import 'package:food_delivery_flutter/utils/colors2.dart';
// import 'package:food_delivery_flutter/utils/sizes.dart';
// import 'package:food_delivery_flutter/utils/values/sizes.dart';
// import 'package:food_delivery_flutter/utils/values/values.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: themeData.backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(MySize.size8!)),
            border: Border.all(color: themeData.colorScheme.surface, width: 1),
            boxShadow: [
              BoxShadow(
                color: themeData.cardTheme.shadowColor!.withAlpha(12),
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          margin: EdgeInsets.only(
              top: MySize.size48!, left: MySize.size16!, right: MySize.size16!),
          padding: EdgeInsets.all(MySize.size16!),
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(MySize.size8!)),
                child: Image.asset(
                  "./assets/images/avatar-2.jpg",
                  height: MySize.getScaledSizeHeight(90),
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: MySize.size16!),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Milton Garcia",
                        style: AppTheme.getTextStyle(
                            themeData.textTheme.headline6,
                            fontWeight: 600,
                            letterSpacing: 0)),
                    Text("mile@gmail.com",
                        style: AppTheme.getTextStyle(
                            themeData.textTheme.bodyText1,
                            fontWeight: 400,
                            letterSpacing: 0.2)),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: MySize.size16!),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: themeData.backgroundColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(MySize.size8!)),
                  border: Border.all(
                      color: themeData.colorScheme.surface, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: themeData.cardTheme.shadowColor!.withAlpha(12),
                      blurRadius: 2,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                margin: EdgeInsets.only(
                    top: MySize.size32!,
                    left: MySize.size16!,
                    right: MySize.size16!),
                padding: EdgeInsets.only(
                    top: MySize.size12!,
                    bottom: MySize.size16!,
                    left: MySize.size16!,
                    right: MySize.size16!),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Text("My Information",
                            style: AppTheme.getTextStyle(
                                themeData.textTheme.subtitle1,
                                fontWeight: 500)),
                      ),
                    ),
                    Container(
                      child: Icon(Icons.arrow_back_ios,
                          size: MySize.size24,
                          color: themeData.colorScheme.onBackground),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: themeData.backgroundColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(MySize.size8!)),
                  border: Border.all(
                      color: themeData.colorScheme.surface, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: themeData.cardTheme.shadowColor!.withAlpha(12),
                      blurRadius: 2,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                margin: EdgeInsets.only(
                    top: MySize.size16!,
                    left: MySize.size16!,
                    right: MySize.size16!),
                padding: EdgeInsets.all(MySize.size16!),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Text("My Booking",
                            style: AppTheme.getTextStyle(
                                themeData.textTheme.subtitle1,
                                fontWeight: 500)),
                      ),
                    ),
                    Container(
                      child: Icon(Icons.arrow_back_ios,
                          size: 24, color: themeData.colorScheme.onBackground),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: themeData.backgroundColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(MySize.size8!)),
                  border: Border.all(
                      color: themeData.colorScheme.surface, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: themeData.cardTheme.shadowColor!.withAlpha(12),
                      blurRadius: 2,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                margin: EdgeInsets.only(
                    top: MySize.size16!,
                    left: MySize.size16!,
                    right: MySize.size16!),
                padding: EdgeInsets.all(MySize.size16!),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Text("Payment Method",
                            style: AppTheme.getTextStyle(
                                themeData.textTheme.subtitle1,
                                fontWeight: 500)),
                      ),
                    ),
                    Container(
                      child: Icon(Icons.arrow_back_ios,
                          size: MySize.size24,
                          color: themeData.colorScheme.onBackground),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: themeData.backgroundColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(MySize.size8!)),
                  border: Border.all(
                      color: themeData.colorScheme.surface, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: themeData.cardTheme.shadowColor!.withAlpha(12),
                      blurRadius: 2,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                margin: EdgeInsets.only(
                    top: MySize.size16!,
                    left: MySize.size16!,
                    right: MySize.size16!),
                padding: EdgeInsets.all(MySize.size16!),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Text("Setting",
                            style: AppTheme.getTextStyle(
                                themeData.textTheme.subtitle1,
                                fontWeight: 500)),
                      ),
                    ),
                    Container(
                      child: Icon(Icons.arrow_back_ios,
                          size: MySize.size24,
                          color: themeData.colorScheme.onBackground),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: themeData.backgroundColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(MySize.size8!)),
                  border: Border.all(
                      color: themeData.colorScheme.surface, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: themeData.cardTheme.shadowColor!.withAlpha(12),
                      blurRadius: 2,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                margin: EdgeInsets.only(
                    top: MySize.size16!,
                    left: MySize.size16!,
                    right: MySize.size16!),
                padding: EdgeInsets.all(MySize.size16!),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Text("Logout",
                            style: AppTheme.getTextStyle(
                                themeData.textTheme.subtitle1,
                                fontWeight: 600)),
                      ),
                    ),
                    Container(
                      child: Icon(Icons.arrow_back_ios,
                          size: 24, color: themeData.colorScheme.onBackground),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

// Widget _buildAccountSettings({required BuildContext context}) {
//   var textTheme = Theme.of(context).textTheme;
//   return Container(
//     child: Column(
//       children: <Widget>[
//         Container(
//           color: AppColors.secondaryColor,
//           padding: const EdgeInsets.symmetric(
//             horizontal: Sizes.MARGIN_16,
//             vertical: Sizes.MARGIN_16,
//           ),
//           child: Row(
//             children: <Widget>[
//               Text(
//                 "Account",
//                 style: textTheme.title!.copyWith(
//                   fontSize: Sizes.TEXT_SIZE_20,
//                   color: AppColors.indigoShade1,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         ListView(
//           shrinkWrap: true,
//           children: ListTile.divideTiles(
//             context: context,
//             tiles: <Widget>[
//               SettingsListTile(
//                 title: "Change Password",
//                 // onTap: () => AppRouter.navigator
//                 //     .pushNamed(AppRouter.changePasswordScreen),
//               ),
//               SettingsListTile(
//                 title: "Change Language",
//                 // onTap: () => AppRouter.navigator
//                 //     .pushNamed(AppRouter.changeLanguageScreen),
//               )
//             ],
//           ).toList(),
//         )
//       ],
//     ),
//   );
// }

// Widget _buildOtherSettings({required BuildContext context}) {
//   var textTheme = Theme.of(context).textTheme;
//   return Container(
//     child: Column(
//       children: <Widget>[
//         Container(
//           color: AppColors.secondaryColor,
//           padding: const EdgeInsets.symmetric(
//             horizontal: Sizes.MARGIN_16,
//             vertical: Sizes.MARGIN_16,
//           ),
//           child: Row(
//             children: <Widget>[
//               Text(
//                 "Others",
//                 style: textTheme.title!.copyWith(
//                   fontSize: Sizes.TEXT_SIZE_20,
//                   color: AppColors.indigoShade1,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         ListView(
//           shrinkWrap: true,
//           children: ListTile.divideTiles(
//             context: context,
//             tiles: <Widget>[
//               SettingsListTile(
//                 title: "Privacy Policy",
//                 onTap: () {},
//               ),
//               SettingsListTile(
//                 title: "Terms & Conditions",
//                 onTap: () {},
//               ),
//               SettingsListTile(
//                 title: "Logout",
//                 titleColor: AppColors.secondaryElement,
//                 hasTrailing: false,
//                 onTap: () => _logoutDialog(context),
//               ),
//             ],
//           ).toList(),
//         ),
//       ],
//     ),
//   );
// }

// Future<void> _logoutDialog(BuildContext context) async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return _buildAlertDialog(context);
//     },
//   );
// }

// Widget _buildAlertDialog(BuildContext context) {
//   var textTheme = Theme.of(context).textTheme;
//   return Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.all(
//         Radius.circular(Sizes.RADIUS_32),
//       ),
//     ),
//     child: AlertDialog(
//       contentPadding: EdgeInsets.fromLTRB(
//         Sizes.PADDING_0,
//         Sizes.PADDING_36,
//         Sizes.PADDING_0,
//         Sizes.PADDING_0,
//       ),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(Sizes.RADIUS_20),
//       ),
//       elevation: Sizes.ELEVATION_4,
//       content: Container(
//         height: Sizes.HEIGHT_150,
//         width: Sizes.WIDTH_300,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             SingleChildScrollView(
//               child: Center(
//                 child: Text(
//                   'Are you sure you want to Logout ?',
//                   style: textTheme.title!.copyWith(
//                     fontSize: Sizes.TEXT_SIZE_20,
//                   ),
//                 ),
//               ),
//             ),
//             Spacer(flex: 1),
//             Row(
//               children: <Widget>[
//                 AlertDialogButton(
//                   buttonText: "No",
//                   width: Sizes.WIDTH_150,
//                   border: Border(
//                     top: BorderSide(
//                       width: 1,
//                       color: AppColors.greyShade1,
//                     ),
//                     right: BorderSide(
//                       width: 1,
//                       color: AppColors.greyShade1,
//                     ),
//                   ),
//                   textStyle:
//                       textTheme.button!.copyWith(color: AppColors.accentText),
//                   onPressed: () => Navigator.of(context).pop(),
//                 ),
//                 AlertDialogButton(
//                   buttonText: "Yes",
//                   width: Sizes.WIDTH_150,
//                   border: Border(
//                     top: BorderSide(
//                       width: 1,
//                       color: AppColors.greyShade1,
//                     ),
//                   ),
//                   textStyle: textTheme.button!
//                       .copyWith(color: AppColors.secondaryElement),
//                   // onPressed: () =>
//                   //     AppRouter.navigator.pushNamedAndRemoveUntil(
//                   //   AppRouter.loginScreen,
//                   //   (Route<dynamic> route) => false,
//                   // ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }

// class SettingsListTile extends StatelessWidget {
//   SettingsListTile({
//     required this.title,
//     this.titleColor = AppColors.primaryText,
//     this.iconData = Icons.arrow_forward_ios,
//     this.onTap,
//     this.hasTrailing = true,
//   });

//   final String title;
//   final Color titleColor;
//   final IconData iconData;
//   final GestureTapCallback? onTap;
//   final bool hasTrailing;

//   @override
//   Widget build(BuildContext context) {
//     var textTheme = Theme.of(context).textTheme;

//     return InkWell(
//       onTap: onTap,
//       child: ListTile(
//         contentPadding: const EdgeInsets.symmetric(
//             vertical: Sizes.PADDING_4, horizontal: Sizes.PADDING_16),
//         title: Container(
//           margin: const EdgeInsets.only(bottom: Sizes.MARGIN_8),
//           child: Text(
//             title,
//             style: textTheme.title!
//                 .copyWith(fontSize: Sizes.TEXT_SIZE_20, color: titleColor),
//           ),
//         ),
//         trailing: hasTrailing ? Icon(iconData, color: AppColors.indigo) : null,
//       ),
//     );
//   }
// }

// class AlertDialogButton extends StatelessWidget {
//   AlertDialogButton({
//     required this.buttonText,
//     this.textStyle,
//     this.border,
//     this.width,
//     this.onPressed,
//   });

//   final TextStyle? textStyle;
//   final String buttonText;
//   final VoidCallback? onPressed;
//   final Border? border;
//   final double? width;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       decoration: BoxDecoration(
//         border: border,
//       ),
//       child: FlatButton(
//         child: Text(
//           buttonText,
//           style: textStyle,
//         ),
//         onPressed: onPressed,
//       ),
//     );
//   }
// }

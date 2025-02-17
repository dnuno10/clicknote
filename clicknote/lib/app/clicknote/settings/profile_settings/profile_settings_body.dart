import 'package:clicknote/app/clicknote/class/main_user.dart';
import 'package:clicknote/app/clicknote/settings/profile_settings/profile_settings_footer.dart';
import 'package:clicknote/app/clicknote/settings/translations_settings.dart';
import 'package:clicknote/app/elements/button.dart';
import 'package:clicknote/app/elements/text_field_default.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileSettingsBody extends StatefulWidget {
  const ProfileSettingsBody({super.key});

  @override
  State<ProfileSettingsBody> createState() => _ProfileSettingsBodyState();
}

class _ProfileSettingsBodyState extends State<ProfileSettingsBody> {
  // ignore: non_constant_identifier_names
  late FocusNode node_name;
  // ignore: non_constant_identifier_names
  late TextEditingController controller_name;

  @override
  void initState() {
    node_name = FocusNode();
    final mainUser = Provider.of<MainUser>(context, listen: false);
    controller_name = TextEditingController(text: mainUser.name);
    super.initState();
  }

  @override
  void dispose() {
    node_name.dispose;
    controller_name.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
          TextFieldDefault(labelText: TranslationsSettings.translate(context, 'full_name'), controller: controller_name, focusNode: node_name),
          SizedBox(height: size.height * 0.02,),
          Button(text: TranslationsSettings.translate(context, 'update_profile'), width: size.width * 0.9, onPressed: (){Navigator.pushNamed(context, '/profile_settings_logic', arguments: {'name' : controller_name.text});}, color: const Color(0xFFaa3bff), fontColor: Colors.white,),
          SizedBox(height: size.height * 0.06,),
          //delete account
          ProfileSettingsFooter(onPressed: (){})
        ],);
  }
}

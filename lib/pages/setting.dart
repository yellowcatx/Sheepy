import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sheep/theme/theme_provinder.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(
        IconlyBroken.heart,
        color: Color.fromRGBO(209, 131, 78, 1),
      ),
      title: Text('Configurações', style: GoogleFonts.spaceMono(fontSize: 15)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                'Modo Noturno',
                style: GoogleFonts.spaceMono(),
              ),
              Spacer(), // Espaço flexível para alinhar o switch à direita
              CupertinoSwitch(
                activeColor: Color.fromRGBO(180, 216, 160, 1),
                value: Provider.of<ThemeProvider>(context, listen: false)
                    .isDarkMode,
                onChanged: (value) =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme(),
              ),
            ],
          ),
          Divider(color: Color.fromARGB(62, 158, 158, 158)),
          // Outros widgets...
        ],
      ),
    );
  }
}

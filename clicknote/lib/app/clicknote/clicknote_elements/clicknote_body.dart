import 'dart:ui';

import 'package:clicknote/app/clicknote/class/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ClickNoteBody extends StatefulWidget {
  const ClickNoteBody({super.key});

  @override
  State<ClickNoteBody> createState() => _ClickNoteBodyState();
}

class _ClickNoteBodyState extends State<ClickNoteBody> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<Note> sampleNotes = [
  Note(
    title: "Flutter Navigation",
    description: "Understanding how to use Navigator and routes in Flutter for seamless screen transitions.",
    date: "Feb 16, 2025",
  ),
  Note(
    title: "State Management",
    description: "Comparing Provider, Riverpod, and Bloc for handling global and local state efficiently.",
    date: "Feb 15, 2025",
  ),
  Note(
    title: "Database Integration",
    description: "Exploring SQLite and Hive for local storage solutions and persistent data in Flutter apps.",
    date: "Feb 14, 2025",
  ),
  Note(
    title: "Animations in Flutter",
    description: "Creating smooth and interactive UI animations using AnimatedBuilder, Hero, and Lottie.",
    date: "Feb 13, 2025",
  ),
  Note(
    title: "REST API Integration",
    description: "Implementing HTTP requests with Dio and http package for consuming REST APIs efficiently.",
    date: "Feb 12, 2025",
  ),
  Note(
    title: "Flutter for Web",
    description: "Building responsive web applications using Flutter and integrating Firebase for backend services.",
    date: "Feb 11, 2025",
  ),
  Note(
    title: "Using Firebase Firestore",
    description: "Storing and retrieving real-time data with Firebase Firestore and synchronizing across devices.",
    date: "Feb 10, 2025",
  ),
  Note(
    title: "Theming & Dark Mode",
    description: "Creating adaptive themes and implementing light/dark mode toggles for a better user experience.",
    date: "Feb 9, 2025",
  ),
  Note(
    title: "Performance Optimization",
    description: "Optimizing Flutter apps using efficient rendering techniques, lazy loading, and Isolates.",
    date: "Feb 8, 2025",
  ),
  Note(
    title: "Testing in Flutter",
    description: "Writing unit, widget, and integration tests using Flutter's testing framework to ensure app stability.",
    date: "Feb 7, 2025",
  ),
];


    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [              
              // Pro button
              //proButton(size),
              SizedBox(height: size.height * 0.01),
              // Notes
              SizedBox(
              height: size.height * 0.82,
              width: size.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Lista principal
                  SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.02, // Padding al inicio (parte superior)
                      bottom: size.height * 0.12, // Padding al final (parte inferior)
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.center, // Centra horizontalmente los elementos
                      spacing: size.width * 0.035, // Espaciado horizontal entre elementos
                      runSpacing: size.height * 0.02, // Espaciado vertical entre filas
                      children: List.generate(
                        sampleNotes.length,
                        (index) => SizedBox(
                          width: size.width * 0.45, // Ancho de cada elemento
                          child: myNotes(size, index: index, note: sampleNotes[index]),
                        ),
                      ),
                    ),
                  ),
                ),

              // Degradado superior
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: Container(
                    height: size.height * 0.05, // Altura del degradado superior
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).scaffoldBackgroundColor, // Color del degradado (ajustable)
                          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0),
                        ]
                      ),
                    ),
                  ),
                ),
              ),
              // Degradado inferior
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: Container(
                    height: size.height * 0.05, // Altura del degradado inferior
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Theme.of(context).scaffoldBackgroundColor, // Color del degradado (ajustable)
                          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(bottom: size.height * 0.02, child: Wrap(
  children: [
    GestureDetector(
  onTap: () {
    _showOptionsModal(context);
  },
  child: Container(
    padding: EdgeInsets.all(size.height * 0.018),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({}),
      border: Border.all(
        color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({})?.withOpacity(0.1) ?? Colors.white.withOpacity(0.1),
        width: 1,
      ),
    ),
    child: Center(
      child: Text(
        "New Note",
        textAlign: TextAlign.center,
        style: GoogleFonts.ibmPlexMono(
          color: Theme.of(context).cardColor,
          fontSize: size.height * 0.02,
        ),
      ),
    ),
  ),
)

  ],
)
,)
              /*Positioned(bottom: size.height * 0.02, child: SizedBox(width: size.width,child: Center(child: Container(
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(
                        context,
                        '/texteditor',
                        arguments: "note",
                      );
                    },
                    child: icons(Icons.note_add)),
                  SizedBox(width: size.width * 0.03,),
                  GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context,
                        '/texteditor',
                        arguments: "gallery",
                      );
                  },
                  child: icons(Icons.photo_library),
                ),
                  SizedBox(width: size.width * 0.03,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/texteditor',
                        arguments: "camera",
                      );

                    },
                    child: icons(Icons.camera),
                  ),

                ],),
              ),),))*/
            ],
          ),
        ),
            
            ],
          ),
    );
  }
  Widget icons(IconData icon) {
  final size = MediaQuery.of(context).size;
  
  return Stack(
    alignment: Alignment.center,
    children: [
      // Fondo con sombra
      ClipRRect(
    borderRadius: BorderRadius.circular(size.height * 0.085), // Bordes redondeados para evitar artefactos
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Aplica desenfoque
      child: Container(
        width: size.height * 0.085, // Ajusta el tamaño del fondo
        height: size.height * 0.085,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context)
              .elevatedButtonTheme
              .style
              ?.foregroundColor
              ?.resolve({})
              ?.withOpacity(0.2), // Fondo semitransparente
        ),
      ),
    ),
  ),
      // Contenedor del ícono con borde
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({}), // Color de fondo
          border: Border.all(
            color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({})?.withOpacity(0.1) ?? Colors.white.withOpacity(0.1),
            width: 1,
          ),
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(size.height * 0.018),
        child: Icon(
          icon,
          color: Theme.of(context).scaffoldBackgroundColor,
          size: size.height * 0.035,
        ),
      ),
    ],
  );
}


  // Hashtags
  Widget hashtags() {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({}),
        borderRadius: BorderRadius.circular(size.height * 0.2),
      ),
      padding: EdgeInsets.only(
        left: size.width * 0.023,
        right: size.width * 0.002,
        top: size.height * 0.002,
        bottom: size.height * 0.002
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '#All notes',
            style: GoogleFonts.poppins(
              fontSize: size.height * 0.019,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          SizedBox(width: size.width * 0.02,),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              shape: BoxShape.circle
            ),
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: size.height * 0.008,
            ),
            child: Center(
              child: Text(
                '1',
                style: GoogleFonts.ibmPlexMono(
                  fontSize: size.height * 0.025,
                  color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({}),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Pro button
  Widget proButton(Size size) {
    return Container(
      width: size.width * 0.8,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFaa3bff), Color(0xFFCA16CD)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.circular(size.height * 0.022),
      ),
      child: Padding(
        padding: EdgeInsets.all(size.height * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Image.asset('images/diamond.png', height: size.height * 0.025, color: Theme.of(context).canvasColor,),
            SizedBox(width: size.width * 0.02,),
            Text(
              'Get ClickNote Pro',
              style: GoogleFonts.poppins(
                fontSize: size.height * 0.019,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            ],),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: size.height * 0.021,
            ),
          ],
        ),
      ),
    );
  }



  // Notes
  Widget myNotes(Size size, {required Note note, int index = 0}) {
  final List<Color> noteColors = [
    Colors.redAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.orangeAccent,
    Colors.purpleAccent,
    Colors.pinkAccent,
    Colors.tealAccent,
    Colors.amberAccent,
    Colors.cyanAccent,
    Colors.indigoAccent,
  ];

  final Color noteColor = noteColors[index % noteColors.length];

  return Stack(
    children: [
      Positioned(
        left: 0,
        top: 0,
        bottom: 0,
        child: Container(
          width: size.width * 0.02,
          decoration: BoxDecoration(
            color: noteColor.withOpacity(0.8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(size.height * 0.03),
              bottomLeft: Radius.circular(size.height * 0.03),
            ),
          ),
        ),
      ),
      Container(
        width: size.width * 0.45,
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor.withAlpha(10),
          borderRadius: BorderRadius.circular(size.height * 0.03),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.025,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    note.title,
                    style: GoogleFonts.ibmPlexMono(
                      fontSize: size.height * 0.022,
                      color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({}),
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              note.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: size.height * 0.018,
                color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({})?.withOpacity(0.5),
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: size.height * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  note.date,
                  style: GoogleFonts.golosText(
                    fontSize: size.height * 0.016,
                    color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({})?.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(size.height * 0.012),
                  child: Center(
                    child: Icon(Icons.arrow_forward_ios_rounded, size:size.height * 0.025, color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({}),)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}


  
  // Hashtags
  // ignore: non_constant_identifier_names
  Widget hashtags_notes() {
    final size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
                      
                        baseColor: Color(0XFFf578ff),
                        highlightColor: Color(0XFFfe3e68).withOpacity(0.7),
                        child: Container(
                          decoration: BoxDecoration(
                            //color: texto.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text("#All notes", style: GoogleFonts.getFont(
                                  "IBM Plex Mono",
                                  color: Colors.white,
                                  fontSize: size.height * 0.017,
                                  fontWeight: FontWeight.w500,
                                ),),
                          ),),
                      );
  }

  // ignore: non_constant_identifier_names
  Widget icon_note({required String icon, required String text}){
    final size = MediaQuery.of(context).size;
    return SizedBox(
            width: size.width * 0.25,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.02,),
                  SvgPicture.asset(
                      icon,
                      height: size.height * 0.03,
                      // ignore: deprecated_member_use
                      color: Theme.of(context).cardColor,
                ),
                SizedBox(height: size.height * 0.005,),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).cardColor,
                      fontSize: size.height * 0.016,
                    ),
                  ),
                ],
              ),
          );}}


void _showOptionsModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    builder: (context) {
      Size size = MediaQuery.of(context).size;
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Barra superior de modal
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({})?.withAlpha(40),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            // Título
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "New Note",
                  style: GoogleFonts.ibmPlexMono(
                    fontSize: size.height * 0.023,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({}),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({})),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Opciones de la lista
            /*_modalOption(
              context,
              icon: Icons.mic,
              label: "Grabar audio",
              onTap: () => _navigate(context, "record_audio"),
            ),*/
            _modalOption(
              context,
              icon: Icons.camera,
              label: "From Camera",
              onTap: () => _navigate(context, "camera"),
            ),
            _modalOption(
              context,
              icon: Icons.photo,
              label: "From Gallery",
              onTap: () => _navigate(context, "gallery"),
            ),
            _modalOption(
              context,
              icon: Icons.text_fields,
              label: "From text",
              onTap: () => _navigate(context, "note"),
            ),
            /*_modalOption(
              context,
              icon: Icons.link,
              label: "Usar un enlace web",
              subtitle: "YouTube, sitios web, Google Drive",
              onTap: () => _navigate(context, "use_link"),
            ),*/
            SizedBox(height: size.height * 0.03),
          ],
        ),
      );
    },
  );
}

void _navigate(BuildContext context, String type) {
  Navigator.pushNamed(context, '/texteditor', arguments: type);
}


Widget _modalOption(
  BuildContext context, {
  required IconData icon,
  required String label,
  String? subtitle,
  required VoidCallback onTap,
}) {
  Size size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: () {
      Navigator.pop(context); // Cierra el modal antes de navegar
      onTap();
    },
    child: Container(
      padding: EdgeInsets.all(size.height * 0.019),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({})?.withAlpha(10),
        borderRadius: BorderRadius.circular(size.height * 0.02),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: Icon(icon, color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({}), size: size.height * 0.024),
              ),
              SizedBox(width: 15),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.poppins(
                        fontSize: size.height * 0.018,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({}),
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                  ],
                ),
            ],
          ),
          Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(size.height * 0.012),
                  child: Center(
                    child: Icon(Icons.arrow_forward_ios_rounded, size:size.height * 0.025, color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({}),)
                  ),
                ),
        ],
      ),
    ),
  );
}

// texteditor_view.dart
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data'; // Para Uint8List
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/quill_delta.dart' as quill;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
// ignore: implementation_imports
import 'package:flutter_quill_extensions/src/editor_toolbar_shared/image_picker/image_options.dart' as quill;
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img; // Para la compresión
// ignore: depend_on_referenced_packages
import 'package:markdown/markdown.dart' as md; // Para convertir Markdown a Delta

/// TextEditorView: Permite insertar imágenes y, al generar, inserta la respuesta del bot.
/// Además, renderiza el texto con estilos (usando conversión Markdown → Delta)
/// y muestra una toolbar personalizada justo arriba del teclado.
class TextEditorView extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final String note_type;

  const TextEditorView({
    super.key,
    // ignore: non_constant_identifier_names
    required this.note_type,
  });

  @override
  State<TextEditorView> createState() => _TextEditorViewState();
}

class _TextEditorViewState extends State<TextEditorView> {
  late quill.QuillController _controller;
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  // Para detectar si el teclado está visible y mostrar/ocultar el ícono correspondiente.
  ValueNotifier<bool> _isKeyboardVisible = ValueNotifier(false);

  // Para guardar la URL de la última imagen insertada.
  String? _lastImageUrl;

  // Parámetros del API (ajusta según tu caso)
  final String apiUrl =
      "https://th3sp3ci4lw0rkl0w.com/api/v1/prediction/799a58ba-75e9-45a0-acfc-a1201b9a686e";
  final String authorization =
      "HfnHCgbGEhbmYcDTmxXguWLT4LsGMLYg4U5vXRib2SM";

  // Estado de carga para el proceso de generación.
  String _errorMessage = "";


  @override
  void initState() {
    super.initState();
    // Inicializamos el controlador básico.
    _controller = quill.QuillController.basic();

    if (widget.note_type == 'gallery') {
      _onPressedGallery(context);
    } else if (widget.note_type == 'camera') {
      _onPressedCamera(context);
    } else {
      // ignore: avoid_print
      print("normal note");
    }
  }

  Future<void> _onPressedGallery(BuildContext context) async {
    _isKeyboardVisible = ValueNotifier(true);
    await Future.delayed(const Duration(milliseconds: 100));

    // ignore: use_build_context_synchronously
    final imagePickerService = QuillSharedExtensionsConfigurations.get(context: context).imagePickerService;

    // Se selecciona directamente la galería sin opción de diálogo
    String? imageUrl = (await imagePickerService.pickImage(source: quill.ImageSource.gallery))?.path;

    if (imageUrl == null || imageUrl.trim().isEmpty) return;

    // ignore: use_build_context_synchronously
    FocusScope.of(context).unfocus();

    // Guardamos la URL para su uso posterior.
    _lastImageUrl = imageUrl;

    // Insertamos la imagen en el editor de texto.
    _controller.insertImageBlock(imageSource: imageUrl);
    _controller.moveCursorToPosition(_controller.document.length);
    _controller.replaceText(_controller.selection.baseOffset, 0, "\n", null);
  // Generamos la respuesta automáticamente.
  await _generateResponse();
}

Future<void> _onPressedCamera(BuildContext context) async {
    _isKeyboardVisible = ValueNotifier(true);
    await Future.delayed(const Duration(milliseconds: 100));

    // ignore: use_build_context_synchronously
    final imagePickerService = QuillSharedExtensionsConfigurations.get(context: context).imagePickerService;

    // Se selecciona directamente la galería sin opción de diálogo
    String? imageUrl = (await imagePickerService.pickImage(source: quill.ImageSource.camera))?.path;

    if (imageUrl == null || imageUrl.trim().isEmpty) return;

    // ignore: use_build_context_synchronously
    FocusScope.of(context).unfocus();

    // Guardamos la URL para su uso posterior.
    _lastImageUrl = imageUrl;

    // Insertamos la imagen en el editor de texto.
    _controller.insertImageBlock(imageSource: imageUrl);
    _controller.moveCursorToPosition(_controller.document.length);
    _controller.replaceText(_controller.selection.baseOffset, 0, "\n", null);
  // Generamos la respuesta automáticamente.
  await _generateResponse();
}


  /// Función nativa para insertar imagen usando el picker de Quill.
  Future<void> _onPressedHandler(BuildContext context) async {
    // Forzamos el ocultamiento del teclado y esperamos brevemente.
    FocusScope.of(context).unfocus();
    await Future.delayed(const Duration(milliseconds: 100));

    // ignore: use_build_context_synchronously
    final imagePickerService = QuillSharedExtensionsConfigurations.get(context: context).imagePickerService;
    // ignore: use_build_context_synchronously
    final source = await showSelectImageSourceDialog(context: context);
    if (source == null) return;
    
    String? imageUrl;
    switch (source) {
      case InsertImageSource.gallery:
        imageUrl = (await imagePickerService.pickImage(source: quill.ImageSource.gallery))?.path;
        break;
      case InsertImageSource.camera:
        imageUrl = (await imagePickerService.pickImage(source: quill.ImageSource.camera))?.path;
        break;
      case InsertImageSource.link:
        // ignore: use_build_context_synchronously
        imageUrl = await _typeLink(context);
        break;
    }
    if (imageUrl == null || imageUrl.trim().isEmpty) return;
    // ignore: use_build_context_synchronously
    FocusScope.of(context).unfocus();

    // Guardamos la URL para usarla luego en la generación.
    _lastImageUrl = imageUrl;

    // Insertamos la imagen usando el método nativo. 
    _controller.insertImageBlock(imageSource: imageUrl);
    _controller.moveCursorToPosition(_controller.document.length);
    _controller.replaceText(_controller.selection.baseOffset, 0, "\n", null);

    // Llamamos automáticamente a la función para generar la respuesta del bot.
    await _generateResponse();
  }

  /// Solicita al usuario una URL para insertar una imagen vía link.
  Future<String?> _typeLink(BuildContext context) async {
    String? input;
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: const Text("Insert Image Link"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Enter image URL"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                input = controller.text;
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
    return input;
  }

  /// Función para llamar al API usando la imagen insertada y generar la respuesta del bot.
  /// La respuesta se insertará debajo de la imagen en el mismo editor.
  Future<void> _generateResponse() async {
    // ignore: avoid_print
    print('hello');
    if (_lastImageUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please insert an image first.")),
      );
      return;
    }
    setState(() {
      _errorMessage = "";
    });
    try {
      // Leemos el archivo de la última imagen.
      final file = File(_lastImageUrl!);
      final bytes = await file.readAsBytes();

      // Comprimimos la imagen utilizando la lógica de compresión con el paquete 'image'
      final compressedBytes = _processImage(bytes);

      // Convertimos la imagen comprimida a data URI (en formato JPEG)
      final dataUri = "data:image/jpeg;base64,${base64Encode(compressedBytes)}";

      // Preparamos el payload para el API.
      final imageUploads = [
        {
          'data': dataUri,
          'type': 'file',
          'name': 'user_image.jpg',
          'mime': 'image/jpeg',
        }
      ];
      final payload = {
        'question': "Analyze this image or images, please. Only answer with the image analisis.",
        'overrideConfig': {'returnSourceDocuments': true},
        'uploads': imageUploads,
      };
      final headers = {
        'Authorization': authorization,
        'Content-Type': 'application/json',
      };
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        final botResponse = responseJson['text'] ?? "No response from bot";
        // ignore: avoid_print
        print(botResponse);

        // Obtenemos la longitud actual del documento.
        // Usamos docLength - 1 para obtener un índice válido (Quill siempre termina con un salto de línea)
        final docLength = _controller.document.length;
        final insertionIndex = docLength > 0 ? docLength - 1 : 0;

        // Actualizamos la selección para posicionar el cursor en insertionIndex.
        _controller.updateSelection(
          TextSelection.collapsed(offset: insertionIndex),
          quill.ChangeSource.remote,
        );

        // Convertimos la respuesta del bot (Markdown) a Delta.
        final deltaResponse = convertMarkdownToDelta(botResponse);

        // Construimos un Delta que retenga hasta insertionIndex e inserte dos saltos de línea.
        final patchDelta = quill.Delta()
          ..retain(insertionIndex)
          ..insert("\n\n");

        // Concatenamos el patch con el Delta de la respuesta.
        final combinedDelta = patchDelta.concat(deltaResponse);

        // Componemos (aplicamos) el Delta combinado al documento.
        _controller.document.compose(combinedDelta, quill.ChangeSource.remote);
      } else {
        setState(() {
          _errorMessage = "Error: ${response.statusCode} => ${response.body}";
          // ignore: avoid_print
          print(_errorMessage);
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Exception: $e";
        // ignore: avoid_print
        print(_errorMessage);
      });
    } finally {
      setState(() {
      });
    }
  }

  /// Función auxiliar que procesa (redimensiona y comprime) la imagen.
  /// Utiliza el paquete 'image' para:
  /// - Decodificar la imagen original.
  /// - Redimensionarla si su ancho o alto superan 1280 píxeles.
  /// - Reencodearla en formato JPEG con una calidad del 80%.
  Uint8List _processImage(Uint8List inputBytes) {
    final img.Image? original = img.decodeImage(inputBytes);
    if (original == null) {
      // ignore: avoid_print
      print('Could not decode image. Returning original bytes.');
      return inputBytes;
    }
    const maxDimension = 1280;
    final width = original.width;
    final height = original.height;

    bool needsResize = width > maxDimension || height > maxDimension;
    img.Image finalImage = original;
    if (needsResize) {
      if (width > height) {
        finalImage = img.copyResize(original, width: maxDimension);
      } else {
        finalImage = img.copyResize(original, height: maxDimension);
      }
    }

    final jpgBytes = img.encodeJpg(finalImage, quality: 80);
    return Uint8List.fromList(jpgBytes);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    _isKeyboardVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // Permite que la pantalla se redimensione cuando aparece el teclado.
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Text Editor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: () async {
              await _onPressedHandler(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Área del editor: se expande y ocupa el espacio restante.
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: quill.QuillEditor.basic(
                controller: _controller,
                scrollController: _scrollController,
                focusNode: _focusNode,
                configurations: quill.QuillEditorConfigurations(
                  scrollable: true,
                  autoFocus: false,
                  expands: true,
                  padding: EdgeInsets.zero,
                  embedBuilders: FlutterQuillEmbeds.editorBuilders(),
                ),
              ),
            ),
          ),
        ],
      ),
      // La toolbar se posiciona siempre justo arriba del teclado.
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          color: Theme.of(context).secondaryHeaderColor,
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                Expanded(
                  child: quill.QuillToolbar.simple(
                    controller: _controller,
                    configurations: quill.QuillSimpleToolbarConfigurations(
                      color: Theme.of(context).secondaryHeaderColor,
                      multiRowsDisplay: false,
                      showBoldButton: true,
                      showItalicButton: true,
                      showUnderLineButton: true,
                      showStrikeThrough: true,
                      showListNumbers: true,
                      showListBullets: true,
                      showListCheck: true,
                      showHeaderStyle: true,
                      showClearFormat: false,
                      embedButtons: FlutterQuillEmbeds.toolbarButtons(),
                    ),
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: _isKeyboardVisible,
                  builder: (context, isKeyboardVisible, child) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          if (isKeyboardVisible) {
                            FocusScope.of(context).unfocus();
                          } else {
                            _focusNode.requestFocus();
                          }
                        },
                        icon: Icon(
                          isKeyboardVisible ? Icons.keyboard_hide : Icons.keyboard,
                          size: size.height * 0.035,
                          color: Theme.of(context)
                                  .elevatedButtonTheme
                                  .style
                                  ?.foregroundColor
                                  ?.resolve({}) ??
                              Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// --------------------------------------------------------------------------
/// Función para convertir un string Markdown a un Quill Delta.
/// (Se procesan: headings, bold, italic, listas, código, blockquote, imágenes, párrafos, etc.)
/// --------------------------------------------------------------------------
quill.Delta convertMarkdownToDelta(String markdown) {
  final document = md.Document();
  final parsedLines = document.parseLines(markdown.split('\n'));
  final delta = quill.Delta();

  for (final line in parsedLines) {
    if (line is md.Element) {
      switch (line.tag) {
        case 'h1':
          delta.insert('${line.textContent}\n', {'header': 1});
          break;
        case 'h2':
          delta.insert('${line.textContent}\n', {'header': 2});
          break;
        case 'h3':
          delta.insert('${line.textContent}\n', {'header': 3});
          break;
        case 'strong':
          delta.insert(line.textContent, {'bold': true});
          break;
        case 'em':
          delta.insert(line.textContent, {'italic': true});
          break;
        case 'ul':
          for (final item in line.children ?? []) {
            delta.insert('${item.textContent}\n', {'list': 'bullet'});
          }
          break;
        case 'ol':
          for (final item in line.children ?? []) {
            delta.insert('${item.textContent}\n', {'list': 'ordered'});
          }
          break;
        case 'li':
          delta.insert('${line.textContent}\n');
          break;
        case 'code':
          delta.insert('${line.textContent}\n', {'code-block': true});
          break;
        case 'blockquote':
          delta.insert('${line.textContent}\n', {'blockquote': true});
          break;
        case 'img':
          final imageSource = line.attributes['src'] ?? '';
          if (imageSource.startsWith('data:image')) {
            delta.insert(quill.BlockEmbed.image(imageSource));
            delta.insert('\n');
          } else {
            delta.insert({'image': imageSource});
          }
          break;
        case 'p':
          final children = line.children ?? [];
          if (children.length == 1 && children.first is md.Element) {
            final onlyChild = children.first as md.Element;
            if (onlyChild.tag == 'img') {
              final imageSource = onlyChild.attributes['src'] ?? '';
              delta.insert({'image': imageSource});
              delta.insert('\n');
              break;
            }
          }
          for (final sub in children) {
            if (sub is md.Element && sub.tag == 'img') {
              final imageSource = sub.attributes['src'] ?? '';
              delta.insert({'image': imageSource});
              delta.insert('\n');
            } else {
              delta.insert(sub.textContent);
            }
          }
          delta.insert('\n');
          break;
        default:
          delta.insert('${line.textContent}\n');
      }
    } else if (line is md.Text) {
      delta.insert('${line.text}\n');
    } else {
      delta.insert('$line\n');
    }
  }
  return delta;
}

/// --------------------------------------------------------------------------
/// Diálogo para seleccionar la fuente de imagen (galería, cámara o link).
/// --------------------------------------------------------------------------
Future<InsertImageSource?> showSelectImageSourceDialog({
  required BuildContext context,
}) async {
  return showDialog<InsertImageSource>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Select Image Source"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Gallery"),
              onTap: () {
                // Oculta el teclado antes de cerrar el diálogo.
                Navigator.of(context).pop(InsertImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () {
                Navigator.of(context).pop(InsertImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text("Link"),
              onTap: () {
                Navigator.of(context).pop(InsertImageSource.link);
              },
            ),
          ],
        ),
      );
    },
  );
}

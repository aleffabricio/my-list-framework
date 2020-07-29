import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

class FileController {
  static Future<File> getFile({@required nomeFile}) async {
    try {
      final diretorio = await getApplicationDocumentsDirectory();
      return File('${diretorio.path}/$nomeFile.json');
    } catch (e) {
      print('Erro ao buscar arquivo JSON \n\n $e');
      return null;
    }
  }

  static deleteDirectory() async {
    try {
      final diretorio = await getApplicationDocumentsDirectory();
      diretorio.deleteSync(recursive: true);
    } catch (e) {
      print('Erro ao excluir JSON \n\n $e');
      return null;
    }
  }

  static saveData({@required values, @required nomeFile}) async {
    try {
      final file = await getFile(nomeFile: nomeFile);
      return file.writeAsString(json.encode(values));
    } catch (e) {
      print('Erro ao salvar JSON \n\n $e');
      return null;
    }
  }

  static Future<String> readData({@required nomeFile}) async {
    try {
      final file = await getFile(nomeFile: nomeFile);
      return file.readAsString();
    } catch (e) {
      print('Erro ao ler o JSON \n\n $e');
      return null;
    }
  }
}

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<void> exportDatabase() async {
  // Pega o caminho do banco original
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, 'seu_banco.db');
  
  // Pega o diretório de download
  Directory? downloadDir = await getExternalStorageDirectory();
  String downloadPath = join(downloadDir!.path, 'backup_banco.db');

  try {
    // Copia o arquivo
    File sourceDatabaseFile = File(path);
    await sourceDatabaseFile.copy(downloadPath);
    print('Banco exportado para: $downloadPath');
  } catch (e) {
    print('Erro ao exportar: $e');
  }
}
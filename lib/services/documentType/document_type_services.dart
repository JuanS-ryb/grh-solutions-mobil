import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import '../../models/documentType/document_type_model.dart';

class DocumentService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:3000/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
 // typeDocuments/getAllNoPage
  Future<List<DocumentType>> getDocumentTypes() async {
    try {
      final response = await _dio.get("/typeDocuments/getAllNoPage"); // cambia el endpoint según tu backend
      final data = response.data as List;

      return data.map((json) => DocumentType.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Error al cargar tipos de documentos: $e");
    }
  }
}
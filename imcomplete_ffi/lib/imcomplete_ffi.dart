import 'dart:ffi' as ffi;
import 'dart:io' show Directory;

import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;

class DartOpaque extends ffi.Opaque{}

typedef ImcompleteNew = ffi.Pointer<ffi.Dart_CObject> Function(ffi.Pointer<Utf8> text);

typedef ImcompleteSetFunc = ffi.Void Function(ffi.Pointer<ffi.Dart_CObject> ptr, ffi.Pointer<Utf8> text);
typedef ImcompleteSet = void Function(ffi.Pointer<ffi.Dart_CObject> ptr, ffi.Pointer<Utf8> text);

typedef ImcompletePrintFunc = ffi.Void Function(ffi.Pointer<ffi.Dart_CObject> ptr);
typedef ImcompletePrint = void Function(ffi.Pointer<ffi.Dart_CObject> ptr);

typedef ImcompleteDeleteFunc = ffi.Void Function(ffi.Pointer<ffi.Dart_CObject> ptr);
typedef ImcompleteDelete = void Function(ffi.Pointer<ffi.Dart_CObject> ptr);
/*

typedef ImcompleteNew = ffi.Dart_CObject Function(ffi.Pointer<Utf8> text);

typedef ImcompleteSetFunc = ffi.Void Function(ffi.Dart_CObject ptr, ffi.Pointer<Utf8> text);
typedef ImcompleteSet = void Function(ffi.Dart_CObject ptr, ffi.Pointer<Utf8> text);

typedef ImcompletePrintFunc = ffi.Void Function(ffi.Dart_CObject ptr);
typedef ImcompletePrint = void Function(ffi.Dart_CObject ptr);

typedef ImcompleteDeleteFunc = ffi.Void Function(ffi.Dart_CObject ptr);
typedef ImcompleteDelete = void Function(ffi.Dart_CObject ptr);
*/
void cppLib() {
  var libraryPath = path.join(Directory.current.path, 'lib\\dll', 'ImcompleteDll.dll');

  print(libraryPath);

  final dylib = ffi.DynamicLibrary.open(libraryPath);

  final ImcompleteNew imNew = dylib.lookup<ffi.NativeFunction<ImcompleteNew>>('ImcompleteType_New').asFunction<ImcompleteNew>();
  final ImcompleteSet imSet = dylib.lookup<ffi.NativeFunction<ImcompleteSetFunc>>('ImcompleteType_Set').asFunction<ImcompleteSet>();
  final ImcompletePrint imPrint = dylib.lookup<ffi.NativeFunction<ImcompletePrintFunc>>('ImcompleteType_Print').asFunction<ImcompletePrint>();
  final ImcompleteDelete imDelete = dylib.lookup<ffi.NativeFunction<ImcompleteDeleteFunc>>('ImcompleteType_Delete').asFunction<ImcompleteDelete>();
  //final ImcompleteDelete imDelete = dylib.lookupFunction<ImcompleteDeleteFunc, ImcompleteDelete>('ImcompleteType_Delete');

  final str = 'Hello dart ffi.\n';
  final strUtf8 = str.toNativeUtf8();

  //ffi.Dart_CObject ptr = imNew(strUtf8);
  ffi.Pointer<ffi.Dart_CObject> ptr = imNew(strUtf8);
  imPrint(ptr);

  final afterStr = 'Goodbye dart ffi.\n';
  final afterStrUtf8 = afterStr.toNativeUtf8();

  imSet(ptr, afterStrUtf8);
  imPrint(ptr);

  imDelete(ptr);
}

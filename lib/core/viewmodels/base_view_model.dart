import 'dart:async';
import 'package:flutter/foundation.dart';
import '../enums/view_state.dart';

/// Tüm ViewModel'lerin türediği temel sınıf
/// State yönetimi ve loading durumu için gerekli metodları sağlar
abstract class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool _isDisposed = false;
  bool _isInitialized = false;
  ViewState _viewState = ViewState.initial;
  String? _errorMessage;
  FutureOr<void>? _initState;

  BaseViewModel() {
    // Load asynchronously in constructor
    load();
  }

  /// Tüm ViewModel'lerin implement etmesi gereken method
  /// İlk veri yükleme işlemleri burada yapılmalı
  FutureOr<void> init();

  /// ViewModel'i yükler ve init() metodunu çağırır
  Future<void> load() async {
    _viewState = ViewState.loading;
    _isLoading = true;
    notifyListeners();

    try {
      _initState = init();
      await _initState;
      _isInitialized = true;
      _viewState = ViewState.completed;
      _errorMessage = null;
    } catch (e) {
      _viewState = ViewState.error;
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// State'i yeniden yükler
  Future<void> reload() async {
    await load();
  }

  /// UI'ı güncellemek için kullanılır (minimum rebuild için scheduleMicrotask)
  void reloadState() {
    if (!_isLoading && !_isDisposed) {
      scheduleMicrotask(() {
        if (!_isDisposed) {
          notifyListeners();
        }
      });
    }
  }

  /// Hata durumunu ayarlar
  void setError(String? error) {
    _errorMessage = error;
    _viewState = ViewState.error;
    _isLoading = false;
    reloadState();
  }

  /// Başarılı durumu ayarlar
  void setCompleted() {
    _viewState = ViewState.completed;
    _errorMessage = null;
    _isLoading = false;
    reloadState();
  }

  // Getters
  bool get isLoading => _isLoading;
  bool get isInitialized => _isInitialized;
  bool get isDisposed => _isDisposed;
  ViewState get viewState => _viewState;
  String? get errorMessage => _errorMessage;

  // Setters
  set isLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      if (_isLoading) {
        _viewState = ViewState.loading;
      }
      scheduleMicrotask(() {
        if (!_isDisposed) {
          notifyListeners();
        }
      });
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}


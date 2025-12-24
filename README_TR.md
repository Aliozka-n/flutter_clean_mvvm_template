# Flutter Clean MVVM Template

🚀 **Clean Architecture + MVVM ile oluşturulmuş Production-ready Flutter başlangıç şablonu**

[![Flutter](https://img.shields.io/badge/Flutter-3.7+-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.7+-blue.svg)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## 📌 Genel Bakış

Bu şablon **profesyonel Flutter geliştirme** standartlarını gösterir:

- ✅ **Clean Architecture** + **MVVM Pattern**
- ✅ **Repository Pattern** (Service Katmanı üzerinden)
- ✅ **Dependency Injection** (GetIt)
- ✅ **State Management** (Provider)
- ✅ **Error Handling** & Network Yönetimi
- ✅ **Unit & Widget Test** Kurulumu
- ✅ **Material 3** Light/Dark Tema Desteği
- ✅ **Kurumsal Seviye Kod Yapısı**


## 🏗️ Mimari

### MVVM Hiyerarşisi

```
Screen (StatefulWidget)
    ↓
BaseView (Loading wrapper + State Management)
    ↓
ViewModel (Business Logic + State Management)
    ↓
Service (API çağrıları + Veri işlemleri)
    ↓
NetworkService (HTTP işlemleri)
```

### Klasör Yapısı

```
lib/
├── core/                      # Core/Base yapılar
│   ├── constants/            # AppColors, AppSizes, AppTheme, vb.
│   ├── enums/                # ViewState, RequestType
│   ├── models/               # ServiceResponse, NetworkResponseModel
│   ├── services/             # NetworkService (Singleton)
│   ├── viewmodels/           # BaseViewModel
│   ├── views/                # BaseView
│   └── di/                   # Dependency Injection
│
├── screens/                   # Feature-based ekranlar
│   └── [feature_name]/
│       ├── [feature]_screen.dart
│       ├── [feature]_service.dart
│       ├── viewmodels/
│       │   └── [feature]_view_model.dart
│       └── views/
│           └── [feature]_view.dart
│
├── domain/                    # Veri katmanı
│   ├── dtos/                 # Data Transfer Objects
│   ├── enums/                # Domain enum'ları
│   └── models/               # Domain modelleri (BaseModel)
│
├── common_widgets/            # Yeniden kullanılabilir widget'lar
│   ├── button_widget.dart
│   ├── text_field_widget.dart
│   └── alert_dialog_widget.dart
│
├── utils/                     # Yardımcı sınıflar
│   ├── extensions/           # Context, String, Widget extension'ları
│   ├── navigation_util.dart
│   ├── network_config.dart
│   ├── network_urls.dart
│   ├── shared_preferences_util.dart
│   └── validators_util.dart
│
└── main.dart
```

---

## 🚀 Başlangıç

### Gereksinimler

- Flutter SDK 3.7+
- Dart SDK 3.7+

### Kurulum

1. **Repository'yi klonlayın**
   ```bash
   git clone <repository-url>
   cd flutter_clean_mvvm_template
   ```

2. **Bağımlılıkları yükleyin**
   ```bash
   flutter pub get
   ```

3. **Uygulamayı çalıştırın**
   ```bash
   flutter run
   ```

---

## 📚 Temel Özellikler

### 1. BaseViewModel

Tüm ViewModel'ler `BaseViewModel`'den türer ve şunları sağlar:

- **ViewState Yönetimi**: `initial`, `loading`, `completed`, `error`
- **Otomatik Yükleme**: `init()` metodu otomatik çağrılır
- **State Güncellemeleri**: UI güncellemeleri için `reloadState()`
- **Hata Yönetimi**: Yerleşik hata durumu yönetimi

```dart
class ProductListViewModel extends BaseViewModel {
  @override
  FutureOr<void> init() async {
    await loadProducts();
  }
  
  Future<void> loadProducts() async {
    isLoading = true;
    // ... API çağrısı
    isLoading = false;
  }
}
```

### 2. BaseView

Otomatik loading durumu yönetimi:

```dart
BaseView<ProductListViewModel>(
  vmBuilder: (_) => ProductListViewModel(service: ProductListService()),
  builder: (context, viewModel) => ProductListView(viewModel: viewModel),
)
```

### 3. Network Katmanı

- **Singleton NetworkService** (Dio ile)
- **Request/Response Modelleri**
- **Merkezi URL Yönetimi**
- **Environment Yapılandırması** (Dev/Staging/Prod)

### 4. Constants & Theme

- **AppColors**: Merkezi renk yönetimi
- **AppSizes**: ScreenUtil ile responsive boyutlandırma
- **AppTheme**: Material 3 light/dark temalar
- **AppEdgeInsets**: Responsive padding/margin
- **AppBorderRadius**: Tutarlı border radius

### 5. Common Widgets

- **ButtonWidget**: Loading durumu olan özelleştirilebilir buton
- **TextFieldWidget**: Form'a hazır text field
- **AlertDialogWidget**: Başarı/Hata/Onay diyalogları

### 6. Extensions

- **BuildContext**: Navigation, snackbar, tema kısayolları
- **String**: Email/telefon validasyonu, büyük harf dönüşümü
- **Widget**: Padding, boyutlandırma, görünürlük yardımcıları

---

## 🧪 Test

### Unit Testler

ViewModel'leri ve iş mantığını test edin:

```bash
flutter test test/unit/
```

### Widget Testleri

UI bileşenlerini test edin:

```bash
flutter test test/widget/
```

### Integration Testler

Tam özellik akışlarını test edin:

```bash
flutter test test/integration/
```

---

## 📝 Kullanım Örneği

### Yeni Bir Feature Oluşturma

1. **Service Oluştur** (`lib/screens/my_feature/my_feature_service.dart`)

```dart
class MyFeatureService {
  Future<NetworkResponseModel> getData() async {
    var url = NetworkUrls().myFeatureUrl;
    var response = await NetworkService.instance.makeRequest(
      url,
      type: RequestType.get,
    );
    return response;
  }
}
```

2. **ViewModel Oluştur** (`lib/screens/my_feature/viewmodels/my_feature_view_model.dart`)

```dart
class MyFeatureViewModel extends BaseViewModel {
  final MyFeatureService service;
  
  MyFeatureViewModel({required this.service});
  
  @override
  FutureOr<void> init() async {
    await loadData();
  }
  
  Future<void> loadData() async {
    isLoading = true;
    var response = await service.getData();
    // Yanıtı işle
    isLoading = false;
  }
}
```

3. **View Oluştur** (`lib/screens/my_feature/views/my_feature_view.dart`)

```dart
class MyFeatureView extends StatelessWidget {
  final MyFeatureViewModel viewModel;
  
  const MyFeatureView({required this.viewModel});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // UI'ınızı buraya yazın
      ],
    );
  }
}
```

4. **Screen Oluştur** (`lib/screens/my_feature/my_feature_screen.dart`)

```dart
class MyFeatureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Feature')),
      body: BaseView<MyFeatureViewModel>(
        vmBuilder: (_) => MyFeatureViewModel(
          service: MyFeatureService(),
        ),
        builder: (context, viewModel) => MyFeatureView(
          viewModel: viewModel,
        ),
      ),
    );
  }
}
```

---

## 🎨 Temalar

Uygulama otomatik light/dark tema geçişi ile **Material 3**'ü destekler:

```dart
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: ThemeMode.system,
  // ...
)
```

---

## 🔧 Yapılandırma

### Environment Kurulumu

API environment'larını `lib/utils/network_config.dart` dosyasında yapılandırın:

```dart
NetworkConfig.setEnvironment(Environment.dev); // veya staging, prod
```

### SharedPreferences

Local storage'a `SharedPreferencesUtil` ile erişin:

```dart
// Token kaydet
await SharedPreferencesUtil.instance.setToken('your-token');

// Token oku
String? token = SharedPreferencesUtil.instance.getToken();
```

---

## 📦 Bağımlılıklar

### Core Paketler

- **provider**: State management
- **get_it**: Dependency injection
- **dio**: HTTP client
- **flutter_screenutil**: Responsive tasarım
- **shared_preferences**: Local storage

### Dev Paketler

- **flutter_test**: Test framework'ü
- **mockito**: Test için mocking
- **build_runner**: Kod üretimi

---

## 🏆 En İyi Uygulamalar

1. **ViewModel'ler için her zaman BaseViewModel'i extend edin**
2. **Otomatik loading state için BaseView kullanın**
3. **Sadece API çağrıları için Service katmanı**
4. **API request/response için DTO'lar**
5. **Tüm hardcoded değerler için Constants**
6. **Yeniden kullanılabilir kod için Extensions**
7. **ViewModel'ler ve widget'lar için test coverage**

---

## 🤝 Katkıda Bulunma

Katkılarınız memnuniyetle karşılanır! Lütfen mevcut kod stilini ve mimari desenleri takip edin.

---

## 📄 Lisans

Bu proje MIT Lisansı altında lisanslanmıştır.

## 📧 İletişim

Sorularınız veya önerileriniz için lütfen bir issue açın veya pull request oluşturun.

---

## 🎯 Proje Hakkında

Bu template, Flutter projeleriniz için **production-ready** bir başlangıç noktası sağlar. Clean Architecture ve MVVM pattern prensiplerini takip ederek, ölçeklenebilir, test edilebilir ve bakımı kolay kod yazmanızı sağlar.

### Kimler İçin?

- ✅ Flutter'da Clean Architecture öğrenmek isteyenler
- ✅ MVVM pattern ile çalışmak isteyenler
- ✅ Kurumsal seviye Flutter projesi geliştirmek isteyenler
- ✅ Best practice'leri takip eden geliştiriciler

### Neden Bu Template?

1. **Kurumsal Standartlar**: Production-ready kod yapısı
2. **Test Edilebilirlik**: Unit, Widget ve Integration test desteği
3. **Ölçeklenebilirlik**: Feature-based klasör yapısı
4. **Bakım Kolaylığı**: Temiz ve organize kod
5. **Öğrenme**: Best practice'lerin uygulandığı örnekler

---

**⭐ Bu template'i faydalı bulduysanız, lütfen bir yıldız verin!**


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clean_mvvm_template/screens/product_list/views/product_list_view.dart';
import 'package:flutter_clean_mvvm_template/screens/product_list/viewmodels/product_list_view_model.dart';
import 'package:flutter_clean_mvvm_template/screens/product_list/product_list_service.dart';

void main() {
  group('ProductListView Widget Tests', () {
    testWidgets('Displays search field', (WidgetTester tester) async {
      // Create view model with mock service
      final viewModel = ProductListViewModel(
        service: ProductListService(),
      );

      // Build widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductListView(viewModel: viewModel),
          ),
        ),
      );

      // Find search field
      expect(find.text('Search'), findsOneWidget);
    });

    testWidgets('Displays empty state when no products', (WidgetTester tester) async {
      final viewModel = ProductListViewModel(
        service: ProductListService(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductListView(viewModel: viewModel),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should show empty state message
      expect(find.text('No products found'), findsOneWidget);
    });

    testWidgets('Displays add button', (WidgetTester tester) async {
      final viewModel = ProductListViewModel(
        service: ProductListService(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductListView(viewModel: viewModel),
          ),
        ),
      );

      // Find add button
      expect(find.text('Add New Product'), findsOneWidget);
    });
  });
}


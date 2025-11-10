import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';

/// Service for managing in-app purchases
/// Handles premium upgrade and other purchases
class IapService extends ChangeNotifier {
  final InAppPurchase _iap = InAppPurchase.instance;

  // Product IDs - REPLACE WITH YOUR ACTUAL PRODUCT IDs FROM STORES
  static const String premiumProductId = 'artjoy_premium';
  static const String removeAdsProductId = 'artjoy_remove_ads';

  // Available products
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];

  bool _isAvailable = false;
  bool _isLoading = false;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  // Getters
  bool get isAvailable => _isAvailable;
  bool get isLoading => _isLoading;
  List<ProductDetails> get products => _products;

  /// Initialize the IAP service
  Future<void> initialize() async {
    _isAvailable = await _iap.isAvailable();

    if (!_isAvailable) {
      debugPrint('IAP not available on this device');
      return;
    }

    // Setup iOS specific stuff
    if (Platform.isIOS) {
      final iosPlatformAddition = _iap.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(IosPaymentQueueDelegate());
    }

    // Listen to purchase updates
    _subscription = _iap.purchaseStream.listen(
      _onPurchaseUpdate,
      onDone: () => _subscription?.cancel(),
      onError: (error) => debugPrint('Purchase error: $error'),
    );

    // Load products
    await loadProducts();
  }

  /// Load available products from the store
  Future<void> loadProducts() async {
    if (!_isAvailable) return;

    setState(_isLoading, true);

    try {
      const productIds = {
        premiumProductId,
        removeAdsProductId,
      };

      final response = await _iap.queryProductDetails(productIds);

      if (response.error != null) {
        debugPrint('Error loading products: ${response.error}');
        setState(_isLoading, false);
        return;
      }

      if (response.notFoundIDs.isNotEmpty) {
        debugPrint('Products not found: ${response.notFoundIDs}');
      }

      _products = response.productDetails;
      debugPrint('Loaded ${_products.length} products');

    } catch (e) {
      debugPrint('Error loading products: $e');
    } finally {
      setState(_isLoading, false);
    }
  }

  /// Purchase a product
  Future<void> buyProduct(ProductDetails product) async {
    if (!_isAvailable) {
      debugPrint('IAP not available');
      return;
    }

    setState(_isLoading, true);

    try {
      final purchaseParam = PurchaseParam(productDetails: product);
      await _iap.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      debugPrint('Error purchasing product: $e');
      setState(_isLoading, false);
    }
  }

  /// Restore previous purchases (iOS mainly)
  Future<void> restorePurchases() async {
    if (!_isAvailable) {
      debugPrint('IAP not available');
      return;
    }

    setState(_isLoading, true);

    try {
      await _iap.restorePurchases();
    } catch (e) {
      debugPrint('Error restoring purchases: $e');
    } finally {
      setState(_isLoading, false);
    }
  }

  /// Handle purchase updates
  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    for (final purchaseDetails in purchaseDetailsList) {
      _handlePurchase(purchaseDetails);
    }
    notifyListeners();
  }

  /// Handle individual purchase
  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.purchased ||
        purchaseDetails.status == PurchaseStatus.restored) {

      // Verify purchase with your server here in production
      final valid = await _verifyPurchase(purchaseDetails);

      if (valid) {
        // Grant premium features
        await _deliverProduct(purchaseDetails);
      }
    }

    if (purchaseDetails.status == PurchaseStatus.error) {
      debugPrint('Purchase error: ${purchaseDetails.error}');
    }

    // Complete the purchase
    if (purchaseDetails.pendingCompletePurchase) {
      await _iap.completePurchase(purchaseDetails);
    }

    setState(_isLoading, false);
  }

  /// Verify purchase with server
  /// In production, send to your backend for verification
  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    // TODO: Implement server-side verification
    // Send purchaseDetails.verificationData to your server
    // Server should verify with Apple/Google

    debugPrint('Verifying purchase: ${purchaseDetails.productID}');

    // For now, just return true
    // In production, verify with your server!
    return true;
  }

  /// Deliver the purchased product to the user
  Future<void> _deliverProduct(PurchaseDetails purchaseDetails) async {
    debugPrint('Delivering product: ${purchaseDetails.productID}');

    // TODO: Update user's premium status in your app
    // This should be saved to your database/preferences

    if (purchaseDetails.productID == premiumProductId ||
        purchaseDetails.productID == removeAdsProductId) {
      // Activate premium features
      // You'll need to integrate this with your SettingsService
      debugPrint('Premium activated!');
    }
  }

  /// Check if user owns a product
  bool hasProduct(String productId) {
    return _purchases.any((purchase) =>
        purchase.productID == productId &&
        (purchase.status == PurchaseStatus.purchased ||
            purchase.status == PurchaseStatus.restored));
  }

  /// Get product details by ID
  ProductDetails? getProduct(String productId) {
    try {
      return _products.firstWhere((p) => p.id == productId);
    } catch (e) {
      return null;
    }
  }

  /// Format price for display
  String formatPrice(ProductDetails product) {
    return product.price;
  }

  /// Helper to set loading state
  void setState(bool isLoading, bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Dispose resources
  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

/// iOS payment queue delegate
class IosPaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
    SKPaymentTransactionWrapper transaction,
    SKStorefrontWrapper storefront,
  ) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}

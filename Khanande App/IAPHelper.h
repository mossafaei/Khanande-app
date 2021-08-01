//
//  IAPHelper.h
//  Circles - Sibche IAP Sample Project.
//
//  Copyright 2012 TOD. All rights reserved.
//


@import Foundation;
@import StoreKit;
#ifndef APPSTORE_RELEASE
#   define SibcheReplaceRealStoreKit 1
#endif

// You need to use SibcheStorekit to access the In-App Purchase APIs, so you import the SibcheStorekit header here.
#import <StoreKit/StoreKit.h>
#import <SibcheStorekit/SibcheStorekit.h>

// Notification constants (we'll use them to notify listeners when a product has been purchased)
UIKIT_EXTERN NSString *const IAPHelperProductPurchasedNotification;
UIKIT_EXTERN NSString *const IAPHelperProductPurchaseFailedNotification;

// Block definition
typedef void (^RequestProductsCompletionHandler)(BOOL success, NSArray *products);

@interface IAPHelper : NSObject  <SKProductsRequestDelegate, SKPaymentTransactionObserver>

// Method definitions

// Initializer that takes a list of product identifiers, such as com.TOD.circles.unlockLevels, com.TOD.circles.ExtraLivesPack1, etc.
- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers;
// Retrieve information about the products from Sibche/AppStore
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;
// Starts the purchase process for a product
- (void)buyProduct:(SKProduct *)product;
// Determines if a product has been purchased
- (BOOL)productPurchased:(NSString *)productIdentifier;
// should call this method from appdelegate applicationDidFinishLaunchingWithOptions: and application:handleOpenURL:
- (void)registerForPurchaseEvents;
@end

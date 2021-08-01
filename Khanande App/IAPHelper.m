//
//  IAPHelper.m
//  Circles - Sibche IAP Sample Project.
//
//  Copyright 2012 TOD. All rights reserved.
//


#import "IAPHelper.h"

// We should define SibcheReplaceRealStoreKit if its not a appstore release so the SibcheStoreKit classes will replace with Apple Storekit modules.


#define kJsonStatusKey                      @"status"
#define kJsonDataKey                        @"data"
#define kJsonErrorKey                       @"error"
#define kJsonRecieptKey                     @"receipt"

NSString *const IAPHelperProductPurchasedNotification = @"IAPHelperProductPurchasedNotification";
NSString *const IAPHelperProductPurchaseFailedNotification = @"IAPHelperProductPurchaseFailedNotification";

/*
 To receive a list of products from StoreKit, you need to implement the SKProductsRequestDelegate protocol.
 To track transaction status, we implement the SKPaymentTransactionObserver too.
 */
@interface IAPHelper ()
@end

@implementation IAPHelper
{
    /*
     You create an instance variable to store the results of SKProductsRequest, to retrieve a list of products.
     */
    SKProductsRequest *_productsRequest;
    // You also keep track of the completion handler for the outstanding products request, ...
    RequestProductsCompletionHandler _completionHandler;
    // ... the list of product identifiers passed in, ...
    NSSet *_productIdentifiers;

}

- (void)registerForPurchaseEvents {
    // Add self as a transaction observer
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
 
}

// Initialitzer to check which products have been purchased
- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers
{

    if (self) {
        // Store product identifiers
        _productIdentifiers = [[NSSet alloc] init];
        _productIdentifiers = productIdentifiers;
        
        // Check for previously purchased products
        // This is important in order to check if a user already purchased products, so that we can show them to the user ...
        for (NSString *productIdentifier in _productIdentifiers) {
            // TODO: create a BOOL value named "productPurchased" and return a BOOL value for a given productIdentifier (boolForKey) for NSUserDefaults' standardUserDefaults method
            BOOL productPurchased = NO; //[[NSUserDefaults standardUserDefaults] boolForKey:productIdentifier];
            if (productPurchased) {
                NSLog(@"Previously purchased: %@", productIdentifier);
            } else {
                NSLog(@"Not purchased: %@", productIdentifier);
            }
        }
    }
    return self;
}

- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler
{
    // A copy of the completion handler block inside the instance variable so it can notify when the asynchronous product request completes
    _completionHandler = [completionHandler copy];

    // Create a new instance of SKProductsRequest (to pull the info from iTunes Connect)
    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:_productIdentifiers];
    _productsRequest.delegate = self;
    [_productsRequest start];
}

#pragma mark - SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSLog(@"Loaded products...");
    _productsRequest = nil;
    
    NSArray *skProducts = response.products;
    for (SKProduct *skProduct in skProducts) {
        NSLog(@"Found product: %@ – Product: %@ – Price: %0.2f", skProduct.productIdentifier, skProduct.localizedTitle, skProduct.price.floatValue);
    }
    
    // Method definition; (BOOL success, NSArray * products) ... success=YES, and the array of products is SKProducts
    _completionHandler(YES, skProducts);
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Failed to load list of products."
                                                      message:nil
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
    
    NSLog(@"Failed to load list of products.");
    
    // Method definition; (BOOL success, NSArray * products) ... success=NO, and the array of products is nil
    _completionHandler(NO, nil);
}

//- (BOOL)productPurchased:(NSString *)productIdentifier
//{
    //return NO; //[[NSUserDefaults standardUserDefaults] boolForKey:productIdentifier];
//}


- (void)buyProduct:(SKProduct *)product
{
    NSLog(@"Buying %@ ... (buyProduct ind IAPHelper)", product.productIdentifier);
    // TODO: create a SKPayment object ("payment") and call paymentWithProduct that returns a new payment for the specified product ("product)". (hint: 1 LOC)
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    
    // TODO: issue the SKPayment to the SKPaymentQueue: make the SKPaymentQueue class call the defaultQueue method and add a payment request to the queue (addPayment) for a given payment ("payment"). (hint: 1 LOC)
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}


    
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:

                [self validateReceiptForTransaction:transaction];
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            default:
                break;
        }
    };
}



// Called when the transaction was successful
- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    NSLog(@"completeTransaction...");
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}


// Called when a transaction has failed
- (void)failedTransaction:(SKPaymentTransaction *)transaction
{
    NSLog(@"failedTransaction...");
    
    if (transaction.error.code != SKErrorPaymentCancelled) {
        NSLog(@"Transaction error: %@", transaction.error.localizedDescription);
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Ups!"
                                                          message:transaction.error.localizedDescription
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    }
    
    [self sendFailureNotification];
}

- (void)provideContentForProductIdentifier:(NSString *)productIdentifier
{
    NSLog(@"provideContentForProductIdentifier");
    [[NSNotificationCenter defaultCenter] postNotificationName:IAPHelperProductPurchasedNotification
                                                       object:productIdentifier
                                                      userInfo:nil];
}

// Sends transaction receipt to sibche servers and verfies it. for consumalbe packages its neccassery to verfy the receipt to consume the package.
- (void)validateReceiptForTransaction:(SKPaymentTransaction*)transaction {
    
    [[SibcheSKPaymentQueue defaultQueue] verifyAndConsumeTransaction:transaction success:^(SibcheSKPaymentTransaction *transaction) {
        [self provideContentForProductIdentifier:transaction.payment.productIdentifier];
    } failure:^(SibcheSKPaymentTransaction *transaction, NSString *error) {
        NSLog(@"errorString :%@",error);
        [self sendFailureNotification];
    }];
}

// Notify listeners that the purchase has failed.
- (void)sendFailureNotification {
   [[NSNotificationCenter defaultCenter] postNotificationName:IAPHelperProductPurchaseFailedNotification
                                                       object:nil
                                                      userInfo:nil];
}

@end

//
//  CirclesIAPHelper.m
//  Circles - Sibche IAP Sample Project.
//
//  Copyright 2012 TOD. All rights reserved.
//


#import "CirclesIAPHelper.h"

@implementation CirclesIAPHelper

+ (CirclesIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static CirclesIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      kIdentifierExtraLivesPack3,
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
        [sharedInstance registerForPurchaseEvents];
    });
    return sharedInstance;
}

- (NSString *)descriptionForProduct:(SKProduct *)product
{
    NSString * descriptionString;

    if ([product.productIdentifier isEqualToString:kIdentifierExtraLivesPack3]) {
        descriptionString = [NSString stringWithFormat:@"Buy Music."];
    }
    return descriptionString;
}

- (BOOL)isPackageConsumableWithProductIdentifier:(NSString*)identifier{

    return YES;
}


@end
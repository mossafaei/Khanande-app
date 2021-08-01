//
//  CirclesIAPHelper.h
//  Circles - Sibche IAP Sample Project.
//
//  Copyright 2012 TOD. All rights reserved.
//


#import "IAPHelper.h"

#define pack1NumberOfLives 10
#define pack2NumberOfLives 20
#define pack3NumberOfLives 50

static NSString *kIdentifierExtraLivesPack3         = @"com.MostafaSafaeipour.Khanande-App.Music";

@interface CirclesIAPHelper : IAPHelper

+ (CirclesIAPHelper*)sharedInstance;

- (BOOL)isPackageConsumableWithProductIdentifier:(NSString*)identifier;
- (NSString *)descriptionForProduct:(SKProduct *)product;

@end
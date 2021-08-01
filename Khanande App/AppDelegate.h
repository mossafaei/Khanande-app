//
//  AppDelegate.h
//  Khanande App
//
//  Created by Apple on 9/9/15.
//  Copyright (c) 2015 ___MostafaSafaeipour___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Reachability.h"
#import <AFNetworking/AFNetworking.h>
#import "PAViewController.h"
#import <SWRevealViewController/SWRevealViewController.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
}

@property (strong, nonatomic) UIWindow *window;
- (BOOL)connected;
@end


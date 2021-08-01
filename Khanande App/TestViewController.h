//
//  TestViewController.h
//  Khanande App
//
//  Created by Apple on 9/9/15.
//  Copyright (c) 2015 ___MostafaSafaeipour___. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "TestingViewController.h"
#import "SettingViewController.h"
#import "PaymentViewController.h"
#import "BetviewController.h"
#import "CoinTableViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "JSONKit.h"
#import <DGActivityIndicatorView.h>
//#import <MBProgressHUD/MBProgressHUD.h>
@interface TestViewController : UIViewController <AVAudioPlayerDelegate,NSURLConnectionDataDelegate,UIAlertViewDelegate>
{
    DGActivityIndicatorView *activityIndicatorView;
    UIImageView*image;
    UIButton*like;
    UIButton*micro;
    UIButton*buy;
    UILabel*likelabel;
    UILabel*singlabel;
    UILabel*buylabel;
    NSString* answerchecklike;
    NSString* answerliked;
    NSString*buttonlikecolor;
    UIAlertView*alert;
    AVAudioPlayer*player;
    AVPlayerItem*playerItem;
    NSUInteger nobat;
    UIButton*playstop;
    UIAlertView*alertpurch;
    UIImageView*imagecover;
    NSString *namepath;
    UIAlertView *coinreq;
    UIAlertView *coinreqfaild;
    int counter;
    BOOL play;
    NSTimer*timer1;
    NSString *priceofsong;
    NSString *nameofsong;
    NSString *likeofsong;
    NSString *boughtofsong;
    NSString *didlikeofsong;
    unsigned long long expectedBytes;
}
@property (strong, nonatomic) NSURLConnection *theConnection;
@property (strong, nonatomic) NSMutableData *buffer;
-(void)seconddownload;
-(void)thirddownload;
@end

//
//  FirstTableViewController.h
//  Khanande App
//
//  Created by Apple on 9/9/15.
//  Copyright (c) 2015 ___MostafaSafaeipour___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "SimpleTableCell.h"
#import "TestViewController.h"
#import "Reachability.h"
#import "SettingViewController.h"
#import "MusicItemTableViewCell.h"
#import "BlackTableViewCell.h"
#import "AFTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import "UIScrollView+BottomRefreshControl.h"
#import "CoinTableViewController.h"
#import "CollecTableViewController.h"
#import <Canvas/Canvas.h>
#import <SWRevealViewController/SWRevealViewController.h>
#import <DGActivityIndicatorView.h>
@interface FirstTableViewController : UITableViewController <AVAudioRecorderDelegate,UICollectionViewDataSource, UICollectionViewDelegate , UIScrollViewDelegate >
{
    DGActivityIndicatorView *activityIndicatorView;
    NSString *numberfile;
    NSString *songsfile;
    NSInteger myInt,make,countsection ,pagenumber;
    NSMutableArray* myImage;
    NSMutableArray* mySongName;
    NSMutableArray* myArtistName;
    NSMutableArray* myCost;
    NSMutableArray* myCoverimage;
    UIRefreshControl*topRefreshControl;
    AVAudioRecorder*recorder;
    UIAlertView*alertsong;
    NSString *strutl;
    UIRefreshControl *refreshControlbottom;
    NSArray *arraydeappend;
   IBOutlet UIBarButtonItem* customBarButtonItem;
    NSArray *array;
    UIButton* customButton;
   IBOutlet UIBarButtonItem* revealButtonItem;
    UIAlertView *alertdavat;
    BOOL tableviewloaded;
}

-(IBAction)addsong:(id)sender;
@end

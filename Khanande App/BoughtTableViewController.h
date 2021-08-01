//
//  BoughtTableViewController.h
//  Khanande
//
//  Created by Apple on 6/3/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "MusicItemTableViewCell.h"
#import "BlackTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "TestViewController.h"
@interface BoughtTableViewController : UITableViewController{
    NSMutableArray *myArtist;
    NSMutableArray *mySong;
    NSMutableArray *myImage;
    NSMutableArray *myTag;
    NSUInteger make;
}

@end

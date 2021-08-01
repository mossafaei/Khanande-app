//
//  FavouriteTableViewController.h
//  Khanande App
//
//  Created by Apple on 9/12/15.
//  Copyright (c) 2015 ___MostafaSafaeipour___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "SimpleTableCell.h"
#import "TestViewController.h"
#import "Reachability.h"
@interface FavouriteTableViewController : UITableViewController{
    NSMutableArray*myImage;
    NSMutableArray*myLike;
    NSMutableArray*myName;
    NSUInteger make,countsection;
    NSArray* myArray;
        UIRefreshControl*refreshControl;
    UIAlertView*alertsong;
}
-(IBAction)addsong:(id)sender;
@end

//
//  CollectionTableViewController.h
//  Khanande
//
//  Created by Apple on 5/29/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "CollecTableViewController.h"
@interface CollectionTableViewController : UITableViewController{
    NSMutableArray* myCoverimage;
    NSMutableArray* myImage;
    NSMutableArray* myTag;
    NSArray* array;
    NSUInteger count;
}

@end

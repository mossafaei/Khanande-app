//
//  CollecTableViewController.h
//  Khanande
//
//  Created by Apple on 5/29/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleTableCell.h"
#import "UIImageView+WebCache.h"
#import <AFNetworking/AFNetworking.h>
#import "TestViewController.h"
@interface CollecTableViewController : UITableViewController{
    NSMutableArray* myImage;
    NSArray *array;
    NSUInteger count;
}

@end

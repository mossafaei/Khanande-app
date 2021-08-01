//
//  PAViewController.h
//  Khanande App
//
//  Created by Apple on 4/16/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"
@interface PAViewController : UIViewController <UIPageViewControllerDataSource>{
    IBOutlet UIButton *vorod;
    IBOutlet UIButton *sabt;
}

@property (strong, nonatomic) IBOutlet UIButton *okbu;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;
- (IBAction)click:(id)sender;
-(IBAction)test:(id)sender;
@end

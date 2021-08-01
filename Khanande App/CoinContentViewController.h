//
//  CoinContentViewController.h
//  Khanande
//
//  Created by Apple on 6/27/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoinContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;
@end

//
//  MusicItemTableViewCell.h
//  Khanande
//
//  Created by Apple on 5/29/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicItemTableViewCell : UITableViewCell

@property(nonatomic , weak) IBOutlet UIImageView *imagecover;
@property(nonatomic , weak) IBOutlet UILabel * artistlabel;
@property(nonatomic, weak) IBOutlet UILabel * songname;
@property(nonatomic , weak) IBOutlet UIButton *button;
@property(nonatomic , weak) IBOutlet UIView *animateview;
@end

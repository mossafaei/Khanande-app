//
//  MenuTableViewCell.m
//  Khanande
//
//  Created by Apple on 7/4/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell
@synthesize usernamelabel = _usernamelabel;
@synthesize coinlabel = _coinlabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  CoinTableViewCell.m
//  Khanande
//
//  Created by Apple on 6/8/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import "CoinTableViewCell.h"

@implementation CoinTableViewCell
@synthesize bu1 = _bu1;
@synthesize bu2 = _bu2;
@synthesize bu3 = _bu3;
@synthesize im1 = _im1;
@synthesize im2 = _im2;
@synthesize im3 = _im3;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

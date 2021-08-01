//
//  MusicItemTableViewCell.m
//  Khanande
//
//  Created by Apple on 5/29/16.
//  Copyright © 2016 ___MostafaSafaeipour___. All rights reserved.
//

#import "MusicItemTableViewCell.h"

@implementation MusicItemTableViewCell
@synthesize imagecover = _imagecover;
@synthesize artistlabel = _artistlabel;
@synthesize songname = _songname;
@synthesize button = _button;
@synthesize animateview = _animateview;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

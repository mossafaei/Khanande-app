//
//  SimpleTableCell.m
//  Khanande
//
//  Created by Apple on 8/24/15.
//  Copyright (c) 2015 ___MostafaSafaeipour___. All rights reserved.
//

#import "SimpleTableCell.h"

@implementation SimpleTableCell
@synthesize imagecell1 = _imagecell1;
@synthesize imagecell2 = _imagecell2;
@synthesize buttoncell1 = _buttoncell1;
@synthesize buttoncell2 = _buttoncell2;




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

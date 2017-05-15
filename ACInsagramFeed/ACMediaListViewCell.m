//
//  ACMediaListViewCell.m
//  ACInsagramFeed
//
//  Created by Chemersky on 5/15/17.
//  Copyright © 2017 Chemer. All rights reserved.
//

#import "ACMediaListViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation ACMediaListViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.profileImageView.layer.cornerRadius = 25;
    self.profileImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

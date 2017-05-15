//
//  ACMediaListViewCell.h
//  ACInsagramFeed
//
//  Created by Chemersky on 5/15/17.
//  Copyright © 2017 Chemer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACMediaListViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;

@end

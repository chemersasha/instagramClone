//
//  ACMediaDetailViewController.m
//  ACInsagramFeed
//
//  Created by Chemersky on 5/15/17.
//  Copyright © 2017 Chemer. All rights reserved.
//

#import "ACMediaDetailViewController.h"

@interface ACMediaDetailViewController ()
@property (strong, nonatomic) NSDictionary *data;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *likes;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@end

@implementation ACMediaDetailViewController

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        self.data = data;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userName.text = [[self.data objectForKey:@"user"] objectForKey:@"full_name"];
    NSString *profileImageUrl = [[self.data objectForKey:@"user"] objectForKey:@"profile_picture"];
    self.profileImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profileImageUrl]]];
    self.likes.text = [[[self.data objectForKey:@"likes"] objectForKey:@"count"] stringValue];
    NSString *photoUrl = [[[self.data objectForKey:@"images"] objectForKey:@"standard_resolution"] objectForKey:@"url"];
    self.photoImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoUrl]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

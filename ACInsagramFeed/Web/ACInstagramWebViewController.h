//
//  ACInstagramWebViewController.h
//  ACInsagramFeed
//
//  Created by Chemersky on 5/14/17.
//  Copyright © 2017 Chemer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACInstagramWebViewController : UIViewController
@property (strong, nonatomic) NSString *accessToken;

- (void)logout:(void(^)())completion;
- (void)requestAccessToken:(void(^)(BOOL accessToken))completion;
@end

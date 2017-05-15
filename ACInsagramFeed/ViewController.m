//
//  ViewController.m
//  ACInsagramFeed
//
//  Created by Chemersky on 5/14/17.
//  Copyright © 2017 Chemer. All rights reserved.
//

#import "ViewController.h"
#import "ACInstagramWebViewController.h"
#import "ACMediaListViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIView *logoutView;
@property (weak, nonatomic) IBOutlet UIView *loadIndicatorView;
@property (strong, nonatomic) ACInstagramWebViewController *instagramWebViewController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.instagramWebViewController = [ACInstagramWebViewController new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self showModalIndicatorView];
    [self.instagramWebViewController requestAccessToken:^(BOOL accessToken) {
        if (accessToken) {
            [self showLogoutView];
        } else {
            [self showLoginView];
        }
        [self hideModalIndicatorView];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)login:(UIButton *)sender {
    [self.navigationController pushViewController:self.instagramWebViewController animated:YES];    
}

- (IBAction)logout:(UIButton *)sender {
    [self showModalIndicatorView];
    [self.instagramWebViewController logout:^{
        [self showLoginView];
        [self hideModalIndicatorView];
    }];
}

- (IBAction)feed:(id)sender {
    ACMediaListViewController *feedViewController = [[ACMediaListViewController alloc] initWithAccessToken:self.instagramWebViewController.accessToken];
    [self.navigationController pushViewController:feedViewController animated:YES];
}

#pragma mark - 

- (void)showLoginView {
    [self hideLogoutView];
    self.loginView.hidden = NO;
}

- (void)hideLoginView {
    self.loginView.hidden = YES;
}

- (void)showLogoutView {
    [self hideLoginView];
    self.logoutView.hidden = NO;
}

- (void)hideLogoutView {
    self.logoutView.hidden = YES;
}

- (void)showModalIndicatorView {
    self.loadIndicatorView.hidden = NO;
}

- (void)hideModalIndicatorView {
    self.loadIndicatorView.hidden = YES;
}

@end

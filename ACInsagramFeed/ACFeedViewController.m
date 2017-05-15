//
//  ACFeedViewController.m
//  ACInsagramFeed
//
//  Created by Chemersky on 5/14/17.
//  Copyright © 2017 Chemer. All rights reserved.
//

#import "ACFeedViewController.h"
#import "ACMediaDetailViewController.h"
#import "ACInstagramJsonParser.h"

@interface ACFeedViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSArray *data;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation ACFeedViewController

- (instancetype)initWithAccessToken:(NSString *)accessToken
{
    self = [super init];
    if (self) {
        self.accessToken = accessToken;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestMediaRecent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestMediaRecent {
    NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/media/recent?access_token=%@",  self.accessToken];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [request setHTTPMethod:@"GET"];

    [self.activityIndicator startAnimating];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *dataJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        self.data = [dataJSON objectForKey:@"data"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.activityIndicator stopAnimating];
        });
    }];
    [dataTask resume];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDelegate UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
 
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
 
    NSDictionary *rowData = [self.data objectAtIndex:indexPath.row];
    cell.textLabel.text = [ACInstagramJsonParser fullNameFromDictionary:rowData];
    NSString *imageUrl = [ACInstagramJsonParser thumbnailUrlFromDictionary:rowData];
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ACMediaDetailViewController *mediaDetailViewController = [[ACMediaDetailViewController alloc] initWithData:[self.data objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:mediaDetailViewController animated:YES];
}

@end

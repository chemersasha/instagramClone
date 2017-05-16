//
//  ACMediaListViewController.m
//  ACInsagramFeed
//
//  Created by Chemersky on 5/14/17.
//  Copyright © 2017 Chemer. All rights reserved.
//

#import "ACMediaListViewController.h"
#import "ACMediaListViewCell.h"
#import "ACMediaDetailViewController.h"
#import "ACInstagramJsonParser.h"

const CGFloat kACMediaListCellHeight = 165.0;
NSString * const kACMediaRecentRequestUrl = @"https://api.instagram.com/v1/users/self/media/recent?count=10&access_token=";

@interface ACMediaListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSMutableArray *data;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation ACMediaListViewController

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
    
    self.data = [NSMutableArray new];
    
    [self.activityIndicator startAnimating];
    [self requestMediaRecent:[NSString stringWithFormat:@"%@%@", kACMediaRecentRequestUrl, self.accessToken]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestMediaRecent:(NSString *)url {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [request setHTTPMethod:@"GET"];

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //@TODO handle error
        NSDictionary *dataJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        [self.data addObjectsFromArray:[dataJSON objectForKey:@"data"]];
        
        NSString *nextUrl = [ACInstagramJsonParser paginationNextUrlFromDictionary:dataJSON];
        if (nextUrl) {
            [self requestMediaRecent:nextUrl];
        }
        
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kACMediaListCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableCellIdentifier = @"ACMediaListViewCell";
 
    ACMediaListViewCell *cell = (ACMediaListViewCell *)[tableView dequeueReusableCellWithIdentifier:tableCellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ACMediaListViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    } 

    NSDictionary *rowData = [self.data objectAtIndex:indexPath.row];

    NSString *imageUrl = [ACInstagramJsonParser thumbnailUrlFromDictionary:rowData];
    cell.photoImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];

    NSString *profileImageUrl = [ACInstagramJsonParser profileImageUrlFromDictionary:rowData];
    cell.profileImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:profileImageUrl]]];
    
    cell.userNameLabel.text = [ACInstagramJsonParser fullNameFromDictionary:rowData];
    cell.likesLabel.text = [ACInstagramJsonParser likesFromDictionary:rowData];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ACMediaDetailViewController *mediaDetailViewController = [[ACMediaDetailViewController alloc] initWithData:[self.data objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:mediaDetailViewController animated:YES];
}

@end

//
//  SampleTableViewController.m
//  DRPLoadingSpinner
//
//  Created by Justin Hill on 10/15/16.
//  Copyright © 2016 Justin Hill. All rights reserved.
//

#import "SampleTableViewController.h"
#import "DRPRefreshControl.h"

NSString * const ReuseIdentifier = @"ReuseIdentifier";

@interface SampleTableViewController ()

@property (strong) DRPRefreshControl *drpRefreshControl;

@end

@implementation SampleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak SampleTableViewController *weakSelf = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ReuseIdentifier];
    
    UIColor *darkGray = [UIColor darkGrayColor];
    CGFloat size = 10;
    UIFont *font = [UIFont fontWithName:@"Helvetica-Light" size:size];
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:@"Testing..." attributes:[NSDictionary dictionaryWithObjectsAndKeys:darkGray, NSForegroundColorAttributeName, font, NSFontAttributeName, nil]];
    
    self.drpRefreshControl = [[DRPRefreshControl alloc] initWithAttributedTitle:attributedTitle];
//    self.drpRefreshControl.yOffset = -200;
    
    [self.drpRefreshControl addToTableViewController:self target:self selector:@selector(refreshTriggered)];

//    [self.drpRefreshControl addToTableViewController:self refreshBlock:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf.drpRefreshControl endRefreshing];
//        });
//    }];

//    [self.drpRefreshControl addToScrollView:self.tableView target:self selector:@selector(refreshTriggered)];

//    [self.drpRefreshControl addToScrollView:self.tableView refreshBlock:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf.drpRefreshControl endRefreshing];
//        });
//    }];
}

- (void)refreshTriggered {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.drpRefreshControl endRefreshing];
    });
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [[[NSNumberFormatter alloc] init] stringFromNumber:@(indexPath.row)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.drpRefreshControl beginRefreshing];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

//
//  FCFavouritesRootViewController.m
//  FitCook
//
//  Created by Joyoki on 2018/7/26.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCFavouritesRootViewController.h"
#import "FCFavouritesRootListCell.h"

@interface FCFavouritesRootViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tvList;

@property (nonatomic, strong) NSMutableArray *arrData;

@end

@implementation FCFavouritesRootViewController

+ (NSString *)storyboardName {
    return @"Favourites";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrData = [NSMutableArray array];
    [_arrData addObjectsFromArray:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
    
    _tvList.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tvList.estimatedRowHeight = 0;
    _tvList.estimatedSectionHeaderHeight = 0;
    _tvList.estimatedSectionFooterHeight = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arrData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 134;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 14;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FCFavouritesRootListCell *cell = [FCFavouritesRootListCell cellWithTableView:tableView andIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView endEditing:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.arrData removeObjectAtIndex:indexPath.section];
            [tableView reloadData];
        });
    }
}


@end

//
//  FCFavouritesRootViewController.m
//  FitCook
//
//  Created by Joyoki on 2018/7/26.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCFavouritesRootViewController.h"
#import "FCFavouritesRootListCell.h"
#import "FCRecipesDetailViewController.h"

@interface FCFavouritesRootViewController ()<UITableViewDelegate,UITableViewDataSource>



@property (weak, nonatomic) IBOutlet UITableView *tvList;
@property (weak, nonatomic) IBOutlet UIView *vNoData;

@property (nonatomic, strong) NSMutableArray *arrData;

@property (nonatomic, assign) BOOL isNeedRefresh;

@end

@implementation FCFavouritesRootViewController

+ (NSString *)storyboardName {
    return @"Favourites";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _isNeedRefresh = YES;
    
    _arrData = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userUpdateFavouriteNotification:) name:kUserUpdateFavouriteNotificationKey object:nil];
    
    _tvList.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tvList.estimatedRowHeight = 0;
    _tvList.estimatedSectionHeaderHeight = 0;
    _tvList.estimatedSectionFooterHeight = 0;
}

- (void)userUpdateFavouriteNotification:(NSNotification *)notifi {
    NSString *vcName = notifi.object;
    if (vcName && ![vcName isEqualToString:NSStringFromClass([self class])]) {
        _isNeedRefresh = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_isNeedRefresh) {
        _isNeedRefresh = NO;
        [self refreshData];
    }
}

- (void)refreshData {
    [self.arrData removeAllObjects];
    FCUser *user = [FCUser currentUser];
    [[FCRecipe allRecipes] enumerateObjectsUsingBlock:^(FCRecipe * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([user isFavouriteRecipe:obj]) {
            [self.arrData addObject:obj];
        }
    }];
    [self reloadData:NO];
}

- (void)reloadData:(BOOL)animated {
    [_tvList reloadData];
    if (self.arrData.count > 0) {
        [self hideNoDataView:animated];
    } else {
        [self showNoDataView:animated];
    }
}

- (void)showNoDataView:(BOOL)animated {
    if (_vNoData.alpha != 1) {
        if (animated) {
            [self.view bringSubviewToFront:_vNoData];
            [UIView animateWithDuration:0.3 animations:^{
                self.vNoData.alpha = 1;
            }];
        } else {
            [self.view bringSubviewToFront:_vNoData];
            self.vNoData.alpha = 1;
        }
    }
}

- (void)hideNoDataView:(BOOL)animated {
    if (_vNoData.alpha != 0) {
        if (animated) {
            [UIView animateWithDuration:0.3 animations:^{
                self.vNoData.alpha = 0;
            } completion:^(BOOL finished) {
                [self.view sendSubviewToBack:self.vNoData];
            }];
        } else {
            self.vNoData.alpha = 0;
            [self.view sendSubviewToBack:self.vNoData];
        }
    }
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
    FCRecipe *recipe = _arrData[indexPath.section];
    cell.imgvFood.image = [AppDelegate shareDelegate].images[recipe.imageName_1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FCRecipesDetailViewController *vcRecipesDetail = [FCRecipesDetailViewController viewControllerFromStoryboardWithRecipe:_arrData[indexPath.section]];
    [self.navigationController pushViewController:vcRecipesDetail animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView endEditing:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            FCRecipe *recipe = [self.arrData objectAtIndex:indexPath.section];
            [[FCUser currentUser] updateRecipe:recipe isFavourite:NO];
            [self.arrData removeObjectAtIndex:indexPath.section];
            [self reloadData:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:kUserUpdateFavouriteNotificationKey object:NSStringFromClass([self class])];
        });
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

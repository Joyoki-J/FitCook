//
//  FCShoppingRootViewController.m
//  FitCook
//
//  Created by shanshan on 2018/7/26.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCShoppingRootViewController.h"
#import "FCShoppingRootRecipesCell.h"
#import "FCShoppingRootFoodsCell.h"
#import "FCShoppingListViewController.h"

@interface FCShoppingRootViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) BOOL isFoodsStyle;
@property (nonatomic, strong) UIButton *btnRightItem;

@property (weak, nonatomic) IBOutlet UITableView *tvList;
@property (weak, nonatomic) IBOutlet UIView *vNoData;

@property (nonatomic, strong) NSMutableArray *arrRecipes;
@property (nonatomic, strong) NSMutableArray *arrFoods;

@property (nonatomic, assign) BOOL isNeedRefresh;

@end

@implementation FCShoppingRootViewController

+ (NSString *)storyboardName {
    return @"Shopping";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arrRecipes = [NSMutableArray array];
    _arrFoods   = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userUpdateShoppingNotification:) name:kUserUpdateShoppingNotificationKey object:nil];
    
    [_arrRecipes addObjectsFromArray:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
    [_arrFoods addObjectsFromArray:@[@"Avocado",@"Spaghetti",@"Olive Oil",@"Salt",@"Milk"]];
    
    _tvList.estimatedSectionFooterHeight = 0;
    _tvList.estimatedSectionFooterHeight = 0;
    
    [self addRightBarButtonItem];
}

- (void)userUpdateShoppingNotification:(NSNotification *)notifi {
    NSString *vcName = notifi.object;
    if (vcName && ![vcName isEqualToString:NSStringFromClass([self class])]) {
        _isNeedRefresh = YES;
    }
}

- (void)addRightBarButtonItem {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 22, 22, 22);
    [button setImage:[UIImage imageNamed:@"navbarItem_liststyle_recipes"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClickRightAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    _btnRightItem = button;
}

- (void)onClickRightAction:(UIButton *)sender {
    _isFoodsStyle = !_isFoodsStyle;
    [_btnRightItem setImage:_isFoodsStyle ? [UIImage imageNamed:@"navbarItem_liststyle_foods"] : [UIImage imageNamed:@"navbarItem_liststyle_recipes"] forState:UIControlStateNormal];
    [_tvList reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_isNeedRefresh) {
        _isNeedRefresh = NO;
        [self refreshData];
    }
}

- (void)refreshData {
    [self.arrRecipes removeAllObjects];
    FCUser *user = [FCUser currentUser];
    [[FCRecipe allRecipes] enumerateObjectsUsingBlock:^(FCRecipe * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([user isFavouriteRecipe:obj]) {
            [self.arrRecipes addObject:obj];
        }
    }];
    [self reloadData:NO];
}

- (void)reloadData:(BOOL)animated {
    [_tvList reloadData];
    if (self.arrRecipes.count > 0) {
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

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _isFoodsStyle ? _arrFoods.count : _arrRecipes.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _isFoodsStyle ? 42.0 : 116.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return _isFoodsStyle ? CGFLOAT_MIN : 14.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isFoodsStyle) {
        FCShoppingRootFoodsCell *cell = [FCShoppingRootFoodsCell cellWithTableView:tableView andIndexPath:indexPath];
        cell.labFoodName.text = _arrFoods[indexPath.section];
        return cell;
    } else {
        FCShoppingRootRecipesCell *cell = [FCShoppingRootRecipesCell cellWithTableView:tableView andIndexPath:indexPath];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isFoodsStyle) {
        FCShoppingRootFoodsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.isSelected = !cell.isSelected;
    } else {
        FCShoppingListViewController *vcShoppingList = [FCShoppingListViewController viewControllerFromStoryboard];
        [self.navigationController pushViewController:vcShoppingList animated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return !_isFoodsStyle;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_isFoodsStyle && editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView endEditing:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.arrRecipes removeObjectAtIndex:indexPath.section];
            [self reloadData:YES];
        });
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

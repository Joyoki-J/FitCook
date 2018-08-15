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
#import "FCShoppingRecipe.h"

@interface FCShoppingRootViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) BOOL isFoodsStyle;
@property (nonatomic, strong) UIButton *btnRightItem;

@property (weak, nonatomic) IBOutlet UITableView *tvList;
@property (weak, nonatomic) IBOutlet UIView *vNoData;

@property (nonatomic, strong) NSMutableArray<FCShoppingRecipe *> *arrRecipes;
@property (nonatomic, strong) NSMutableArray *arrFoods;

@property (nonatomic, assign) BOOL isNeedRefresh;

@end

@implementation FCShoppingRootViewController

+ (NSString *)storyboardName {
    return @"Shopping";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isNeedRefresh = YES;
    
    _arrRecipes = [NSMutableArray array];
    _arrFoods   = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userUpdateShoppingNotification:) name:kUserUpdateShoppingNotificationKey object:nil];
    
    _tvList.estimatedSectionFooterHeight = 0;
    _tvList.estimatedSectionFooterHeight = 0;
    
//    [self addRightBarButtonItem];
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
    [self reloadData:YES];
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
    [_arrRecipes addObjectsFromArray:[[FCUser currentUser] getShoppingList]];
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
    return _isFoodsStyle ? 50.0: 116.0;
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
        FCShoppingRecipe *shoppingRecipe = [_arrRecipes objectAtIndex:indexPath.section];
        [cell.imgvFood fc_setImageWithName:shoppingRecipe.imageName_3];
        cell.labTitle.text = shoppingRecipe.name;
        cell.labDetails.text = [NSString stringWithFormat:@"%ld ingredents missing",(long)[shoppingRecipe HowManyIngredentsMissing]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isFoodsStyle) {
        FCShoppingRootFoodsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.isSelected = !cell.isSelected;
    } else {
        FCShoppingListViewController *vcShoppingList = [FCShoppingListViewController viewControllerFromStoryboard];
        vcShoppingList.shoppingRecipe = [_arrRecipes objectAtIndex:indexPath.section];
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
            FCShoppingRecipe *recipe = [self.arrRecipes objectAtIndex:indexPath.section];
            [[FCUser currentUser] deleteRecipeFromShoppingList:recipe];
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

//
//  FCShoppingListViewController.m
//  FitCook
//
//  Created by shanshan on 2018/7/31.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCShoppingListViewController.h"
#import "FCRecipesDetailViewController.h"
#import "FCShoppingRootFoodsCell.h"

@interface FCShoppingListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tvList;

@property (nonatomic, strong) UIImageView *imgvHeader;

@property (nonatomic, strong) RLMResults<FCShoppingIngredient *> *arrIngredients;

@end

@implementation FCShoppingListViewController

+ (NSString *)storyboardName {
    return @"Shopping";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Shopping List";
    
    _tvList.tableHeaderView = [self createHeaderView];
    [_imgvHeader fc_setImageWithName:_shoppingRecipe.imageName_1];
    
    [self reloadData];
}

- (UIView *)createHeaderView {
    UIView *vHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 21.0 / 50.0 * (kSCREEN_WIDTH - 30.0) + 35)];
    vHeader.backgroundColor = [UIColor whiteColor];
    
    _imgvHeader = [[UIImageView alloc] init];
    [vHeader addSubview:_imgvHeader];
    
    UIView *vMask = [[UIView alloc] init];
    vMask.backgroundColor = RGBA(0, 0, 0, 12);
    [vHeader addSubview:vMask];
    
    [_imgvHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-35);
        make.leading.mas_equalTo(15);
        make.trailing.mas_equalTo(-15);
    }];
    
    [vMask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-35);
        make.leading.mas_equalTo(15);
        make.trailing.mas_equalTo(-15);
    }];
    
    UILabel *labServings = [[UILabel alloc] init];
    labServings.text = [NSString stringWithFormat:@"%ld Servings",_shoppingRecipe.count];
    labServings.textAlignment = NSTextAlignmentLeft;
    labServings.textColor = RGB(99, 99, 102);
    labServings.font = kBoldFont(18);
    [vHeader addSubview:labServings];
    
    [labServings mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(0);
    }];
    
    return vHeader;
}

- (IBAction)onClickHeaderAction:(UIButton *)sender {
    FCRecipe *recipe = [FCRecipe recipeWithIndex:_shoppingRecipe.index];
    FCRecipesDetailViewController *vcRecipesDetail = [FCRecipesDetailViewController viewControllerFromStoryboardWithRecipe:recipe];
    [self.navigationController pushViewController:vcRecipesDetail animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrIngredients.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 42;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FCShoppingRootFoodsCell *cell = [FCShoppingRootFoodsCell cellWithTableView:tableView andIndexPath:indexPath];
    FCShoppingIngredient *ingredient = _arrIngredients[indexPath.row];
    cell.labFoodName.text = ingredient.name;
    [cell.vCount setTextWithDosage:[[ingredient.dosage getDosage] mulNumber:_shoppingRecipe.count]];
    cell.isSelected = ingredient.isBuy;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FCShoppingIngredient *ingredient = _arrIngredients[indexPath.row];
    if (ingredient.isBuy) {
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            ingredient.isBuy = NO;
            ingredient.weight = ingredient.weight - 200;
        }];
    } else {
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            ingredient.isBuy = YES;
            ingredient.weight = ingredient.weight + 200;
        }];
    }
    [self reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserUpdateShoppingNotificationKey object:NSStringFromClass([self class])];
}

- (void)reloadData {
    _arrIngredients = [_shoppingRecipe.ingredients sortedResultsUsingKeyPath:@"weight" ascending:YES];
    [_tvList reloadData];
}

@end

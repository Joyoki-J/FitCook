//
//  FCSearchRootViewController.m
//  FitCook
//
//  Created by Joyoki on 2018/7/26.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCSearchRootViewController.h"
#import "FCSearchFilterViewController.h"
#import "FCSearchScanViewController.h"
#import "FCRecipesDetailViewController.h"
#import "FCSearchRootListCell.h"
#import "FCSearchRootListNoDataCell.h"
#import "FCSearchHeaderView.h"

@interface FCSearchRootViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,FCSearchHeaderViewDelegate,FCSearchFilterViewControllerDelegate,FCSearchRootListCellDelegate>

@property (strong, nonatomic) IBOutlet UIView *vHeaderBack;
@property (strong, nonatomic) IBOutlet FCSearchHeaderView *vHeader;
@property (weak, nonatomic) IBOutlet UITableView *tvList;
@property (weak, nonatomic) IBOutlet UIImageView *imgvLogo;

@property (nonatomic, strong) UIView *vFooter;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) BOOL isScrollingToTop;

@property (nonatomic, assign) BOOL isNeedDefaultStatusBar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutLogoW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutLogoH;

@property (nonatomic, strong) NSMutableArray<FCRecipe *> *arrRecipe;

@property (nonatomic, assign) BOOL isNeedRefresh;

@end

@implementation FCSearchRootViewController

+ (NSString *)storyboardName {
    return @"Search";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSubViews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userUpdateFavouriteNotification:) name:kUserUpdateFavouriteNotificationKey object:nil];
    
    _arrRecipe = [NSMutableArray arrayWithArray:[FCRecipe allRecipes]];
}

- (void)createSubViews {
    _vFooter = [[UIView alloc] init];
    _vFooter.backgroundColor = [UIColor whiteColor];
    
    _headerHeight = kSCREEN_WIDTH * 0.75 + 109;
    
    _layoutLogoW.constant = kSCREEN_WIDTH * (203.0 / 375.0);
    _layoutLogoH.constant = 169.0 / (375 * 0.75) * (kSCREEN_WIDTH * 0.75);
    
    _tvList.contentInset = UIEdgeInsetsMake(_headerHeight - 175, 0, 0, 0);
    _tvList.estimatedSectionFooterHeight = 0;
    _tvList.estimatedSectionHeaderHeight = 0;
    _tvList.estimatedRowHeight = 0;
    _tvList.scrollsToTop = NO;
    
    _vHeader.frame = CGRectMake(0, _headerHeight - 135, kSCREEN_WIDTH, 135);
    _vHeader.tfSearch.delegate = self;
    _vHeader.delegate = self;
    [self.view addSubview:_vHeader];
    
    _imgvLogo.layer.anchorPoint = CGPointMake(0.5, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_isNeedRefresh == YES) {
        _isNeedRefresh = NO;
        [_tvList reloadRowsAtIndexPaths:[_tvList indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)userUpdateFavouriteNotification:(NSNotification *)notifi {
    NSString *vcName = notifi.object;
    if (vcName && ![vcName isEqualToString:NSStringFromClass([self class])]) {
        _isNeedRefresh = YES;
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrRecipe.count > 0 ? _arrRecipe.count : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _arrRecipe.count > 0 ? 148 : kSCREEN_HEIGHT - 175 - kTABBAR_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_arrRecipe.count > 0) {
        FCSearchRootListCell *cell = [FCSearchRootListCell cellWithTableView:tableView andIndexPath:indexPath];
        FCRecipe *mRecipe = [_arrRecipe objectAtIndex:indexPath.row];
        cell.delegate = self;
        cell.indexPath = indexPath;
        [cell.imgvFood fc_setImageWithName:mRecipe.imageName_1];
        cell.labTitle.text = mRecipe.name;
        cell.labTime.text = mRecipe.time;
        cell.isFavourited = [[FCUser currentUser] isFavouriteRecipe:mRecipe];
        return cell;
    } else {
        FCSearchRootListNoDataCell *cell = [FCSearchRootListNoDataCell cellWithTableView:tableView andIndexPath:indexPath];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_arrRecipe.count > 0) {
        FCRecipesDetailViewController *vcRecipesDetail = [FCRecipesDetailViewController viewControllerFromStoryboardWithRecipe:_arrRecipe[indexPath.row]];
        [self.navigationController pushViewController:vcRecipesDetail animated:YES];
    }
}

#pragma mark - FCSearchRootListCellDelegate
- (void)searchRootListCell:(FCSearchRootListCell *)cell didClickFavouriteActionWithIndexPath:(NSIndexPath *)indexPath {
    FCRecipe *recipe = [_arrRecipe objectAtIndex:indexPath.row];
    FCUser *user = [FCUser currentUser];
    [user updateRecipe:recipe isFavourite:!cell.isFavourited];
    cell.isFavourited = !cell.isFavourited;
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserUpdateFavouriteNotificationKey object:NSStringFromClass([self class])];
}

- (void)reloadData {
    CGPoint p = _tvList.contentOffset;
    [_tvList reloadData];
    if (_tvList.contentSize.height < (kSCREEN_HEIGHT - 175 - kTABBAR_HEIGHT)) {
        _vFooter.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT - 175 - kTABBAR_HEIGHT - _tvList.contentSize.height);
        _tvList.tableFooterView = _vFooter;
    } else {
        _vFooter.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 14);
        _tvList.tableFooterView = _vFooter;
    }
    if (p.y > _tvList.contentSize.height - (kSCREEN_HEIGHT - 175 - kTABBAR_HEIGHT)) {
        [_tvList setContentOffset:CGPointZero];
    } else {
        [_tvList setContentOffset:p];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
    
    CGFloat y = scrollView.contentOffset.y;
    
    if (y > 0) {
        _vHeader.minY = 40;
    } else if (y < -(_headerHeight - 175)) {
        _vHeader.minY = _headerHeight - 135;
    } else {
        _vHeader.minY = 40 - y;
    }

    CGFloat progress = 1.0 - (_headerHeight - 175 + y) / (_headerHeight - 175);
    if (progress > 1) {
        progress = 1;
    }
    if (progress < 0) {
        progress = 0;
    }
    
    _imgvLogo.layer.transform = CATransform3DMakeScale(progress, progress, 1);
    _vHeader.progress = progress;
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (_isScrollingToTop) {
        _isScrollingToTop = NO;
        [_vHeader.tfSearch becomeFirstResponder];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    CGPoint offset = _tvList.contentOffset;
    [_tvList setContentOffset:offset animated:NO];
    if (offset.y < 0) {
        _isScrollingToTop = YES;
        [_tvList setContentOffset:CGPointZero animated:YES];
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *keywords = [textField.text lowercaseString];
    NSArray<FCRecipe *> *recipes = [FCRecipe recipesWithKeywords:[keywords componentsSeparatedByString:@" "]];
    for (FCRecipe *r in recipes) {
        NSLog(@"name = %@",r.name);
        NSLog(@"keywords = %@",r.keywords);
    }
    NSLog(@"============================");
    return YES;
}

#pragma mark - FCSearchHeaderViewDelegate
- (void)searchHeaderDidClickScanAction:(FCSearchHeaderView *)vHeader {
    FCSearchScanViewController *vcSearchScan = [FCSearchScanViewController viewControllerFromStoryboard];
    [self.navigationController pushViewController:vcSearchScan animated:YES];
}

- (void)searchHeaderDidClickSeeAllFilterAction:(FCSearchHeaderView *)vHeader {
    _isNeedDefaultStatusBar = YES;
    FCSearchFilterViewController *vcSearchFilter = [FCSearchFilterViewController viewControllerWithCustomTransition];
    vcSearchFilter.delegate = self;
    [self.tabBarController presentViewController:vcSearchFilter animated:YES completion:nil];
}

- (void)searchHeaderDidSelectedFilter:(FCSearchHeaderView *)vHeader {
    [_arrRecipe removeAllObjects];
    if (vHeader.keywords.count > 0) {
        [_arrRecipe addObjectsFromArray:[FCRecipe predicateWithFilters:vHeader.keywords]];
    } else {
        [_arrRecipe addObjectsFromArray:[FCRecipe allRecipes]];
    }
    [self reloadData];
}

#pragma mark - FCSearchFilterViewControllerDelegate
- (void)searchFilterViewControllerWillClose:(FCSearchFilterViewController *)vc {
    _isNeedDefaultStatusBar = NO;
}

#pragma mark - Override
- (UIStatusBarStyle)preferredStatusBarStyle {
    return _isNeedDefaultStatusBar ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
}

- (BOOL)needsHiddenNavigationBar {
    return YES;
}

- (UIColor *)navigationBarTitleColor {
    return [UIColor whiteColor];
}

- (UIFont *)navigationBarTitleFont {
    return kFont_20;
}

//- (UIImage *)navigationBarBackgroundImage {
//    return [UIImage fc_imageWithColor:[UIColor clearColor]];
//}

- (UIImage *)navigationBarBackgroundImage {
    return [UIImage fc_imageForDeviceWithImageName:@"navbar_background"];
}

@end

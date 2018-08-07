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
#import "FCSearchHeaderView.h"

@interface FCSearchRootViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,FCSearchHeaderViewDelegate,FCSearchFilterViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UIView *vHeaderBack;
@property (strong, nonatomic) IBOutlet FCSearchHeaderView *vHeader;
@property (weak, nonatomic) IBOutlet UITableView *tvList;
@property (weak, nonatomic) IBOutlet UIImageView *imgvLogo;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) BOOL isScrollingToTop;

@property (nonatomic, assign) BOOL isNeedDefaultStatusBar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutLogoW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutLogoH;

@end

@implementation FCSearchRootViewController

+ (NSString *)storyboardName {
    return @"Search";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSubViews];
}

- (void)createSubViews {

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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 148;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FCSearchRootListCell *cell = [FCSearchRootListCell cellWithTableView:tableView andIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FCRecipesDetailViewController *vcRecipesDetail = [FCRecipesDetailViewController viewControllerFromStoryboard];
    [self.navigationController pushViewController:vcRecipesDetail animated:YES];
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
    NSString *keyword = vHeader.tfSearch.text;
    if (keyword && keyword.length > 0) {
        NSLog(@"选择了Filter = %@",keyword);
    } else {
        NSLog(@"清空了Filter");
    }
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

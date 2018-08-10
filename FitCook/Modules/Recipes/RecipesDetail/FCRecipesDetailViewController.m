//
//  FCRecipesDetailViewController.m
//  FitCook
//
//  Created by Joyoki on 2018/7/31.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCRecipesDetailViewController.h"
#import "FCRecipesSegmentedView.h"

@interface FCRecipesDetailViewController ()<FCRecipesSegmentedViewDelegate>

@property (nonatomic, strong) FCRecipe *recipe;

@property (weak, nonatomic) IBOutlet FCRecipesSegmentedView *vSegment;
@property (weak, nonatomic) IBOutlet UIView *vContent;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgvFood;

// Constraints
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutAddButtom;

@end

@implementation FCRecipesDetailViewController

+ (NSString *)storyboardName {
    return @"Recipes";
}

+ (instancetype)viewControllerFromStoryboardWithRecipe:(FCRecipe *)recipe {
    FCRecipesDetailViewController *vc = [FCRecipesDetailViewController viewControllerFromStoryboard];
    vc.recipe = recipe;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _vSegment.delegate = self;
    
    [self createCustomBackItem];
    [self createSubViews];
    
    [self test1];
    [self test2];
    [self test3];
}

- (void)createSubViews {
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:_recipe.imageName_4 ofType:@"png"]];
    CGRect rect = CGRectMake(0, 0, kSCREEN_WIDTH, 263);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextFillRect(context, rect);
    [image drawInRect:rect];
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _imgvFood.image = im;
//    _imgvFood.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:_recipe.imageName_4 ofType:@"png"]];
    _labTitle.text = _recipe.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    if (IS_SS_IPHONE_X) {
        _layoutAddButtom.constant = 0;
    }
}

- (void)createCustomBackItem {
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setImage:[UIImage imageNamed:@"navbarItem_back_white"] forState:UIControlStateNormal];
    [btnBack setImage:[UIImage imageNamed:@"navbarItem_back_white"] forState:UIControlStateHighlighted];
    [btnBack addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    [btnBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(25);
        make.left.mas_equalTo(9);
        make.top.mas_equalTo(kSTATBAR_HEIGHT + (44.0 - 25.0) / 2.0);
    }];
    
    UIButton *btnFavourite = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnFavourite setImage:[UIImage imageNamed:@"icon_favourite_unlike"] forState:UIControlStateNormal];
    [btnFavourite setImage:[UIImage imageNamed:@"icon_favourite_like"] forState:UIControlStateSelected];
    [btnFavourite addTarget:self action:@selector(onClickFavouriteAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnFavourite setSelected:[[FCUser currentUser] isFavouriteRecipe:_recipe]];
    [self.view addSubview:btnFavourite];
    [btnFavourite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.trailing.mas_equalTo(-20);
        make.centerY.equalTo(btnBack.mas_centerY);
    }];
};

- (void)onClickFavouriteAction:(UIButton *)sender {
    [[FCUser currentUser] updateRecipe:_recipe isFavourite:!sender.isSelected];
    [sender setSelected:!sender.isSelected];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserUpdateFavouriteNotificationKey object:NSStringFromClass([self class])];
}

- (void)test1 {
    NSArray<NSDictionary<NSString *, NSString *> *> *array = @[@{@"title": @"3 ounces", @"value": @"spaghetti"},
                                                             @{@"title": @"1/2", @"value": @"ripe avocados"},
                                                             @{@"title": @"1/8 cup", @"value": @"basil leaves"},
                                                             @{@"title": @"1/2", @"value": @"freshly squeezed lemon juice"},
                                                             @{@"title": @"1/12 cup", @"value": @"olive oil"},
                                                             @{@"title": @"1/4 cup", @"value": @"cherry tomatoes, halved"},
                                                             @{@"title": @"1/8 cup", @"value": @"canned corn kernels"}];
    UIScrollView *sv = [_vContent viewWithTag:10];
    __block UILabel *labLast;
    [array enumerateObjectsUsingBlock:^(NSDictionary<NSString *,NSString *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *labTitle = [self getContentLabel];
        UILabel *labContent = [self getContentLabel];
        labTitle.text = obj[@"title"];
        labContent.text = obj[@"value"];
        [sv addSubview:labTitle];
        [sv addSubview:labContent];
        [labContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(127);
            make.width.mas_equalTo(kSCREEN_WIDTH - 141);
            if (labLast) {
                make.top.equalTo(labLast.mas_bottom).offset(5);
            } else {
                make.top.mas_equalTo(0);
            }
            if (idx == 6) {
                make.bottom.mas_equalTo(0);
            }
        }];
        [labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.height.mas_equalTo(20);
            make.top.equalTo(labContent.mas_top);
        }];
        labLast = labContent;
    }];
}

- (void)test2 {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 6;
    style.lineBreakMode = NSLineBreakByWordWrapping;
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:@"1. In a large pot of boiling salted water, cook pasta according to package instructions; drain well." attributes:@{
                                                                                                                                                                                                                           NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size: 14.0f],
                                                                                                                                                                                                                           NSForegroundColorAttributeName: [UIColor colorWithRed:99.0f / 255.0f green:99.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f],
                                                                                                                                                                                                                           NSParagraphStyleAttributeName:style
                                                                                                                                                                                                                           }];
    [attributedString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size: 18.0f] range:NSMakeRange(0, 2)];
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:@"2. To make the avocado sauce, combine avocados, basil, garlic and lemon juice in the bowl of a food processor; season with salt and pepper, to taste. With the motor running, add olive oil in a slow stream until emulsified; set aside." attributes:@{
                                                                                                                                                                                                                                                                                                                                                                   NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size: 14.0f],
                                                                                                                                                                                                                                                                                                                                                                   NSForegroundColorAttributeName: [UIColor colorWithRed:99.0f / 255.0f green:99.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f],
                                                                                                                                                                                                                                                                                                                                                                   NSParagraphStyleAttributeName:style
                                                                                                                                                                                                                                                                                                                                                                   }];
    [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size: 18.0f] range:NSMakeRange(0, 2)];
    NSMutableAttributedString *attributedString3 = [[NSMutableAttributedString alloc] initWithString:@"3. In a large bowl, combine pasta, avocado sauce, cherry tomatoes and corn." attributes:@{
                                                                                                                                                                                                 NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size: 14.0f],
                                                                                                                                                                                                 NSForegroundColorAttributeName: [UIColor colorWithRed:99.0f / 255.0f green:99.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f],
                                                                                                                                                                                                 NSParagraphStyleAttributeName:style
                                                                                                                                                                                                 }];
    [attributedString3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size: 18.0f] range:NSMakeRange(0, 2)];
    NSMutableAttributedString *attributedString4 = [[NSMutableAttributedString alloc] initWithString:@"4. Serve immediately" attributes:@{
                                                                                                                                         NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size: 14.0f],
                                                                                                                                         NSForegroundColorAttributeName: [UIColor colorWithRed:99.0f / 255.0f green:99.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f],
                                                                                                                                         NSParagraphStyleAttributeName:style
                                                                                                                                         }];
    [attributedString4 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size: 18.5f] range:NSMakeRange(0, 2)];
    
    UIScrollView *sv = [_vContent viewWithTag:11];
    NSArray<NSAttributedString *> *array = @[attributedString1,attributedString2,attributedString3,attributedString4];
    __block UILabel *labLast;
    [array enumerateObjectsUsingBlock:^(NSAttributedString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *labTitle = [self getContentLabel];
        labTitle.attributedText = obj;
        [sv addSubview:labTitle];
        [labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.width.mas_equalTo(kSCREEN_WIDTH - 28);
            if (labLast) {
                make.top.equalTo(labLast.mas_bottom).offset(10);
            } else {
                make.top.mas_equalTo(0);
            }
            if (idx == 3) {
                make.bottom.mas_equalTo(0);
            }
        }];
        labLast = labTitle;
    }];
}

- (void)test3 {
    NSArray<NSDictionary<NSString *, NSString *> *> *array = @[@{@"title": @"Calories:", @"value": @"670.7kcal"},
                                                               @{@"title": @"Fat:", @"value": @"34.2g"},
                                                               @{@"title": @"Carbohydrat:", @"value": @"80.7g"},
                                                               @{@"title": @"Protein:", @"value": @"14.3g"},
                                                               @{@"title": @"Calories:", @"value": @"670.7kcal"},
                                                               @{@"title": @"Fat:", @"value": @"34.2g"},
                                                               @{@"title": @"Carbohydrat:", @"value": @"80.7g"},
                                                               @{@"title": @"Protein:", @"value": @"14.3g"},
                                                               @{@"title": @"Calories:", @"value": @"670.7kcal"},
                                                               @{@"title": @"Fat:", @"value": @"34.2g"},
                                                               @{@"title": @"Carbohydrat:", @"value": @"80.7g"},
                                                               @{@"title": @"Protein:", @"value": @"14.3g"},
                                                               @{@"title": @"Calories:", @"value": @"670.7kcal"},
                                                               @{@"title": @"Fat:", @"value": @"34.2g"},
                                                               @{@"title": @"Carbohydrat:", @"value": @"80.7g"},
                                                               @{@"title": @"Protein:", @"value": @"14.3g"},
                                                               @{@"title": @"Calories:", @"value": @"670.7kcal"},
                                                               @{@"title": @"Fat:", @"value": @"34.2g"},
                                                               @{@"title": @"Carbohydrat:", @"value": @"80.7g"},
                                                               @{@"title": @"Protein:", @"value": @"14.3g"},
                                                               @{@"title": @"Calories:", @"value": @"670.7kcal"},
                                                               @{@"title": @"Fat:", @"value": @"34.2g"},
                                                               @{@"title": @"Carbohydrat:", @"value": @"80.7g"},
                                                               @{@"title": @"Protein:", @"value": @"14.3g"},
                                                               @{@"title": @"Calories:", @"value": @"670.7kcal"},
                                                               @{@"title": @"Fat:", @"value": @"34.2g"},
                                                               @{@"title": @"Carbohydrat:", @"value": @"80.7g"},
                                                               @{@"title": @"Protein:", @"value": @"14.3g"}];
    UIScrollView *sv = [_vContent viewWithTag:12];
    __block UILabel *labLast;
    [array enumerateObjectsUsingBlock:^(NSDictionary<NSString *,NSString *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *labTitle = [self getContentLabel];
        UILabel *labContent = [self getContentLabel];
        labContent.textAlignment = NSTextAlignmentRight;
        labTitle.text = obj[@"title"];
        labContent.text = obj[@"value"];
        [sv addSubview:labTitle];
        [sv addSubview:labContent];
        [labContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(127);
            make.width.mas_equalTo(kSCREEN_WIDTH - 141);
            if (labLast) {
                make.top.equalTo(labLast.mas_bottom).offset(5);
            } else {
                make.top.mas_equalTo(0);
            }
            if (idx == array.count - 1) {
                make.bottom.mas_equalTo(0);
            }
        }];
        [labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.height.mas_equalTo(20);
            make.top.equalTo(labContent.mas_top);
        }];
        
        labLast = labContent;
    }];
}

- (UILabel *)getContentLabel {
    UILabel *lab = [[UILabel alloc] init];
    lab.textColor = RGB(99, 99, 102);
    lab.font = kFont_16;
    lab.numberOfLines = 0;
    return lab;
}

- (IBAction)onClickAddShoppingListAction:(UIButton *)sender {
    NSLog(@"点击 - Add");
}


#pragma mark - FCRecipesSegmentedViewDelegate
- (void)recipesSegmentedView:(FCRecipesSegmentedView *)view didSelectedItemWithIndex:(NSInteger)index {
    UIScrollView *svLast = _vContent.subviews.lastObject;
    UIScrollView *svNext = [_vContent viewWithTag:index + 10];
    svNext.alpha = 0;
    [svNext setContentOffset:CGPointZero];
    [_vContent bringSubviewToFront:svNext];
    [UIView animateWithDuration:0.3 animations:^{
        svLast.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            svNext.alpha = 1;
        }];
    }];
}

#pragma mark - Override
- (BOOL)needsHiddenNavigationBar {
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end

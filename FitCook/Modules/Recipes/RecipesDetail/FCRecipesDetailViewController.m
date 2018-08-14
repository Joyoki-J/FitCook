//
//  FCRecipesDetailViewController.m
//  FitCook
//
//  Created by shanshan on 2018/7/31.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCRecipesDetailViewController.h"
#import "FCRecipesSegmentedView.h"
#import "FCParticleButton.h"
#import "FCDosageView.h"

@interface FCRecipesDetailViewController ()<FCRecipesSegmentedViewDelegate>

@property (nonatomic, strong) FCRecipe *recipe;

@property (weak, nonatomic) IBOutlet FCRecipesSegmentedView *vSegment;
@property (weak, nonatomic) IBOutlet UIView *vContent;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgvFood;

@property (nonatomic, strong) UIStepper *stepper;
@property (nonatomic, strong) UILabel *labServings;

// Constraints
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutAddButtom;

@property (nonatomic, assign) BOOL isStartAnimate;

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
    
    [self setIngredients];
    [self setSteps];
    [self setNutritions];
}

- (void)viewDidAppear:(BOOL)animated {
    if (!_isStartAnimate) {
        _isStartAnimate = YES;
        [self startAnimate];
    }
}

- (void)startAnimate {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:10 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.imgvFood.transform = CGAffineTransformTranslate(CGAffineTransformMakeScale(1.15, 1.15), -10, 10);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:10 delay:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.imgvFood.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf startAnimate];
            });
        }];
    }];
}

- (void)createSubViews {
    [_imgvFood fc_setImageWithName:_recipe.imageName_4];
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
    
    FCParticleButton *btnFavourite = [[FCParticleButton alloc] init];
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

- (void)onClickFavouriteAction:(FCParticleButton *)sender {
    [[FCUser currentUser] updateRecipe:_recipe isFavourite:!sender.isSelected];
    if (sender.selected) {
        [sender popInsideWithDuration:0.4f];
    } else {
        [sender popOutsideWithDuration:0.5f];
        [sender animate];
    }
    [sender setSelected:!sender.isSelected];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserUpdateFavouriteNotificationKey object:NSStringFromClass([self class])];
}

- (void)setIngredients {
    NSMutableArray<NSDictionary *> *array = [NSMutableArray array];
    [_recipe.ingredients enumerateObjectsUsingBlock:^(FCRecipeIngredient * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:@{@"title": obj.dosage ? obj.dosage : [NSNull null], @"value": obj.name}];
    }];
    UIScrollView *sv = [_vContent viewWithTag:10];
    
    UIView *vStep = [self createStep];
    [sv addSubview:vStep];
    [vStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(14);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(kSCREEN_WIDTH - 28);
    }];
    
    __block UIView *labLast = vStep;
    
    [array enumerateObjectsUsingBlock:^(NSDictionary<NSString *,NSString *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FCDosageView *labTitle = [[FCDosageView alloc] init];
        UILabel *labContent = [self getContentLabel];
        labTitle.tag = 100 + idx;
        [labTitle setTextWithDosage:(FCRecipeDosage *)obj[@"title"]];
        labContent.text = obj[@"value"];
        [sv addSubview:labTitle];
        [sv addSubview:labContent];
        [labContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(135);
            make.width.mas_equalTo(kSCREEN_WIDTH - 149);
            if (labLast) {
                make.top.equalTo(labLast.mas_bottom).offset(5);
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

- (UIView *)createStep {
    UIView *vStep = [[UIView alloc] init];
    vStep.backgroundColor = [UIColor whiteColor];
    
    UILabel *labServings = [[UILabel alloc] init];
    labServings.text = @"1 Servings";
    labServings.textAlignment = NSTextAlignmentLeft;
    labServings.textColor = RGB(99, 99, 102);
    labServings.font = kBoldFont(18);
    _labServings = labServings;
    [vStep addSubview:labServings];
    
    UIStepper *stepper = [[UIStepper alloc] init];
    stepper.minimumValue = 1;
    stepper.maximumValue = 100;
    stepper.value = 1;
    stepper.stepValue = 1;
    [stepper addTarget:self action:@selector(stepperChangedValue:) forControlEvents:UIControlEventValueChanged];
    _stepper = stepper;
    [vStep addSubview:stepper];
    
    [stepper mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(0);
        make.width.mas_equalTo(100);
    }];
    
    [labServings mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.trailing.equalTo(stepper.mas_leading).offset(-15);
    }];
    
    return vStep;
}

- (void)stepperChangedValue:(UIStepper *)stepper {
    NSInteger stepValue = (NSInteger)stepper.value;
    _labServings.text = [NSString stringWithFormat:@"%ld Servings",stepValue];
    
    UIScrollView *sv = [_vContent viewWithTag:10];
    [_recipe.ingredients enumerateObjectsUsingBlock:^(FCRecipeIngredient * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FCDosageView *labTitle = [sv viewWithTag:100 + idx];
        FCRecipeDosage *dosage = [obj.dosage mulNumber:stepValue];
        [labTitle setTextWithDosage:(id)(dosage ? dosage : [NSNull null])];
    }];
}

- (void)setSteps {
    NSMutableArray<NSAttributedString *> *array = [NSMutableArray array];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 6;
    style.lineBreakMode = NSLineBreakByWordWrapping;
    [_recipe.steps enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *string = [NSString stringWithFormat:@"%ld. %@",idx + 1, obj];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{
                                                                                                                                                                                                                              NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size: 14.0f],
                                                                                                                                                                                                                              NSForegroundColorAttributeName: [UIColor colorWithRed:99.0f / 255.0f green:99.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f],
                                                                                                                                                                                                                              NSParagraphStyleAttributeName:style
                                                                                                                                                                                                                              }];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size: 18.0f] range:NSMakeRange(0, 2)];
        [array addObject:attributedString];
    }];
    UIScrollView *sv = [_vContent viewWithTag:11];
    
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
            if (idx == array.count - 1) {
                make.bottom.mas_equalTo(0);
            }
        }];
        labLast = labTitle;
    }];
}

- (void)setNutritions {
    NSArray<NSDictionary<NSString *, NSString *> *> *array = @[@{@"title": @"Calories:",@"value": _recipe.nutrition.calories},
                                                               @{@"title": @"Fat:",@"value": _recipe.nutrition.fat},
                                                               @{@"title": @"Carbohydrat:",@"value": _recipe.nutrition.carbohydrates},
                                                               @{@"title": @"Protein:",@"value": _recipe.nutrition.protein},];
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
    if ([[FCUser currentUser] isAddedShoppingRecipe:_recipe]) {
        UIAlertController *vcAlert = [UIAlertController alertControllerWithTitle:@"Oops!" message:@"This recipe has already been added to your shopping list." preferredStyle:UIAlertControllerStyleAlert];
        [vcAlert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:vcAlert animated:YES completion:nil];
        
    } else {
        [[FCUser currentUser] addRecipeToShoppingList:_recipe withCount:(NSInteger)_stepper.value];
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserUpdateShoppingNotificationKey object:NSStringFromClass([self class])];
        [FCToast showText:@"The ingredients have been added to your shopping list."];
    }
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

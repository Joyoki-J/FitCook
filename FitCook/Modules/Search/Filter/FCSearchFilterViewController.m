//
//  FCSearchFilterViewController.m
//  FitCook
//
//  Created by Joyoki on 2018/8/2.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCSearchFilterViewController.h"
#import "FCModalTransition.h"
#import "FCSearchFilterView.h"

#define userid 100000
#define kSearchFilterTasteKey [NSString stringWithFormat:@"%ld_FilterTaste",(long)userid]

#define kSugarfree  @"0"
#define kDairyfree  @"1"
#define kVegetarian @"2"
#define kGlutenfree @"3"

@interface FCSearchFilterViewController ()<FCSearchFilterViewDelegate>

@property (nonatomic, strong) FCModalTransition *transition;

@property (weak, nonatomic) IBOutlet FCSearchFilterView *vFilterCategory;
@property (weak, nonatomic) IBOutlet FCSearchFilterView *vFilterDiet;
@property (weak, nonatomic) IBOutlet FCSearchFilterView *vFilterTaste;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutBottom;


@end

@implementation FCSearchFilterViewController

+ (NSString *)storyboardName {
    return @"Search";
}

+ (instancetype)viewControllerWithCustomTransition {
    FCModalTransition *transition = [[FCModalTransition alloc] init];
    FCSearchFilterViewController *vc = [[self class] viewControllerFromStoryboard];
    vc.transition = transition;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = transition;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBA(255, 255, 255, 98);
    
    _layoutTop.constant = kSTATBAR_HEIGHT;
    if (IS_SS_IPHONE_X) {
        _layoutBottom.constant = 0;
    }
    
    _vFilterCategory.delegate = self;
    _vFilterDiet.delegate     = self;
    _vFilterTaste.delegate    = self;
    
    [self setupDefaultData];
}

- (void)setupDefaultData {
    NSMutableSet *setIndexDiet = [NSMutableSet set];
    NSMutableSet *setIndexTaste = [NSMutableSet set];
    NSDictionary *dicTaste = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kSearchFilterTasteKey];
    if (dicTaste) {
        if ([[dicTaste objectForKey:kSugarfree] boolValue]) {
            [setIndexTaste addObject:@0];
            [setIndexDiet addObject:@1];
        }
        if ([[dicTaste objectForKey:kDairyfree] boolValue]) {
            [setIndexTaste addObject:@1];
            [setIndexDiet addObject:@2];
        }
        if ([[dicTaste objectForKey:kVegetarian] boolValue]) {
            [setIndexTaste addObject:@2];
            [setIndexDiet addObject:@3];
        }
        if ([[dicTaste objectForKey:kGlutenfree] boolValue]) {
            [setIndexTaste addObject:@3];
            [setIndexDiet addObject:@4];
        }
        if (setIndexDiet.count == 4) {
            [setIndexDiet removeAllObjects];
            [setIndexDiet addObject:@0];
        }
    } else {
        dicTaste = @{kSugarfree : @(NO),
                     kDairyfree : @(NO),
                     kVegetarian: @(NO),
                     kGlutenfree: @(NO)};
        [[NSUserDefaults standardUserDefaults] setObject:dicTaste forKey:kSearchFilterTasteKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    _vFilterDiet.selectedIndexs = setIndexDiet;
    _vFilterTaste.selectedIndexs = setIndexTaste;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickApplyFilterAction:(UIButton *)sender {
    
    __block NSMutableArray *arrTitles = [NSMutableArray array];
    
    NSArray<UIButton *> *arrFilterCategory = _vFilterCategory.arrFilter;
    [_vFilterCategory.selectedIndexs enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
        [arrTitles addObject:[[arrFilterCategory objectAtIndex:obj.integerValue] currentTitle]];
    }];
    if ([_vFilterDiet.selectedIndexs containsObject:@0]) {
        [_vFilterDiet.arrFilter enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx != 0) {
                [arrTitles addObject:[obj currentTitle]];
            }
        }];
    } else {
        NSArray<UIButton *> *arrFilterDiet = _vFilterDiet.arrFilter;
        [_vFilterDiet.selectedIndexs enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
            [arrTitles addObject:[[arrFilterDiet objectAtIndex:obj.integerValue] currentTitle]];
        }];
    }
    
    NSLog(@"选择了 = %@",arrTitles);
    
    [self close];
}

- (IBAction)onClickClearFilterAction:(UIButton *)sender {
    NSDictionary *dicTaste = @{kSugarfree : @(NO),
                               kDairyfree : @(NO),
                               kVegetarian: @(NO),
                               kGlutenfree: @(NO)};
    [[NSUserDefaults standardUserDefaults] setObject:dicTaste forKey:kSearchFilterTasteKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _vFilterCategory.selectedIndexs = nil;
    _vFilterDiet.selectedIndexs     = nil;
    _vFilterTaste.selectedIndexs    = nil;
    
    [self close];
}

- (void)close {
    if ([_delegate respondsToSelector:@selector(searchFilterViewControllerWillClose:)]) {
        [_delegate searchFilterViewControllerWillClose:self];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - FCSearchFilterViewDelegate
- (void)searchFilterView:(FCSearchFilterView *)view onClickItemWithIndex:(NSInteger)index {
    NSNumber *indexNum = @(index);
    if ([view.title isEqualToString:@"Category"]) { //Category
        if ([view.selectedIndexs containsObject:indexNum]) {
            view.selectedIndexs = [NSSet set];
        } else {
            view.selectedIndexs = [NSSet setWithObject:indexNum];
        }
    } else if ([view.title isEqualToString:@"Diet"]) { //Diet
        NSMutableDictionary *dicTaste = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:kSearchFilterTasteKey] mutableCopy];
        __block BOOL isSelectedAll = YES;
        [dicTaste.allValues enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![obj boolValue]) {
                isSelectedAll = NO;
                *stop = YES;
            }
        }];
        if (isSelectedAll) { return; }
        
        if (index == 0) {
            if ([view.selectedIndexs containsObject:indexNum]) {
                NSMutableSet *set = [NSMutableSet set];
                [dicTaste enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
                    if ([obj boolValue]) {
                        [set addObject:@([key integerValue] + 1)];
                    }
                }];
                view.selectedIndexs = set;
            } else {
                view.selectedIndexs = [NSSet setWithObject:indexNum];
            }
        } else {
            NSMutableSet<NSNumber *> *selectedIndexs = [view.selectedIndexs mutableCopy];
            if ([selectedIndexs containsObject:@0]) {
                [dicTaste setObject:@(YES) forKey:[NSString stringWithFormat:@"%ld",(long)(index - 1)]];
                __block BOOL isSelectedAll = YES;
                [dicTaste.allValues enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (![obj boolValue]) {
                        isSelectedAll = NO;
                        *stop = YES;
                    }
                }];
                if (isSelectedAll) { return; }
                [selectedIndexs removeObject:@0];
            }
            if ([selectedIndexs containsObject:indexNum]) {
                if ([[dicTaste objectForKey:[NSString stringWithFormat:@"%ld",(long)(index - 1)]] boolValue]) {
                    return;
                }
                [selectedIndexs removeObject:indexNum];
            } else {
                if (selectedIndexs.count + 1 == view.arrFilter.count - 1) {
                    [selectedIndexs removeAllObjects];
                    [selectedIndexs addObject:@0];
                } else {
                    [dicTaste enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
                        if ([obj boolValue]) {
                            [selectedIndexs addObject:@([key integerValue] + 1)];
                        }
                    }];
                    [selectedIndexs addObject:indexNum];
                }
            }
            view.selectedIndexs = selectedIndexs;
        }
    } else { //Taste
        NSMutableSet<NSNumber *> *selectedIndexs = [view.selectedIndexs mutableCopy];
        NSMutableDictionary *dicTaste = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:kSearchFilterTasteKey] mutableCopy];
        if ([selectedIndexs containsObject:indexNum]) {
            [selectedIndexs removeObject:indexNum];
            [dicTaste setObject:@(NO) forKey:[indexNum stringValue]];
            if (![_vFilterDiet.selectedIndexs containsObject:@0]) {
                NSMutableSet *set = [_vFilterDiet.selectedIndexs mutableCopy];
                [set removeObject:@(index + 1)];
                _vFilterDiet.selectedIndexs = set;
            }
        } else {
            [selectedIndexs addObject:indexNum];
            [dicTaste setObject:@(YES) forKey:[indexNum stringValue]];
            if (![_vFilterDiet.selectedIndexs containsObject:@0]) {
                __block BOOL isSelectedAll = YES;
                [dicTaste.allValues enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (![obj boolValue]) {
                        isSelectedAll = NO;
                        *stop = YES;
                    }
                }];
                if (isSelectedAll) {
                    _vFilterDiet.selectedIndexs = [NSSet setWithObject:@0];
                } else {
                    NSMutableSet *set = [_vFilterDiet.selectedIndexs mutableCopy];
                    [set addObject:@(index + 1)];
                    _vFilterDiet.selectedIndexs = set;
                }
            }
        }
        [[NSUserDefaults standardUserDefaults] setObject:dicTaste forKey:kSearchFilterTasteKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        view.selectedIndexs = selectedIndexs;
    }
}

@end

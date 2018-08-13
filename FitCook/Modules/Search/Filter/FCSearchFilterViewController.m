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

#define kSearchFilterTasteKey [NSString stringWithFormat:@"%@_FilterTaste",[FCUser currentUser].email]

#define kSugarfree  @"0"
#define kDairyfree  @"1"
#define kVegetarian @"2"
#define kGlutenfree @"3"

@interface FCSearchFilterViewController ()<FCSearchFilterViewDelegate>

@property (nonatomic, strong) FCModalTransition *transition;

@property (weak, nonatomic) IBOutlet FCSearchFilterView *vFilterCategory;
@property (weak, nonatomic) IBOutlet FCSearchFilterView *vFilterDiet;
@property (weak, nonatomic) IBOutlet FCSearchFilterView *vFilterTaste;

@property (nonatomic, strong) NSMutableDictionary<NSString *,NSNumber *> *dicTaste;

@property (nonatomic, strong) NSMutableSet<NSNumber *> *dSetCategory;
@property (nonatomic, strong) NSMutableSet<NSNumber *> *dSetDiet;

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
        _dicTaste = [dicTaste mutableCopy];
    } else {
        dicTaste = @{kSugarfree : @(NO),
                     kDairyfree : @(NO),
                     kVegetarian: @(NO),
                     kGlutenfree: @(NO)};
        [[NSUserDefaults standardUserDefaults] setObject:dicTaste forKey:kSearchFilterTasteKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _dicTaste = [dicTaste mutableCopy];
    }
    _vFilterCategory.selectedIndexs = _dSetCategory;
    _vFilterDiet.selectedIndexs = _dSetDiet.count > 0 ? _dSetDiet : setIndexDiet;
    _vFilterTaste.selectedIndexs = setIndexTaste;
}

- (void)setSelectedFilters:(NSArray<NSString *> *)filters {
    NSMutableSet<NSNumber *> *setCategory = [NSMutableSet set];
    NSMutableSet<NSNumber *> *setDiet = [NSMutableSet set];
    [filters enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[obj lowercaseString] isEqualToString:@"breakfast"]) {
            [setCategory addObject:@0];
        } else if ([[obj lowercaseString] isEqualToString:@"lunch"]) {
            [setCategory addObject:@1];
        } else if ([[obj lowercaseString] isEqualToString:@"dinner"]) {
            [setCategory addObject:@2];
        } else if ([[obj lowercaseString] isEqualToString:@"sugar-free"]) {
            [setDiet addObject:@1];
        } else if ([[obj lowercaseString] isEqualToString:@"dairy-free"]) {
            [setDiet addObject:@2];
        } else if ([[obj lowercaseString] isEqualToString:@"vegetarian"]) {
            [setDiet addObject:@3];
        } else if ([[obj lowercaseString] isEqualToString:@"gluten-free"]) {
            [setDiet addObject:@4];
        }
    }];
    if (setDiet.count >= 4) {
        [setDiet removeAllObjects];
        [setDiet addObject:@0];
    }
    _dSetCategory = setCategory;
    _dSetDiet = setDiet;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickApplyFilterAction:(UIButton *)sender {
    
    __block NSMutableArray *arrTitles = [NSMutableArray array];
    
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
    
    NSArray<UIButton *> *arrFilterCategory = _vFilterCategory.arrFilter;
    [_vFilterCategory.selectedIndexs enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
        [arrTitles addObject:[[arrFilterCategory objectAtIndex:obj.integerValue] currentTitle]];
    }];
    
    [[NSUserDefaults standardUserDefaults] setObject:_dicTaste forKey:kSearchFilterTasteKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([_delegate respondsToSelector:@selector(searchFilterViewController:didSelectedFilters:)]) {
        [_delegate searchFilterViewController:self didSelectedFilters:arrTitles];
    }
    
    [self close];
}

- (IBAction)onClickClearFilterAction:(UIButton *)sender {
    _dicTaste = [@{kSugarfree : @(NO),
                   kDairyfree : @(NO),
                   kVegetarian: @(NO),
                   kGlutenfree: @(NO)} mutableCopy];
    _vFilterCategory.selectedIndexs = [NSSet set];
    _vFilterDiet.selectedIndexs     = [NSSet set];
    _vFilterTaste.selectedIndexs    = [NSSet set];
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
        __block BOOL isSelectedAll = YES;
        [_dicTaste.allValues enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![obj boolValue]) {
                isSelectedAll = NO;
                *stop = YES;
            }
        }];
        if (isSelectedAll) { return; }
        
        if (index == 0) {
            if ([view.selectedIndexs containsObject:indexNum]) {
                NSMutableSet *set = [NSMutableSet set];
                [_dicTaste enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
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
                __block BOOL isSelectedAll = YES;
                [_dicTaste.allValues enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (![obj boolValue]) {
                        isSelectedAll = NO;
                        *stop = YES;
                    }
                }];
                if (isSelectedAll) { return; }
                [selectedIndexs removeObject:@0];
            }
            if ([selectedIndexs containsObject:indexNum]) {
                if ([[_dicTaste objectForKey:[NSString stringWithFormat:@"%ld",(long)(index - 1)]] boolValue]) {
                    return;
                }
                [selectedIndexs removeObject:indexNum];
            } else {
                if (selectedIndexs.count + 1 == view.arrFilter.count - 1) {
                    [selectedIndexs removeAllObjects];
                    [selectedIndexs addObject:@0];
                } else {
                    [_dicTaste enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
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
        if ([selectedIndexs containsObject:indexNum]) {
            [selectedIndexs removeObject:indexNum];
            [_dicTaste setObject:@(NO) forKey:[indexNum stringValue]];
            if (![_vFilterDiet.selectedIndexs containsObject:@0]) {
                NSMutableSet *set = [_vFilterDiet.selectedIndexs mutableCopy];
                [set removeObject:@(index + 1)];
                _vFilterDiet.selectedIndexs = set;
            }
        } else {
            [selectedIndexs addObject:indexNum];
            [_dicTaste setObject:@(YES) forKey:[indexNum stringValue]];
            if (![_vFilterDiet.selectedIndexs containsObject:@0]) {
                __block BOOL isSelectedAll = YES;
                [_dicTaste.allValues enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
        view.selectedIndexs = selectedIndexs;
    }
}

@end

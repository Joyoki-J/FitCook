//
//  FCSearchHeaderView.m
//  FitCook
//
//  Created by shanshan on 2018/8/5.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCSearchHeaderView.h"
#import "FCFilterView.h"

#define kSearchFilterTasteKey [NSString stringWithFormat:@"%@_FilterTaste",[FCUser currentUser].email]
#define kSugarfree  @"0"
#define kDairyfree  @"1"
#define kVegetarian @"2"
#define kGlutenfree @"3"

@interface FCSearchHeaderView()<FCFilterViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *vFilterBack;
@property (weak, nonatomic) IBOutlet FCFilterView *vFilter;
@property (weak, nonatomic) IBOutlet UIView *vFilterMore;

@property (nonatomic, strong) FCFilterStyle *style1;
@property (nonatomic, strong) FCFilterStyle *style2;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutBottom;

@end

@implementation FCSearchHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _keywords = [NSMutableArray array];
    
    _vFilter.delegate = self;
    
    _style1 = [[FCFilterStyle alloc] init];

    FCFilterStyle *style2 = [[FCFilterStyle alloc] init];
    style2.itemColor = RGBA(5, 5, 5, 5);
    style2.textColor = [UIColor whiteColor];
    style2.borderColor = [UIColor clearColor];
    style2.borderColorSelected = [UIColor whiteColor];
    _style2 = style2;
}

- (void)setProgress:(CGFloat)progress {
    
    if (_progress > 0.5 && progress <= 0.5) {
        [_vFilter updateStyle:_style2];
        _layoutBottom.constant = 0;
        [UIView animateWithDuration:0.25 animations:^{
            self.vFilterMore.layer.transform = CATransform3DMakeScale(0.01, 0.01, 1);
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.vFilterMore.layer.transform = CATransform3DMakeScale(0, 0, 1);
            self.vFilterMore.hidden = YES;
        }];
    } else if (_progress <= 0.5 && progress > 0.5) {
        [_vFilter updateStyle:_style1];
        self.vFilterMore.hidden = NO;
        _layoutBottom.constant = -14;
        [UIView animateWithDuration:0.25 animations:^{
            self.vFilterMore.layer.transform = CATransform3DMakeScale(1, 1, 1);
            [self layoutIfNeeded];
        }];
    }
    
    _vFilterBack.backgroundColor = RGBA(255, 255, 255, (12 * (1 - progress)));
    
    _progress = progress;
}

- (IBAction)onClickScanAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(searchHeaderDidClickScanAction:)]) {
        [_delegate searchHeaderDidClickScanAction:self];
    }
}

- (IBAction)onClickSeeAllFilterAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(searchHeaderDidClickSeeAllFilterAction:)]) {
        [_delegate searchHeaderDidClickSeeAllFilterAction:self];
    }
}

- (void)filterView:(FCFilterView *)view didSelectedIndexs:(NSArray<NSNumber *> *)indexs withTitles:(NSArray<NSString *> *)titles {
    [_keywords removeAllObjects];
    
    [_keywords addObjectsFromArray:titles];
    
    if ([_delegate respondsToSelector:@selector(searchHeaderDidSelectedFilter:)]) {
        [_delegate searchHeaderDidSelectedFilter:self];
    }
}

- (BOOL)filterView:(FCFilterView *)view willSelectedIndex:(NSInteger)index withTitle:(NSString *)title {
    NSDictionary *dicTaste = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kSearchFilterTasteKey];
    if (dicTaste) {
        if ([title isEqualToString:@"Sugar-free"]) {
            return ![[dicTaste objectForKey:kSugarfree] boolValue];
        } else if ([title isEqualToString:@"Dairy-free"]) {
            return ![[dicTaste objectForKey:kDairyfree] boolValue];
        } else if ([title isEqualToString:@"Vegetarian"]) {
            return ![[dicTaste objectForKey:kVegetarian] boolValue];
        } else if ([title isEqualToString:@"Gluten-free"]) {
            return ![[dicTaste objectForKey:kGlutenfree] boolValue];
        }
    }
    return YES;
}

- (void)setRecipeFilters:(NSArray<NSString *> *)filters {
    [_vFilter updateFilters:filters];
    [_keywords removeAllObjects];
    
    NSMutableArray *titles = [NSMutableArray array];
    [filters enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [titles addObject:[obj lowercaseString]];
    }];
    [_keywords addObjectsFromArray:titles];
    
    if ([_delegate respondsToSelector:@selector(searchHeaderDidSelectedFilter:)]) {
        [_delegate searchHeaderDidSelectedFilter:self];
    }
}

- (void)loadFilters {
    NSDictionary *dicTaste = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kSearchFilterTasteKey];
    [_keywords removeAllObjects];
    NSMutableArray<NSString *> *filters = [NSMutableArray array];
    if (dicTaste) {
        if ([[dicTaste objectForKey:kSugarfree] boolValue]) {
            [_keywords addObject:@"sugar-free"];
            [filters addObject:@"Sugar-free"];
        }
        if ([[dicTaste objectForKey:kDairyfree] boolValue]) {
            [_keywords addObject:@"dairy-free"];
            [filters addObject:@"Dairy-free"];
        }
        if ([[dicTaste objectForKey:kVegetarian] boolValue]) {
            [_keywords addObject:@"vegetarian"];
            [filters addObject:@"Vegetarian"];
        }
        if ([[dicTaste objectForKey:kGlutenfree] boolValue]) {
            [_keywords addObject:@"gluten-free"];
            [filters addObject:@"Gluten-free"];
        }
    }
    [_vFilter updateFilters:filters];
    if ([_delegate respondsToSelector:@selector(searchHeaderDidSelectedFilter:)]) {
        [_delegate searchHeaderDidSelectedFilter:self];
    }
}

- (NSArray<NSString *> *)getFilters {
    return _vFilter.titles;
}

@end

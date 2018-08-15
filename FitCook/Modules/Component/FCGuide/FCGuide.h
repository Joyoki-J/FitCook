//
//  FCGuide.h
//  FitCook
//
//  Created by shanshan on 2018/8/15.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCGuide : NSObject

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) NSInteger index;

- (void)showWithTarget:(UIView *)target completion:(void (^)(NSInteger index))completion;

- (void)hide:(void (^)(void))completion;

@end

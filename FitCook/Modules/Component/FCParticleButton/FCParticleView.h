//
//  FCParticleView.h
//  FitCook
//
//  Created by shanshan on 2018/8/12.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCParticleView : UIView

@property (nonatomic, strong) UIImage *particleImage;
@property (nonatomic, assign) CGFloat particleScale;
@property (nonatomic, assign) CGFloat particleScaleRange;

- (void)animate;

@end

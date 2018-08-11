//
//  FCParticleButton.m
//  FitCook
//
//  Created by Joyoki on 2018/8/12.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCParticleButton.h"
#import "FCParticleView.h"


@interface FCParticleButton()

@property (nonatomic, strong) FCParticleView *vParticle;

@end

@implementation FCParticleButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.clipsToBounds = NO;
    _vParticle = [[FCParticleView alloc] init];
    _vParticle.particleImage = [UIImage imageNamed:@"icon_emitter"];
    _vParticle.particleScale = 0.05f;
    _vParticle.particleScaleRange = 0.02f;
    [self insertSubview:_vParticle atIndex:0];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.vParticle.frame = self.bounds;
    [self insertSubview:self.vParticle atIndex:0];
}

#pragma mark - Methods
- (void)animate {
    [self.vParticle animate];
}

- (void)popOutsideWithDuration:(NSTimeInterval)duration {
    
    self.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations: ^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 3.0 animations: ^{
            self.transform = CGAffineTransformMakeScale(1.3f, 1.3f);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations: ^{
            self.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
        }];
        [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:1/3.0 animations: ^{
            self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        }];
    } completion:nil];
}

- (void)popInsideWithDuration:(NSTimeInterval)duration {
    
    self.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:duration delay:0 options:0 animations: ^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 2.0 animations: ^{
            self.transform = CGAffineTransformMakeScale(0.7f, 0.7f);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/2.0 relativeDuration:1/2.0 animations: ^{
            self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        }];
    } completion:nil];
}

@end

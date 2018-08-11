//
//  FCParticleView.m
//  FitCook
//
//  Created by Joyoki on 2018/8/12.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCParticleView.h"

@interface FCParticleView()

@property (nonatomic, strong) CAEmitterLayer *explosionLayer;
@property (nonatomic, strong) CAEmitterCell *explosionCell;

@end

@implementation FCParticleView

- (instancetype)initWithFrame:(CGRect)frame {
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
    self.userInteractionEnabled = NO;
   
    _explosionCell = [CAEmitterCell emitterCell];
    _explosionCell.name = @"explosion";
    _explosionCell.alphaRange = 0.5f;
    _explosionCell.alphaSpeed = -1.0f;
    _explosionCell.lifetime = 0.4f;
    _explosionCell.lifetimeRange = 0.8f;
    _explosionCell.birthRate = 0.f;
    _explosionCell.velocity = 30.0f;
    _explosionCell.velocityRange = 20.0f;
    
    _explosionLayer = [CAEmitterLayer layer];
    _explosionLayer.name = @"emitterLayer";
    _explosionLayer.emitterShape = kCAEmitterLayerCircle;
    _explosionLayer.emitterMode = kCAEmitterLayerOutline;
    _explosionLayer.emitterSize = CGSizeMake(20.f, 0.f);
    _explosionLayer.emitterCells = @[_explosionCell];
    _explosionLayer.renderMode = kCAEmitterLayerOldestFirst;
    _explosionLayer.masksToBounds = NO;
    [self.layer addSublayer:_explosionLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    self.explosionLayer.emitterPosition = center;
}

#pragma mark - Animate Methods
- (void)animate {
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC);
    dispatch_after(delay, dispatch_get_main_queue(), ^{
        self.explosionLayer.beginTime = CACurrentMediaTime();
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"emitterCells.explosion.birthRate"];
        animation.fromValue = @0;
        animation.toValue = @500;
        [self.explosionLayer addAnimation: animation forKey: nil];
    });
}

#pragma mark - Properties Method
- (void)setParticleImage:(UIImage *)particleImage {
    _particleImage = particleImage;
    self.explosionCell.contents = (id)[particleImage CGImage];
}

- (void)setParticleScale:(CGFloat)particleScale {
    _particleScale = particleScale;
    self.explosionCell.scale = particleScale;
}

- (void)setParticleScaleRange:(CGFloat)particleScaleRange {
    _particleScaleRange = particleScaleRange;
    self.explosionCell.scaleRange = particleScaleRange;
    
}

@end

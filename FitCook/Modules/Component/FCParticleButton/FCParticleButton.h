//
//  FCParticleButton.h
//  FitCook
//
//  Created by Joyoki on 2018/8/12.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCParticleButton : UIButton

- (void)animate;
- (void)popOutsideWithDuration:(NSTimeInterval)duration;
- (void)popInsideWithDuration:(NSTimeInterval)duration;


@end

//
//  FCParticleButton.h
//  FitCook
//
//  Created by shanshan on 2018/8/12.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCParticleButton : UIButton

- (void)animate;
- (void)popOutsideWithDuration:(NSTimeInterval)duration;
- (void)popInsideWithDuration:(NSTimeInterval)duration;


@end

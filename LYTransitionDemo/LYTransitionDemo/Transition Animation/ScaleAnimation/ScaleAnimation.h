//
//  ScaleAnimation.h
//  LYTransitionDemo
//
//  Created by LuYang on 16/1/6.
//  Copyright © 2016年 LuYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScaleAnimation : NSObject<UIViewControllerAnimatedTransitioning>
+ (instancetype)transitionWithTransitionType:(TransitionType) type andFrame:(CGRect) frame;
- (instancetype)initWithTransitionType:(TransitionType) type andFrame:(CGRect) frame;
@end

//
//  MoveAnimation.h
//  LYTransitionDemo
//
//  Created by LuYang on 16/1/6.
//  Copyright © 2016年 LuYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoveAnimation : NSObject<UIViewControllerAnimatedTransitioning>
+ (instancetype)transitionWithTransitionType:(TransitionType) type andIndexPath:(NSIndexPath *)indexPath beginFrame:(CGRect) frame;
- (instancetype)initWithTransitionType:(TransitionType) type andIndexPath:(NSIndexPath *)indexPath beginFrame:(CGRect) frame;
@end

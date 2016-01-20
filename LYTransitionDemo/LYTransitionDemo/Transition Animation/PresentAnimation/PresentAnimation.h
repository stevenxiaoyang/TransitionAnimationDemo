//
//  PresentAnimation.h
//  LYTransitionDemo
//
//  Created by LuYang on 15/12/22.
//  Copyright © 2015年 LuYang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PresentAnimation : UIViewController<UIViewControllerAnimatedTransitioning>
+ (instancetype)transitionWithTransitionType:(TransitionType) type;
- (instancetype)initWithTransitionType:(TransitionType) type;
@end

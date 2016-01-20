//
//  InteractiveTransition.h
//  LYTransitionDemo
//
//  Created by LuYang on 15/12/22.
//  Copyright © 2015年 LuYang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^GestureBlock)();

typedef NS_ENUM(NSUInteger, LYInteractiveGestureDirection) {//手势的方向
    LYInteractiveGestureDirectionLeft = 0,
    LYInteractiveGestureDirectionRight,
    LYInteractiveGestureDirectionUp,
    LYInteractiveGestureDirectionDown
};

typedef NS_ENUM(NSUInteger, LYInteractiveTransitionType) {//手势控制哪种转场
    LYInteractiveTransitionTypePresent = 0,
    LYInteractiveTransitionTypeDismiss,
    LYInteractiveTransitionTypePush,
    LYInteractiveTransitionTypePop
};

@interface InteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic, assign) BOOL interation;


@property (nonatomic, copy) GestureBlock PresentBlock;
@property (nonatomic, copy) GestureBlock PushBlock;


+ (instancetype)interactiveTransitionWithTransitionType:(LYInteractiveTransitionType)type GestureDirection:(LYInteractiveGestureDirection)direction;
- (instancetype)initWithTransitionType:(LYInteractiveTransitionType)type GestureDirection:(LYInteractiveGestureDirection)direction;
/*
 给传入的控制器添加手势
 */
- (void)addPanGestureForViewController:(UIViewController *)viewController;
@end

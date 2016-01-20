//
//  InteractiveTransition.m
//  LYTransitionDemo
//
//  Created by LuYang on 15/12/22.
//  Copyright © 2015年 LuYang. All rights reserved.
//

#import "InteractiveTransition.h"
@interface InteractiveTransition()
@property (nonatomic, weak) UIViewController *vc;
@property (nonatomic, assign) LYInteractiveGestureDirection direction;
@property (nonatomic, assign) LYInteractiveTransitionType type;
@end
@implementation InteractiveTransition
+ (instancetype)interactiveTransitionWithTransitionType:(LYInteractiveTransitionType)type GestureDirection:(LYInteractiveGestureDirection)direction{
    return [[self alloc] initWithTransitionType:type GestureDirection:direction];
}

- (instancetype)initWithTransitionType:(LYInteractiveTransitionType)type GestureDirection:(LYInteractiveGestureDirection)direction{
    self = [super init];
    if (self) {
        _direction = direction;
        _type = type;
    }
    return self;
}

-(void)addPanGestureForViewController:(UIViewController *)viewController
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    self.vc = viewController;
    [viewController.view addGestureRecognizer:pan];
}

/**
 *  手势过渡的过程
 */
- (void)handleGesture:(UIPanGestureRecognizer *)panGesture{
    //手势百分比
    CGFloat persent = 0;
    switch (_direction) {
        case LYInteractiveGestureDirectionLeft:{
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case LYInteractiveGestureDirectionRight:{
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case LYInteractiveGestureDirectionUp:{
            CGFloat transitionY = -[panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.height;
        }
            break;
        case LYInteractiveGestureDirectionDown:{
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.height;
        }
            break;
    }
    if (persent < 0) {
        return;
    }
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            //手势开始的时候标记手势状态，并开始相应的事件
            self.interation = YES;
            [self startGesture];
            break;
        case UIGestureRecognizerStateChanged:{
            //手势过程中，通过updateInteractiveTransition设置pop过程进行的百分比
                [self updateInteractiveTransition:persent];
            break;
        }
        case UIGestureRecognizerStateEnded:{
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作
            self.interation = NO;
            if (persent > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

- (void)startGesture{
    switch (_type) {
        case LYInteractiveTransitionTypePresent:{
            if (_PresentBlock) {
                _PresentBlock();
            }
        }
            break;
            
        case LYInteractiveTransitionTypeDismiss:
            [_vc dismissViewControllerAnimated:YES completion:nil];
            break;
        case LYInteractiveTransitionTypePush:{
            if (_PushBlock) {
                _PushBlock();
            }
        }
            break;
        case LYInteractiveTransitionTypePop:
            [_vc.navigationController popViewControllerAnimated:YES];
            break;
    }
}



@end

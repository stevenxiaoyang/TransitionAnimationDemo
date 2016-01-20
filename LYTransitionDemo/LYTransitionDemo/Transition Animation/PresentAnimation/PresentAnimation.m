//
//  PresentAnimation.m
//  LYTransitionDemo
//
//  Created by LuYang on 15/12/22.
//  Copyright © 2015年 LuYang. All rights reserved.
//

#import "PresentAnimation.h"
static const CGFloat kDefaultDuration = 2.f;  //默认动画时间
@interface PresentAnimation()
@property (nonatomic, assign)TransitionType type;
@property (nonatomic, weak)id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, weak)UIView *fromView;
@property (nonatomic, weak)UIView *toView;
@property (nonatomic, weak)UIView *containerView;
 @end
@implementation PresentAnimation
+ (instancetype)transitionWithTransitionType:(TransitionType) type
{
    return [[self alloc]initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(TransitionType) type
{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return kDefaultDuration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    _fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    _toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    _containerView = [transitionContext containerView];
    _transitionContext = transitionContext;
    
    switch (_type) {
        case TransitionTypeFront:
            [self presentAnimation];
            break;
        case TransitionTypeBack:
            [self dismissAnimation];
            break;
    }
}


/*
 实现present动画
 */
- (void)presentAnimation{
    UIView *tempView = [_fromView snapshotViewAfterScreenUpdates:NO];
    tempView.frame = _fromView.frame;
    _fromView.hidden = YES;
    
    _toView.frame = CGRectMake(0, _containerView.height, _containerView.width, 400);
    [_containerView addSubview:tempView];
    [_containerView addSubview:_toView];
    
    [UIView animateWithDuration:[self transitionDuration:_transitionContext] delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0/0.55 options:0 animations:^{
        _toView.transform = CGAffineTransformMakeTranslation(0, -400);
        tempView.transform = CGAffineTransformMakeScale(0.85, 0.85);
    } completion:^(BOOL finished) {
        if ([_transitionContext transitionWasCancelled]) {
            //动画失败
            _fromView.hidden = NO;
            [tempView removeFromSuperview];
        }
        [_transitionContext completeTransition:![_transitionContext transitionWasCancelled]];
    }];

}

/*
 实现dismiss动画
 */
- (void)dismissAnimation{
    UIView *tempView = _containerView.subviews[0];
    [UIView animateWithDuration:[self transitionDuration:_transitionContext] animations:^{
        tempView.transform = CGAffineTransformIdentity;
        _fromView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (![_transitionContext transitionWasCancelled]) {
            _toView.hidden = NO;
            [tempView removeFromSuperview];
        }
        [_transitionContext completeTransition:![_transitionContext transitionWasCancelled]];
    }];
}
@end

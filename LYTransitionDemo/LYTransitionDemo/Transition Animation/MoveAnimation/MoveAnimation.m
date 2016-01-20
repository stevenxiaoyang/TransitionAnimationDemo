//
//  MoveAnimation.m
//  LYTransitionDemo
//
//  Created by LuYang on 16/1/6.
//  Copyright © 2016年 LuYang. All rights reserved.
//

#import "MoveAnimation.h"
#import "MovingDetailViewController.h"
#import "MovingViewController.h"
static const CGFloat kDefaultDuration = 2.f;  //默认动画时间
@interface MoveAnimation()
@property (nonatomic, assign)TransitionType type;
@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic)CGRect beginFrame;
@property (nonatomic, weak)id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, weak)UIView *fromView;
@property (nonatomic, weak)UIView *toView;
@property (nonatomic, weak)UIView *containerView;
@property (nonatomic, weak)UIViewController *fromViewController;
@property (nonatomic, weak)UIViewController *toViewController;
@end
@implementation MoveAnimation
+ (instancetype)transitionWithTransitionType:(TransitionType) type andIndexPath:(NSIndexPath *)indexPath beginFrame:(CGRect)frame
{
    return [[self alloc]initWithTransitionType:type andIndexPath:indexPath beginFrame:frame];
}

- (instancetype)initWithTransitionType:(TransitionType) type andIndexPath:(NSIndexPath *)indexPath beginFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        _type = type;
        _indexPath = indexPath;
        _beginFrame = frame;
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
    _fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    _toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    _containerView = [transitionContext containerView];
    _transitionContext = transitionContext;
    
    switch (_type) {
        case TransitionTypeFront:
            [self pushAnimation];
            break;
        case TransitionTypeBack:
            [self popAnimation];
            break;
    }
}


/*
 实现push动画
 */
- (void)pushAnimation{
    UIImageView *fromImageView = [(MovingViewController *)_fromViewController getImageViewAtIndexPath:_indexPath];
    UIView *tempView = [fromImageView snapshotViewAfterScreenUpdates:NO];
    tempView.frame = _beginFrame;
    [_containerView addSubview:_toView];
    [_containerView addSubview:tempView];
    UIImageView *toImageView = ((MovingDetailViewController *)_toViewController).imageView;
    toImageView.hidden = YES;
    [UIView animateWithDuration:[self transitionDuration:_transitionContext] delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1/0.5 options:0 animations:^{
        tempView.frame = toImageView.frame;
    } completion:^(BOOL finished){
        toImageView.hidden = NO;
        tempView.hidden = YES;
        [_transitionContext completeTransition:![_transitionContext transitionWasCancelled]];
    }];
}

/*
 实现pop动画
 */
- (void)popAnimation{
    UIImageView *tempView = _containerView.subviews.lastObject;
    tempView.hidden = NO;
    [_containerView addSubview:_toView];
    [_containerView bringSubviewToFront:tempView];
    UIImageView *toImageView = [(MovingViewController *)_toViewController getImageViewAtIndexPath:_indexPath];
    toImageView.hidden = YES;
    [UIView animateWithDuration:[self transitionDuration:_transitionContext] delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:1/0.6 options:0 animations:^{
        tempView.frame = _beginFrame;
    } completion:^(BOOL finished) {
        [tempView removeFromSuperview];
        toImageView.hidden = NO;
        [_transitionContext completeTransition:![_transitionContext transitionWasCancelled]];
    }];
}

@end

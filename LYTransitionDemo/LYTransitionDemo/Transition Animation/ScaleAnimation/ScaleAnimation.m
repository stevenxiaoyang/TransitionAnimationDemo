//
//  ScaleAnimation.m
//  LYTransitionDemo
//
//  Created by LuYang on 16/1/6.
//  Copyright © 2016年 LuYang. All rights reserved.
//

#import "ScaleAnimation.h"
static const CGFloat kDefaultDuration = 2.f;  //默认动画时间
@interface ScaleAnimation()
@property (nonatomic, assign)TransitionType type;
@property (nonatomic)CGAffineTransform bigTransform;
@property (nonatomic)CGAffineTransform smallTransform;
@property (nonatomic, weak)id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, weak)UIView *fromView;
@property (nonatomic, weak)UIView *toView;
@property (nonatomic, weak)UIView *containerView;
@end
@implementation ScaleAnimation
+ (instancetype)transitionWithTransitionType:(TransitionType) type andFrame:(CGRect)frame
{
    return [[self alloc]initWithTransitionType:type andFrame:frame];
}

- (instancetype)initWithTransitionType:(TransitionType) type andFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        _type = type;
        [self initTransitionScale:frame];
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
            [self pushAnimation];
            break;
        case TransitionTypeBack:
            [self popAnimation];
            break;
    }
}

#pragma mark - Transition Init
-(void)initTransitionScale:(CGRect) frame
{
    CGFloat multipleX = SCREEN_WIDTH/frame.size.width;
    CGFloat multipleY = SCREEN_HEIGHT/frame.size.height;
    
    CGFloat translationX = SCREEN_WIDTH/2 - CGRectGetMidX(frame);
    CGFloat translationY = SCREEN_HEIGHT/2 - CGRectGetMidY(frame);
    
    CGAffineTransform bigTransformFirst = CGAffineTransformMakeScale(multipleX, multipleY);
    self.bigTransform = CGAffineTransformTranslate(bigTransformFirst, translationX, translationY);
    
    CGAffineTransform smallTransformFirst = CGAffineTransformMakeScale(1/multipleX,1/multipleY);
    self.smallTransform = CGAffineTransformTranslate(smallTransformFirst,-multipleX*translationX,-multipleY*translationY);
}

/*
 实现push动画
 */
- (void)pushAnimation{
    [_containerView addSubview:_toView];
    _toView.hidden = YES;
    [UIView animateWithDuration:[self transitionDuration:_transitionContext] animations:^{
        _fromView.transform = self.bigTransform;
    } completion:^(BOOL finished) {
        _toView.hidden = NO;
        _fromView.transform = CGAffineTransformIdentity;
        [_transitionContext completeTransition:![_transitionContext transitionWasCancelled]];
    }];
}

/*
 实现pop动画
 */
- (void)popAnimation{
    [_containerView addSubview:_toView];
    [_containerView bringSubviewToFront:_fromView];
    _toView.transform = _bigTransform;
    [UIView animateWithDuration:[self transitionDuration:_transitionContext] animations:^{
        _fromView.transform = _smallTransform;
        _toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        _fromView.transform = CGAffineTransformIdentity;
        [_transitionContext completeTransition:![_transitionContext transitionWasCancelled]];
    }];
}

@end

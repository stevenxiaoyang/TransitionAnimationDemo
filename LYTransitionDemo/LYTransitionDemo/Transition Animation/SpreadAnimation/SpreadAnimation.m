//
//  SpreadAnimation.m
//  LYTransitionDemo
//
//  Created by LuYang on 16/1/7.
//  Copyright © 2016年 LuYang. All rights reserved.
//

#import "SpreadAnimation.h"
static const CGFloat kDefaultDuration = 2.f;  //默认动画时间
@interface SpreadAnimation()
@property (nonatomic, assign)TransitionType type;
@property (nonatomic, weak)id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic) CGRect sourceFrame;
@property (nonatomic, weak)UIView *fromView;
@property (nonatomic, weak)UIView *toView;
@property (nonatomic, weak)UIView *containerView;
@end
@implementation SpreadAnimation
{
    CGFloat radius;
}
+ (instancetype)transitionWithTransitionType:(TransitionType) type andFrame:(CGRect)frame
{
    return [[self alloc]initWithTransitionType:type andFrame:frame];
}

- (instancetype)initWithTransitionType:(TransitionType) type andFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        _type = type;
        _sourceFrame = frame;
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
    [_containerView addSubview:_toView];
    CGFloat sourceX = _sourceFrame.origin.x + _sourceFrame.size.width/2;
    CGFloat sourceY = _sourceFrame.origin.y + _sourceFrame.size.height/2;
    CGFloat x = MAX(sourceX,SCREEN_WIDTH - sourceX);
    CGFloat y = MAX(sourceY,SCREEN_HEIGHT - sourceY);
    radius = sqrtf(powf(x, 2) + powf(y,2));
    
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
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:_sourceFrame];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:_fromView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.path = endPath.CGPath;
    _toView.layer.mask = maskLayer;
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    maskLayerAnimation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:_transitionContext];
    
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];

}

/*
 实现pop动画
 */
- (void)popAnimation{
    [_containerView addSubview:_toView];
    [_containerView bringSubviewToFront:_fromView];
    UIBezierPath *startPath = [UIBezierPath bezierPathWithArcCenter:_fromView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:_sourceFrame];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.path = endPath.CGPath;
    _fromView.layer.mask = maskLayer;
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    maskLayerAnimation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:_transitionContext];
    
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

#pragma mark  - Animation Delegate
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    switch (_type) {
        case TransitionTypeFront:
            if ([_transitionContext transitionWasCancelled]) {
                _toView.layer.mask = nil;
            }
            [_transitionContext completeTransition:![_transitionContext transitionWasCancelled]];            break;
        case TransitionTypeBack:
            if ([_transitionContext transitionWasCancelled]) {
                _fromView.layer.mask = nil;
            }
            [_transitionContext completeTransition:![_transitionContext transitionWasCancelled]];
            break;
    }
}

@end

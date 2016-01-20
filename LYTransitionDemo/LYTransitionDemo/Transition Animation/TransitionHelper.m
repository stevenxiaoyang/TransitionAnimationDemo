//
//  TransitionHelper.m
//  LYScaleTransition
//
//  Created by YiTe on 15/11/21.
//  Copyright © 2015年 LuYang. All rights reserved.
//

#import "TransitionHelper.h"
#import <objc/runtime.h>
#import "ScaleAnimation.h"
#import "PresentAnimation.h"
#import "MoveAnimation.h"
#import "SpreadAnimation.h"
#import "InteractiveTransition.h"
@interface TransitionHelper()
@property (nonatomic,strong)PresentBlock presentBK;
//手势
@property (nonatomic,strong)InteractiveTransition *interactivePresent;
@property (nonatomic,strong)InteractiveTransition *interactiveDismiss;


@end
@implementation TransitionHelper
+(TransitionHelper *)sharedInstance
{
    static TransitionHelper *_helper = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _helper = [[TransitionHelper alloc]init];
    });
    
    return _helper;
}

#pragma mark - UIViewController transitioning delegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    switch (_transitionType) {
        case LYTransitionTypePresent:
            return [PresentAnimation transitionWithTransitionType:TransitionTypeFront];
            break;
            
        case LYTransitionTypeScale:
            return [ScaleAnimation transitionWithTransitionType:TransitionTypeFront andFrame:_beginFrame];
            break;
        case LYTransitionTypeMove:
            return [MoveAnimation transitionWithTransitionType:TransitionTypeFront andIndexPath:_indexPath beginFrame:_beginFrame];
        case LYTransitionTypeSpread:
            return [SpreadAnimation transitionWithTransitionType:TransitionTypeFront andFrame:_beginFrame];
    }
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    switch (_transitionType) {
        case LYTransitionTypePresent:
            return [PresentAnimation transitionWithTransitionType:TransitionTypeBack];
            break;
            
        case LYTransitionTypeScale:
            return [ScaleAnimation transitionWithTransitionType:TransitionTypeBack andFrame:_beginFrame];
            break;
        case LYTransitionTypeMove:
            return [MoveAnimation transitionWithTransitionType:TransitionTypeBack andIndexPath:_indexPath beginFrame:_beginFrame];
        case LYTransitionTypeSpread:
            return [SpreadAnimation transitionWithTransitionType:TransitionTypeBack andFrame:_beginFrame];
    }
}

-(id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return self.interactiveDismiss.interation?self.interactiveDismiss:nil;
}

-(id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return self.interactivePresent.interation?self.interactivePresent:nil;
}

#pragma mark - UINavigationController delegate
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    TransitionType type = (operation == UINavigationControllerOperationPush)?TransitionTypeFront:TransitionTypeBack;
    if (_transitionType == LYTransitionTypeScale) {
        return [ScaleAnimation transitionWithTransitionType:type andFrame:_beginFrame];
    }
    else
    {
        return [MoveAnimation transitionWithTransitionType:type andIndexPath:_indexPath beginFrame:_beginFrame];
    }
    return nil;
}

#pragma mark - SetValue
-(void)setPresentViewController:(UIViewController *)presentViewController
{
    _presentViewController = presentViewController;
    [self.interactivePresent addPanGestureForViewController:presentViewController];
}

-(void)setDismissViewController:(UIViewController *)dismissViewController
{
    _dismissViewController = dismissViewController;
    [self.interactiveDismiss addPanGestureForViewController:dismissViewController];
}

-(void)setPresentBlock:(PresentBlock)presentBlock
{
    self.presentBK = presentBlock;
    __weak typeof(self) weak_self = self;
    self.interactivePresent.PresentBlock = ^(){
        weak_self.presentBK();
    };
}

#pragma mark -- InterAction
-(InteractiveTransition *)interactivePresent
{
    if (!_interactivePresent) {
        _interactivePresent = [InteractiveTransition interactiveTransitionWithTransitionType:LYInteractiveTransitionTypePresent GestureDirection:LYInteractiveGestureDirectionUp];
    }
    return _interactivePresent;
}

-(InteractiveTransition *)interactiveDismiss
{
    if (!_interactiveDismiss) {
        _interactiveDismiss = [InteractiveTransition interactiveTransitionWithTransitionType:LYInteractiveTransitionTypeDismiss GestureDirection:LYInteractiveGestureDirectionDown];
    }
    return _interactiveDismiss;
}
@end

static char kVCTransition;
@implementation UIViewController (LYTransition)

- (TransitionHelper *)transition{
    return objc_getAssociatedObject(self, &kVCTransition);
}

- (void)setTransition:(TransitionHelper *)transition{
    self.transitioningDelegate = transition;
    objc_setAssociatedObject(self, &kVCTransition, transition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

static char kNVTransition;
@implementation UINavigationController (LYTransition)

- (TransitionHelper *)navigationTransition{
    return objc_getAssociatedObject(self, &kNVTransition);
}

- (void)setNavigationTransition:(TransitionHelper *)navigationTransition{
    self.delegate = navigationTransition;
    objc_setAssociatedObject(self, &kNVTransition, navigationTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

//
//  TransitionHelper.h
//  LYScaleTransition
//
//  Created by YiTe on 15/11/21.
//  Copyright © 2015年 LuYang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,LYTransitionType)
{
    LYTransitionTypePresent = 0,
    LYTransitionTypeScale,
    LYTransitionTypeMove,
    LYTransitionTypeSpread,
};
typedef void (^PresentBlock)();
@interface TransitionHelper : NSObject<UINavigationControllerDelegate,UIViewControllerTransitioningDelegate>
+(TransitionHelper *)sharedInstance;
-(void)setPresentBlock:(PresentBlock) presentBlock;

@property (nonatomic,assign)LYTransitionType transitionType;
@property (nonatomic)CGRect beginFrame;
@property (nonatomic,strong) NSIndexPath *indexPath;
//用于手势,weak防止循环依赖
@property (nonatomic,weak)UIViewController *presentViewController;
@property (nonatomic,weak)UIViewController *dismissViewController;
@end

@interface UIViewController (LYTransition)

/**
 * 替代UIViewController的transitioningDelegate
 */
@property (strong, nonatomic) TransitionHelper *transition;

@end

@interface UINavigationController (LYTransition)

/**
 * 替代UINavigationController的delegate
 */
@property (strong, nonatomic) TransitionHelper *navigationTransition;

@end


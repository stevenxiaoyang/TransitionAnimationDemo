//
//  Header.h
//  LYTransitionDemo
//
//  Created by LuYang on 15/12/22.
//  Copyright © 2015年 LuYang. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/*
 所有动画都是两种,一种前进一种后退
 */
typedef NS_ENUM(NSUInteger,TransitionType) {
    TransitionTypeFront = 0,
    TransitionTypeBack
};

#endif /* Header_h */

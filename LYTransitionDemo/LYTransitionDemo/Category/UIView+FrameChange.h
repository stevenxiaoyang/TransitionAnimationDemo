//
//  UIView+FrameChange.h
//  肖文
//
//  Created by 肖文 on 15-7-13.
//  Copyright (c) 2015年 wazrx. All rights reserved.
//  提供快速更改frame的几个属性的方法

#import <UIKit/UIKit.h>

@interface UIView (FrameChange)
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic, readonly) CGFloat screenX;
@property (nonatomic, readonly) CGFloat screenY;
@property (nonatomic, readonly) CGFloat screenViewX;
@property (nonatomic, readonly) CGFloat screenViewY;
@property (nonatomic, readonly) CGRect screenFrame;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

@end

//
//  PresentedViewController.m
//  LYTransitionDemo
//
//  Created by LuYang on 15/12/22.
//  Copyright © 2015年 LuYang. All rights reserved.
//

#import "PresentedViewController.h"

@implementation PresentedViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我或向下滑动dismiss" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    button.size = CGSizeMake(300, 20);
    button.centerX = self.view.centerX;
    button.top = 30;
}

- (void)dismiss{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc
{
    NSLog(@"销毁了!");
}
@end

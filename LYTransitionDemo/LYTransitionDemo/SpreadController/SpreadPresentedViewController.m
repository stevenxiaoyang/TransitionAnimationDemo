//
//  SpreadPresentedViewController.m
//  LYTransitionDemo
//
//  Created by LuYang on 16/1/7.
//  Copyright © 2016年 LuYang. All rights reserved.
//

#import "SpreadPresentedViewController.h"

@interface SpreadPresentedViewController ()

@end

@implementation SpreadPresentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"009.jpg"]];
    imageView.frame = self.view.frame;
    [self.view addSubview:imageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我或向下滑动dismiss" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 50, self.view.frame.size.width, 50);
    [self.view addSubview:button];
}

-(void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc
{
    NSLog(@"销毁了!");
}
@end

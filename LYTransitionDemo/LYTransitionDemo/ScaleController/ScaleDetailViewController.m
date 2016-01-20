//
//  ScaleDetailViewController.m
//  LYTransitionDemo
//
//  Created by LuYang on 15/12/24.
//  Copyright © 2015年 LuYang. All rights reserved.
//

#import "ScaleDetailViewController.h"
#import "TransitionHelper.h"
@interface ScaleDetailViewController ()

@end

@implementation ScaleDetailViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self addImageView];
}

-(void)addImageView
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [imageView setImage:[UIImage imageNamed:self.imageName]];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pop)];
    [imageView addGestureRecognizer:tapGest];
    [self.view addSubview:imageView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationTransition = nil;
}

-(void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

//
//  MovingDetailViewController.m
//  LYTransitionDemo
//
//  Created by LuYang on 15/12/24.
//  Copyright © 2015年 LuYang. All rights reserved.
//

#import "MovingDetailViewController.h"
#import "TransitionHelper.h"
@implementation MovingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _imageView = [[UIImageView alloc]init];
    _imageView.frame = CGRectMake((SCREEN_WIDTH - 300)/2,74, 300, 250);
    _imageView.image = [UIImage imageNamed:self.imageName];
    [self.view addSubview:_imageView];
    
    UILabel *detailLabel = [UILabel new];
    [detailLabel setTextAlignment:NSTextAlignmentCenter];
    detailLabel.top = _imageView.bottom + 10;
    detailLabel.left = _imageView.left;
    [detailLabel setText:@"这是一幅美女图片"];
    [detailLabel sizeToFit];
    [self.view addSubview:detailLabel];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationTransition = nil;
}

@end

//
//  PresentingViewController.m
//  LYTransitionDemo
//
//  Created by LuYang on 15/12/22.
//  Copyright © 2015年 LuYang. All rights reserved.
//

#import "PresentingViewController.h"
#import "PresentedViewController.h"
#import "TransitionHelper.h"
@interface PresentingViewController()
@property (nonatomic,strong)UIImageView *picImageView;
@property (nonatomic,strong)UIButton *presentButton;
@end

@implementation PresentingViewController
{
    TransitionHelper *transitionHelper;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.picImageView];
    [self.view addSubview:self.presentButton];
    [self addSubViewFrame];
    
    transitionHelper = [TransitionHelper sharedInstance];
    transitionHelper.transitionType = LYTransitionTypePresent;
    transitionHelper.presentViewController = self;
    __weak typeof(self) weak_self = self;
    [transitionHelper setPresentBlock:^{
        [weak_self presentBottom];
    }];
}

-(void)addSubViewFrame
{
    self.picImageView.size = CGSizeMake(200, 200);
    self.picImageView.top = 74.f;
    self.picImageView.centerX = self.view.centerX;
    
    self.presentButton.size = CGSizeMake(300, 20);
    self.presentButton.top = self.picImageView.bottom + 20;
    self.presentButton.centerX = self.picImageView.centerX;
}

-(void)presentBottom
{
    PresentedViewController *vc = [PresentedViewController new];
    vc.transition = transitionHelper;
    vc.transition.dismissViewController = vc;
    [self presentViewController:vc animated:YES completion:nil];
}

-(UIImageView *)picImageView
{
    if (!_picImageView) {
        _picImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"000.jpg"]];
        _picImageView.layer.cornerRadius = 10.f;
        _picImageView.layer.masksToBounds = YES;
    }
    return _picImageView;
}

-(UIButton *)presentButton
{
    if (!_presentButton) {
        _presentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_presentButton setTitle:@"点我或者向上滑动" forState:UIControlStateNormal];
        [_presentButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [_presentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_presentButton addTarget:self action:@selector(presentBottom) forControlEvents:UIControlEventTouchUpInside];
    }
    return _presentButton;
}

@end

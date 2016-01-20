//
//  SpreadViewController.m
//  LYTransitionDemo
//
//  Created by LuYang on 16/1/7.
//  Copyright © 2016年 LuYang. All rights reserved.
//

#import "SpreadViewController.h"
#import "SpreadPresentedViewController.h"
#import "TransitionHelper.h"
@interface SpreadViewController ()
@property (nonatomic,weak)UIButton *spreadButton;
@end

@implementation SpreadViewController
{
    TransitionHelper *transitionHelper;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"008.jpg"]];
    imageView.frame = self.view.frame;
    [self.view addSubview:imageView];
    
    UIButton *spreadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    spreadButton.size = CGSizeMake(40, 40);
    spreadButton.center = self.view.center;
    [spreadButton setTitle:@"点击我\n拖动我" forState:UIControlStateNormal];
    spreadButton.titleLabel.numberOfLines = 2;
    spreadButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    spreadButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [spreadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [spreadButton addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    spreadButton.backgroundColor = [UIColor grayColor];
    spreadButton.layer.cornerRadius = 20;
    spreadButton.layer.masksToBounds = YES;
    [self.view addSubview:spreadButton];
    _spreadButton = spreadButton;
    
    UIPanGestureRecognizer *movePan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePan:)];
    [spreadButton addGestureRecognizer:movePan];
    
    transitionHelper = [TransitionHelper sharedInstance];
    transitionHelper.transitionType = LYTransitionTypeSpread;
    transitionHelper.presentViewController = self;
    __weak typeof(self) weak_self = self;
    [transitionHelper setPresentBlock:^{
        [weak_self present];
    }];
}

-(void)movePan:(UIPanGestureRecognizer *) gesture
{
    CGPoint translationPoint = [gesture translationInView:self.view];
    CGPoint buttonCenter = _spreadButton.center;
    CGPoint newPoint = CGPointMake(buttonCenter.x + translationPoint.x, buttonCenter.y + translationPoint.y);
    [gesture setTranslation:CGPointZero inView:self.view];
    /*
     防止超过边界
     应该用约束做
     */
    if (newPoint.x >= 20 && newPoint.x <= SCREEN_WIDTH - 20 && newPoint.y >= 84 && newPoint.y <= SCREEN_HEIGHT - 20) {
        _spreadButton.center = newPoint;
    }
}

-(void)present
{
    SpreadPresentedViewController *vc = [SpreadPresentedViewController new];
    transitionHelper.beginFrame = _spreadButton.frame;
    transitionHelper.dismissViewController = vc;
    vc.transition = transitionHelper;
    [self presentViewController:vc animated:YES completion:nil];
}

@end

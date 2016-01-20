//
//  RootViewController.m
//  LYTransitionDemo
//
//  Created by LuYang on 15/12/22.
//  Copyright © 2015年 LuYang. All rights reserved.
//

#import "RootViewController.h"
#import "TransitionHelper.h"
@interface RootViewController()
@property (nonatomic,strong)NSArray *cellTitleArray;
@property (nonatomic,strong)NSArray *classNameArray;
@end
@implementation RootViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"自定义转场动画";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
}

#pragma mark -- TableView Delegate DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellTitleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RootCellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RootCellID"];
    }
    cell.textLabel.text = self.cellTitleArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class pushClass = NSClassFromString(self.classNameArray[indexPath.row]);
    if ([pushClass isSubclassOfClass:[UIViewController class]]) {
        UIViewController *pushViewController = [[pushClass alloc] init];
        pushViewController.title = self.cellTitleArray[indexPath.row];
        [self.navigationController pushViewController:pushViewController animated:YES];
    }
}

#pragma mark -- Lazy Loading
-(NSArray *)cellTitleArray
{
    if (!_cellTitleArray) {
        _cellTitleArray = @[@"缩放移动",@"底部弹出",@"移动弹出",@"圆点扩散"];
    }
    return _cellTitleArray;
}

-(NSArray *)classNameArray
{
    if (!_classNameArray) {
        _classNameArray = @[@"ScaleViewController",@"PresentingViewController",@"MovingViewController",@"SpreadViewController"];
    }
    return _classNameArray;
}
@end

//
//  RecreationViewController.m
//  TodayTopLineDemo
//
//  Created by youmy on 16/6/8.
//  Copyright © 2016年 youmy. All rights reserved.
//  娱乐

#import "RecreationViewController.h"

@implementation RecreationViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    UILabel * label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"娱乐";
    [self.view addSubview:label];
}
@end

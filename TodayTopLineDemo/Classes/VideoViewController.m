//
//  VideoViewController.m
//  TodayTopLineDemo
//
//  Created by youmy on 16/6/6.
//  Copyright © 2016年 youmy. All rights reserved.
//  视频

#import "VideoViewController.h"

@implementation VideoViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    UILabel * label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"视频";
    [self.view addSubview:label];
}
@end

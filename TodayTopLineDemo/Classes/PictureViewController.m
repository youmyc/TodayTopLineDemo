//
//  PictureViewController.m
//  TodayTopLineDemo
//
//  Created by youmy on 16/6/8.
//  Copyright © 2016年 youmy. All rights reserved.
//  图片

#import "PictureViewController.h"

@implementation PictureViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    UILabel * label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"图片";
    [self.view addSubview:label];
}
@end

//
//  PlaceViewController.m
//  TodayTopLineDemo
//
//  Created by youmy on 16/6/8.
//  Copyright © 2016年 youmy. All rights reserved.
//  地区

#import "PlaceViewController.h"

@implementation PlaceViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    UILabel * label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"深圳";
    [self.view addSubview:label];
}
@end

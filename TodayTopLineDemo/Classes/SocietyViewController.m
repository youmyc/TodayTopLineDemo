//
//  SocietyViewController.m
//  TodayTopLineDemo
//
//  Created by youmy on 16/6/6.
//  Copyright © 2016年 youmy. All rights reserved.
//  社会

#import "SocietyViewController.h"

@implementation SocietyViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    UILabel * label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"社会";
    [self.view addSubview:label];
}
@end

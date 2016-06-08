//
//  RecommendViewController.m
//  TodayTopLineDemo
//
//  Created by youmy on 16/6/6.
//  Copyright © 2016年 youmy. All rights reserved.
//

#import "RecommendViewController.h"

@implementation RecommendViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UILabel * label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"推荐";
    [self.view addSubview:label];
}

@end

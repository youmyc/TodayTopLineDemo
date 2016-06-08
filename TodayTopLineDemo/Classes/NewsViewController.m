//
//  NewsViewController.m
//  TodayTopLineDemo
//
//  Created by youmy on 16/6/6.
//  Copyright © 2016年 youmy. All rights reserved.
//

#import "NewsViewController.h"
#import "RecommendViewController.h"
#import "HotViewController.h"
#import "PlaceViewController.h"
#import "VideoViewController.h"
#import "SocietyViewController.h"
#import "RSSViewController.h"
#import "RecreationViewController.h"
#import "PictureViewController.h"
#import "ScienceViewController.h"

static CGFloat const labelW = 80; // 标题Label宽度
static CGFloat const radio = 1.3; // 字体放大比例
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface NewsViewController ()<UIScrollViewDelegate>
/** 选中Label */
@property (nonatomic, weak) UILabel *selLabel;
/** label滚动视图 */
@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
/** 内容滚动视图 */
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
/** 标题Label数组 */
@property (nonatomic, strong) NSMutableArray * titleLabels;

@end

@implementation NewsViewController
#pragma mark - 懒加载
- (NSMutableArray *)titleLabels{
    if (_titleLabels == nil) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

#pragma mark - 系统相关
- (void)viewDidLoad{
    [super viewDidLoad];
    // 1.添加所有子控制器
    [self setupChildViewController];
    
    // 2.添加所有子控制器对应的标题
    [self setupTitleLabel];
    
    // iOS7会导航控制器所有的UIScrollView顶部添加额外滚动区域
    // 不想添加
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 3.初始化UIScrollView
    [self setupScrollView];
    
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    
    statusBarView.backgroundColor = [UIColor colorWithRed:0.6235 green:0.0824 blue:0.1098 alpha:1.0];
    
    [self.view addSubview:statusBarView];
}

#pragma mark - 私有方法

- (void)showViewcontrollerWithIndex:(NSInteger)index{
    CGFloat offsetX = index * SCREEN_WIDTH;
    // 1.获取对应子控制器
    UIViewController * vc = self.childViewControllers[index];
    
    // 2.判断子控制器的view是否已加载过
    if (vc.isViewLoaded) return;
    
    // 3.设置子控制器的view的frame
    vc.view.frame = CGRectMake(offsetX, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
    // 4.添加子控制器到contentScrollView中
    [self.contentScrollView addSubview:vc.view];
}

// 初始化UIScrollView
- (void)setupScrollView{
    // 获取子控制器数量
    NSUInteger count = self.childViewControllers.count;
    
    // 设置标题滚动视图的contentSize
    self.titleScrollView.contentSize = CGSizeMake(count * labelW, 0);
    
    // 取消水平滚动条
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    // 设置内容滚动视图的contentSize
    self.contentScrollView.contentSize = CGSizeMake(count * SCREEN_WIDTH, 0);
    
    // 开启分页
    self.contentScrollView.pagingEnabled = YES;
    
    // 取消弹簧效果
    self.contentScrollView.bounces = NO;
    
    // 取消水平滚动条
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    
    // 设置代理
    self.contentScrollView.delegate = self;
}

// 添加所有子控制器对应的标题
- (void)setupTitleLabel{
    NSUInteger count = self.childViewControllers.count;
    
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelH = 44;
    
    for (int i = 0; i < count; i++) {
        // 获取对应的子控制器
        UIViewController * vc = self.childViewControllers[i];
        
        // 创建label
        UILabel * label = [[UILabel alloc] init];
        labelX = i * labelW;
        
        // 添加到Label数组titleLabels中
        [self.titleLabels addObject:label];
        
        // 设置label尺寸
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        // 设置label的文字
        label.text = vc.title;
        
        // 设置label字体
        label.font = [UIFont systemFontOfSize:15];
        
        // 设置label文字颜色
        label.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
        
        // 设置label文字高亮颜色
        label.highlightedTextColor = [UIColor whiteColor];

        // 设置label的居中对齐
        label.textAlignment = NSTextAlignmentCenter;
        
        // 设置label的tag
        label.tag = i;
        
        // 设置用户交互
        label.userInteractionEnabled = YES;
        
        // 添加点按手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        [label addGestureRecognizer:tap];
        
        // 默认选中第0个
        if (i == 0) {
            [self titleClick:tap];
        }
        
        // 添加label到标题滚动条上
        [self.titleScrollView addSubview:label];
    }
}

// 点击标题的时候就会调用
- (void)titleClick:(UITapGestureRecognizer *)tap{
    
    // 0.获取选中的Label
    UILabel * selLabel = (UILabel *)tap.view;
    
    // 1.标题颜色变成红色，设置高亮状态下的颜色
    [self selectLabel:selLabel];
    
    // 2.滚动到对应的位置
    NSUInteger index = selLabel.tag;
    
    // 2.1计算滚动的位置
    CGFloat offsetX = selLabel.tag * SCREEN_WIDTH;
    self.contentScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 3.给对应的位置添加控制器
    [self showViewcontrollerWithIndex:index];
    
    // 滚动居中
    [self setupTitleCenter:selLabel];
}

// 选中的label
- (void)selectLabel:(UILabel *)label{
    // 取消高亮
    _selLabel.highlighted = NO;
    
    // 还原颜色设置
    _selLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
    
    // 取消形变
    _selLabel.transform = CGAffineTransformIdentity;
    
    // 设置高亮状态下的颜色
    label.highlighted = YES;
    
    // 文字放大
    label.transform = CGAffineTransformMakeScale(radio, radio);
    _selLabel = label;
}

// 添加所有子控制器
- (void)setupChildViewController{
    // 头条
    RecommendViewController * recommend = [[RecommendViewController alloc] init];
    recommend.title = @"推荐";
    [self addChildViewController:recommend];
    
    // 热点
    HotViewController * hot = [[HotViewController alloc] init];
    hot.title = @"热点";
    [self addChildViewController:hot];
    
    // 地区
    PlaceViewController * place = [[PlaceViewController alloc] init];
    place.title = @"深圳";
    [self addChildViewController:place];
    
    // 视频
    VideoViewController * video = [[VideoViewController alloc] init];
    video.title = @"视频";
    [self addChildViewController:video];
    
    // 社会
    SocietyViewController * society = [[SocietyViewController alloc] init];
    society.title = @"社会";
    [self addChildViewController:society];
    
    // 订阅
    RSSViewController * rss = [[RSSViewController alloc] init];
    rss.title = @"订阅";
    [self addChildViewController:rss];
    
    // 娱乐
    RecreationViewController * recreation = [[RecreationViewController alloc] init];
    recreation.title = @"娱乐";
    [self addChildViewController:recreation];
    
    // 图片
    PictureViewController * picture = [[PictureViewController alloc] init];
    picture.title = @"图片";
    [self addChildViewController:picture];
    
    // 科技
    ScienceViewController * science = [[ScienceViewController alloc] init];
    science.title = @"科技";
    [self addChildViewController:science];
}

// 让label居中
- (void)setupTitleCenter:(UILabel *)centerLabel{
    // 计算偏移量
    CGFloat offsetX = centerLabel.center.x - SCREEN_WIDTH * 0.5;
    
    if (offsetX < 0) offsetX = 0;
    
    // 获取最大的滚动范围
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - SCREEN_WIDTH;
    
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    
    // 滚动标题滚动条
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
// scrollView一滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    // 左边label角标
    NSInteger leftIndex = currentPage;
    
    // 右边label角标
    NSInteger rightIndex = currentPage + 1;
    
    // 获取左边的label
    UILabel * leftLabel = self.titleLabels[leftIndex];
    
    // 获取右边的label
    UILabel * rightLabel;
    if (rightIndex < self.titleLabels.count - 1) {
        rightLabel = self.titleLabels[rightIndex];
    }
    
    // 计算右边缩放比例
    CGFloat rightScale = currentPage - leftIndex;
    
    // 计算左边的缩放比例
    CGFloat leftScale = 1 - rightScale;
    
    // 左边缩放
    leftLabel.transform = CGAffineTransformMakeScale(leftScale * 0.3 + 1, leftScale * 0.3 + 1);
    
    // 右边缩放
    rightLabel.transform = CGAffineTransformMakeScale(rightScale * 0.3 + 1, rightScale * 0.3 + 1);
    
    // 设置左边文字颜色渐变
//    leftLabel.textColor = [UIColor colorWithRed:leftScale green:1 blue:1 alpha:0.6];
    
    // 设置右边文字颜色渐变
//    rightLabel.textColor = [UIColor colorWithRed:rightScale green:1 blue:1 alpha:0.6];
    
}

// scrollView减速完成后调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    // 1.添加对应子控制器
    [self showViewcontrollerWithIndex:index];
    
    // 2.把对应的标题选中
    UILabel * selLabel = self.titleLabels[index];
    
    [self selectLabel:selLabel];
    
    // 3.让选中的标题居中
    [self setupTitleCenter:selLabel];
}

@end

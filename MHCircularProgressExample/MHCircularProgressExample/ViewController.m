//
//  ViewController.m
//  MHCircularProgressExample
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 Mike_He. All rights reserved.
//

#import "ViewController.h"
#import "MHCircularProgressView.h"
#import "MHLabeledCircularProgressView.h"
@interface ViewController ()
/**
 *  圆环无进度
 */
@property (weak, nonatomic) IBOutlet MHCircularProgressView *annularNoProgress;
/**
 *  圆环有进度
 */
@property (weak, nonatomic) IBOutlet MHLabeledCircularProgressView *annularProgress;

/**
 *  圆形无进度
 */
@property (weak, nonatomic) IBOutlet MHCircularProgressView *circleNoProgress;
/**
 *  圆形有进度
 */
@property (weak, nonatomic) IBOutlet MHLabeledCircularProgressView *circleProgress;

/** 定时器 */
@property (nonatomic , strong) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    // 初始化进度条
    [self setupCircularProgress];
    
    // 开始动画
    [self startAnimation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (void) dealloc
{
    //关闭定时器
    [self stopAnimation];
}

#pragma mark - 初始化进度条
- (void) setupCircularProgress
{
    // 设置圆环 线头的样式
    self.annularNoProgress.annularLineCapStyle = kCGLineCapRound;
    // 设置圆环 线宽
    self.annularNoProgress.annularLineWith = 10.f;
    
    
    self.circleNoProgress.annular = NO;
    self.circleNoProgress.progressTintColor = [UIColor purpleColor];
    self.circleNoProgress.progressBackgroundColor = [UIColor lightGrayColor];
    
    
    self.annularProgress.annularLineCapStyle = kCGLineCapRound;
    self.annularProgress.annularLineWith = 5.f;
    self.annularProgress.clockwise = NO;
    self.annularProgress.progressTintColor = [UIColor yellowColor];
    
    self.circleProgress.annular = NO;
}



#pragma mark - 关闭定时器
- (void)stopAnimation
{
    if ([self.timer isValid])
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}


#pragma mark - 开启定时器
- (void)startAnimation
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.03
                                                  target:self
                                                selector:@selector(progressChange)
                                                userInfo:nil
                                                 repeats:YES];
    
}
#pragma mark - 进度条改变
- (void)progressChange
{
    CGFloat progress = self.annularNoProgress.progress + 0.01f;
    
    
    self.annularNoProgress.progress = progress;
    self.circleNoProgress.progress = progress;
    self.annularProgress.progress = progress;
    self.circleProgress.progress = progress;
    if (self.annularNoProgress.progress >= 1.0f )
    {
        self.annularNoProgress.progress = 0.f;
        self.circleNoProgress.progress = 0.f;
        self.annularProgress.progress = 0.f;
        self.circleProgress.progress = 0.f;
    }
    
    if (self.annularProgress)
    {
        self.annularProgress.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",roundf(self.annularProgress.progress *100.0)];
    }
    if (self.circleProgress)
    {
        self.circleProgress.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",roundf(self.circleProgress.progress *100.0)];
    }
}


@end

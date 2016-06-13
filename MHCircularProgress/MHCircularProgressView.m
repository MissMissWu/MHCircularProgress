//
//  MHCircularProgressView.m
//  MHCircularProgressView
//
//  Created by apple on 16/5/30.
//  Copyright © 2016年 Mike_He. All rights reserved.
//

#import "MHCircularProgressView.h"


/**
 *  线宽
 */
static const CGFloat kMHAnnularLineWith = 4.f;
/**
 *  线宽
 */
static const CGFloat kMHCicleLineWith = 4.f;

@interface MHCircularProgressView ()

@end

@implementation MHCircularProgressView


#pragma mark - 初始化
+ (void)initialize
{
    if (self == [self class])
    {
        //基础配置
        MHCircularProgressView *appearance = [MHCircularProgressView appearance];
        
        //设置进度展示类型
        [appearance setProgressType:MHCircularProgressViewTypeAnnular];
        
        //设置背景色
        [appearance setBackgroundTintColor:[[UIColor alloc] initWithWhite:1.f alpha:.1f]];
        
        //设置进度条的指示颜色
        [appearance setProgressTintColor:[[UIColor alloc] initWithWhite:1.f alpha:1.f]];
        
        //设置进度条的指示背景色 注意：必须showtype = MHCircularProgressViewTypeCircle 的情况下有效
        [appearance setProgressBackgroundColor:[[UIColor alloc] initWithWhite:1.f alpha:.1f]];
        
        //设置圆弧的两段的线头类型 注意：必须showtype = MHCircularProgressViewTypeAnnular 的情况下有效
        [appearance setAnnularLineCapStyle:kCGLineCapRound];
        
        //设置圆弧的线宽 注意：必须showtype = MHCircularProgressViewTypeCircle 的情况下有效
        [appearance setCircleLineWith:kMHCicleLineWith];
        
        //设置圆型填充的边缘的线宽 注意：必须showtype = MHCircularProgressViewShowTypeAnnular 的情况下有效
        [appearance setAnnularLineWith:kMHAnnularLineWith];
        
        //默认是顺时针
        [appearance setClockwiseProgress:YES];

    }
}


- (id)init
{
    // 设置默认的大小 37X37
    return [self initWithFrame:CGRectMake(0.f, 0.f, 37.f, 37.f)];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupBasicSetting];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupBasicSetting];
    }
    return self;
}

#pragma mark - 基础配置
- (void)setupBasicSetting
{
    self.backgroundColor = [UIColor clearColor];
    
    self.opaque = NO;
    
    _progress = 0.f;
    
    //添加KVO观察者
    [self registerForKVO];
}

- (void)dealloc
{
    [self unregisterFromKVO];
}

#pragma mark - Drawing
- (void)drawRect:(CGRect)rect
{
    if (self.progressType == MHCircularProgressViewTypeAnnular)   //圆环模式
    {
        //1. Draw background path
        // 圆环的宽度
        CGFloat lineWidth = self.annularLineWith;
        // 获取贝塞尔曲线路径对象 圆环的底图圆环
        UIBezierPath *progressBackgroundPath = [UIBezierPath bezierPath];
        // 线宽
        progressBackgroundPath.lineWidth = lineWidth;
        // 设置线条拐角帽的样式为圆形
        progressBackgroundPath.lineCapStyle = kCGLineCapRound;
        // 设置线条链接的样式为圆形
        progressBackgroundPath.lineJoinStyle = kCGLineJoinRound;
        // 设置中心点
        CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        // 圆弧半径
        CGFloat radius = (MIN(self.bounds.size.width,self.bounds.size.height) - lineWidth)/2;
        // 开始角度
        CGFloat startAngle = - ((float)M_PI / 2); // +90 degrees
        // 结束角度
        CGFloat endAngle = (2 * (float)M_PI) + startAngle;
        // 绘制圆弧
        [progressBackgroundPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:self.clockwiseProgress];
        // 设置圆弧背景的线条颜色
        [self.backgroundTintColor set];
        // 画线
        [progressBackgroundPath stroke];
        
        
        
        
        //2. Draw progress path
        // 获取进度的贝塞尔路径
        UIBezierPath *progressPath = [UIBezierPath bezierPath];
        // 设置线的拐角方式
        progressPath.lineCapStyle = self.annularLineCapStyle;
        // 设置线的连接方式
        progressPath.lineJoinStyle = kCGLineJoinRound;
        // 线宽
        progressPath.lineWidth = lineWidth;
        // 进度变化
        endAngle = (self.progress * 2 * (float)M_PI) + startAngle;
        // 画进度
        [progressPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:self.clockwiseProgress];
        // 设置进度圆弧的画笔颜色
        [self.progressTintColor set];
        // 画线
        [progressPath stroke];
   
    } else {
        CGRect allRect = self.bounds;
        
        CGFloat circleLineWidth = self.circleLineWith;
        
        // 以原rect为中心，再参考dx，dy，进行缩放或者放大
        CGRect circleRect = CGRectInset(allRect, circleLineWidth, circleLineWidth);
        //获取图形上下文
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //1. Draw background path
        // 设置线条的填充颜色
        [self.progressTintColor setStroke];
        // 设置原型的
        [self.backgroundTintColor setFill];
        
        //设置画笔宽度
        CGContextSetLineWidth(context, circleLineWidth);
        //画圆
        CGContextFillEllipseInRect(context, circleRect);
        //画圆弧
        CGContextStrokeEllipseInRect(context, circleRect);
        
        
        
        
        // 2.Draw progress path
        // 圆弧中心点
        CGPoint center = CGPointMake(allRect.size.width / 2, allRect.size.height / 2);
        //圆弧半径
        CGFloat radius = (MIN(allRect.size.width,allRect.size.height) - 2*circleLineWidth) / 2;
        //开始角度
        CGFloat startAngle = - ((float)M_PI / 2); // 90 degrees
        //结束角度
        CGFloat endAngle = (self.progress * 2 * (float)M_PI) + startAngle;
        //设置进度圆弧的颜色
        CGContextSetFillColorWithColor(context, self.progressBackgroundColor.CGColor);
        //绘制起始点
        CGContextMoveToPoint(context, center.x, center.y);
        
        int clockwise = self.clockwiseProgress!= 0?0:1;
    
        //绘制圆弧
        CGContextAddArc(context, center.x, center.y, radius, startAngle, endAngle, clockwise);
        //关闭路径
        CGContextClosePath(context);
        //画圆弧
        CGContextFillPath(context);
    }
    
    
}

#pragma mark - KVO
#pragma mark - 添加观察者
- (void)registerForKVO
{
    for (NSString *keyPath in [self observableKeypaths])
    {
        [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
    }
}
#pragma mark - 移除观察者
- (void)unregisterFromKVO
{
    for (NSString *keyPath in [self observableKeypaths])
    {
        [self removeObserver:self forKeyPath:keyPath];
    }
}

#pragma mark - 观察对象
- (NSArray *)observableKeypaths
{
    return [NSArray arrayWithObjects:
            @"progressTintColor",
            @"backgroundTintColor",
            @"progressBackgroundColor",
            @"annularLineCapStyle",
            @"annularLineWith",
            @"circleLineWith",
            @"progressType",
            @"clockwiseProgress",
            nil];
}



#pragma mark - 观察事件处理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 重新绘制
    [self setNeedsDisplay];
}





#pragma mark - 设置进度
- (void)setProgress:(CGFloat)progress
{
    [self setProgress:progress animated:NO];
}


- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [self setProgress:progress animated:animated initialDelay:0.0];
}

- (void)setProgress:(CGFloat)progress
           animated:(BOOL)animated
       initialDelay:(CFTimeInterval)initialDelay
{
    CGFloat pinnedProgress = MIN(MAX(progress, 0.0f), 1.0f);
    
    [self setProgress:progress
             animated:animated
         initialDelay:initialDelay
         withDuration:fabs(self.progress - pinnedProgress)];
}


- (void)setProgress:(CGFloat)progress
           animated:(BOOL)animated
       initialDelay:(CFTimeInterval)initialDelay
       withDuration:(CFTimeInterval)duration
{
    [self.layer removeAnimationForKey:@"progress"];
    
    CGFloat pinnedProgress = MIN(MAX(progress, 0.0f), 1.0f);
    if (animated)
    {
        // 基础动画
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progress"];
        // 动画时间
        animation.duration = duration;
        // 动画执行速率
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        // 设置保存动画的最新状态
        animation.fillMode = kCAFillModeForwards;
        // 设置动画执行完毕之后不删除动画
        animation.removedOnCompletion = NO;
        // 起始值
        animation.fromValue = [NSNumber numberWithFloat:self.progress];
        // 结束值
        animation.toValue = [NSNumber numberWithFloat:pinnedProgress];
        // 开始时间
        animation.beginTime = CACurrentMediaTime() + initialDelay;
        // 设置代理
        animation.delegate = self;
        // 添加动画
        [self.layer addAnimation:animation forKey:@"progress"];
    } else {
        
        _progress = progress;
        
        // 重新绘制
        [self setNeedsDisplay];
    }
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag
{
    NSNumber *pinnedProgressNumber = [animation valueForKey:@"toValue"];
    _progress = [pinnedProgressNumber floatValue];
    
    // 重新绘制
    [self setNeedsDisplay];
}

@end

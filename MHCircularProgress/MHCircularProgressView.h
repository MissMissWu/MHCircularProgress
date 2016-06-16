//
//  MHCircularProgressView.h
//  MHCircularProgressView
//
//  Created by apple on 16/5/30.
//  Copyright © 2016年 Mike_He. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef MH_STRONG
#if __has_feature(objc_arc)
#define MH_STRONG strong
#else
#define MH_STRONG retain
#endif
#endif


// 圆形进度 显示模式
typedef enum : NSUInteger {
    MHCircularProgressViewTypeAnnular = 10000,  //圆环状
    MHCircularProgressViewTypeCircle,           //圆形填充状
} MHCircularProgressViewType;




@interface MHCircularProgressView : UIView

/**
 * 进度指示颜色
 * Indicator progress color.
 * Defaults to white [[UIColor alloc] initWithWhite:1.f alpha:.1f]
 */
@property (nonatomic, MH_STRONG) UIColor *progressTintColor UI_APPEARANCE_SELECTOR;


/**
 * 没有进度的指示颜色
 * Indicator background (non-progress) color.
 * Defaults to translucent [[UIColor alloc] initWithWhite:1.f alpha:.1f]
 */
@property (nonatomic, MH_STRONG) UIColor *backgroundTintColor UI_APPEARANCE_SELECTOR;


/*
 * 圆环的的连接方式
 * when annular = YES. annularLineCapStyle is affect.
 * default is kCGLineCapRound
 */
@property (nonatomic, assign) CGLineCap annularLineCapStyle UI_APPEARANCE_SELECTOR;


/**
 * 圆环的线宽
 * when annular = YES annularLineWith is affect
 * default 4.0f
 */
@property (nonatomic, assign) CGFloat annularLineWith  UI_APPEARANCE_SELECTOR;


/**
 * 圆形填充进度条的 进度颜色
 * when annular = NO progressBackgroundColor is affect.
 * Defaults as white [[UIColor alloc] initWithWhite:1.f alpha:1.f]
 */
@property (nonatomic, MH_STRONG) UIColor *progressBackgroundColor UI_APPEARANCE_SELECTOR;


/**
 * 圆形填充进度条的线宽
 * when annular = NO annularLineWith is affect
 * default 4.0f
 */
@property (nonatomic, assign) CGFloat circleLineWith  UI_APPEARANCE_SELECTOR;


/** 
 *  显示进度的展示的模式
 *  default is YES
 *  Can not use BOOL with UI_APPEARANCE_SELECTOR
 */
@property (nonatomic , assign , getter=isAnnular) BOOL annular ;


/**
 * 进度显示方向 顺时针还是逆时针
 * default is YES
 */
@property (nonatomic , assign , getter=isClockwise) BOOL clockwise;



/**
 * 设置进度 Progress (0.0 to 1.0)  进度
 */
@property (nonatomic, assign) CGFloat progress;
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated initialDelay:(CFTimeInterval)initialDelay;
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated initialDelay:(CFTimeInterval)initialDelay withDuration:(CFTimeInterval)duration;


@end

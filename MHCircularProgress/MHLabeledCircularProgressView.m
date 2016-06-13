//
//  MHLabeledCircularProgressView.m
//  MHCircularProgress
//
//  Created by apple on 16/5/30.
//  Copyright © 2016年 Mike_He. All rights reserved.
//

#import "MHLabeledCircularProgressView.h"

static const CGFloat kMHProgressLabelFontSize = 12.f;


@implementation MHLabeledCircularProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupSubViews];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupSubViews];
    }
    return self;
}


#pragma mark - Internal methods

/**
 * 初始化子控件
 */
- (void)setupSubViews
{
    self.progressLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.progressLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.progressLabel.textColor = [UIColor whiteColor];
    self.progressLabel.font = [UIFont boldSystemFontOfSize:kMHProgressLabelFontSize];
    self.progressLabel.adjustsFontSizeToFitWidth = NO;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
    self.progressLabel.textAlignment = NSTextAlignmentCenter;
#else
    self.progressLabel.textAlignment = UITextAlignmentCenter;
#endif
    self.progressLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.progressLabel];
}


@end

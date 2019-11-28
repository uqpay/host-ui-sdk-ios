//
//  UIColor+UQUIK.h
//  UQPayHostUIKit
//
//  Created by uqpay on 2019/6/17.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (UQUIK)

/// Color with bytes and alpha
+ (instancetype)uquik_colorWithBytesR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b A:(NSInteger)a;

/// Color with bytes
+ (instancetype)uquik_colorWithBytesR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b;

/// Color from hex string with alpha
+ (instancetype)uquik_colorFromHex:(NSString *)hex alpha:(CGFloat)alpha;

/// Asjusts the brightness of a color
- (instancetype)uquik_adjustedBrightness:(CGFloat)adjustment;

@end

NS_ASSUME_NONNULL_END

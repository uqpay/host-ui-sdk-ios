//
//  SystemUtils.m
//  UQPayHostUI
//
//  Created by uqpay on 2019/7/4.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import "SystemUtils.h"

@implementation SystemUtils

+ (double)systemVersion {
    NSString* version = [UIDevice currentDevice].systemVersion;
    return version.doubleValue;
}

+ (CGFloat)SCREEN_WIDTH {
    return [[UIScreen mainScreen]bounds].size.width;
}

+ (CGFloat)SCREEN_HEIGHT {
    return [[UIScreen mainScreen]bounds].size.height;
}

@end

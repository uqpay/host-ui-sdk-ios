//
//  UQUIKCardExpirationValidator.h
//  UQPayHostUIKit
//
//  Created by uqpay on 2019/6/17.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kBTUIKCardExpirationValidatorFarFutureYears 20

@interface UQUIKCardExpirationValidator : NSObject

+ (BOOL)month:(NSUInteger)month year:(NSUInteger)year validForDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END

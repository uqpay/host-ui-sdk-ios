//
//  UQUIKCardExpiryFormat.h
//  UQPayHostUIKit
//
//  Created by uqpay on 2019/6/17.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UQUIKCardExpiryFormat : NSObject

@property (nonatomic, copy) NSString *value;
@property (nonatomic, assign) NSUInteger cursorLocation;
@property (nonatomic, assign) BOOL backspace;

- (void)formattedValue:(NSString * __autoreleasing *)value cursorLocation:(NSUInteger *)cursorLocation;

@end

NS_ASSUME_NONNULL_END

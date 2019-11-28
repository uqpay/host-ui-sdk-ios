//
//  UQUIKUtil.h
//  UQPayHostUIKit
//
//  Created by uqpay on 2019/6/17.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UQUIKUtil : NSObject

/// Checks if a card number is Luhn valid
///
/// @param cardNumber A string of numbers representing the card number
///
/// @return True ic the cardNumber is Luhn valid. False otherwise.
+ (BOOL)luhnValid:(NSString *)cardNumber;

/// Strips non-digit characters from a string.
///
/// @param input The string to strip.
///
/// @return The string stripped of non-digit characters, or `nil` if `input` is
/// `nil`
+ (NSString *)stripNonDigits:(NSString *)input;

/// Strips non-digit characters and '/' from a string.
///
/// @param input The string to strip.
///
/// @return The string stripped of non-digit characters and '/', or `nil` if `input` is
/// `nil`
+ (NSString *)stripNonExpiry:(NSString *)input;

@end

NS_ASSUME_NONNULL_END

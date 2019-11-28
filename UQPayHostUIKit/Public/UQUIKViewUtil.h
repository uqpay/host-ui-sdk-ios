//
//  UQUIKViewUtil.h
//  UQPayHostUIKit
//
//  Created by uqpay on 2019/6/17.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UQUIKCardType.h"
#import "UQUIKPaymentOptionType.h"
#import "UQUIKVisualAssetType.h"

NS_ASSUME_NONNULL_BEGIN

@class UQUIKVectorArtView;

/// Size for vector art
typedef NS_ENUM(NSInteger, UQUIKVectorArtSize) {
    /// Small
    UQUIKVectorArtSizeRegular,
    /// Large
    UQUIKVectorArtSizeLarge,
};

@interface UQUIKViewUtil : NSObject

#pragma mark UQUIKPaymentOptionType Utilities

/// Get a UQUIKPaymentOptionType from a string
///
/// @param typeString string representing a payment option type (e.g `Visa` or `PayPal`)
/// @return The UQUIKPaymentOptionType associated with the string if it can be found. Otherwise, UQUIKPaymentOptionTypeUnknown.
+ (UQUIKPaymentOptionType)paymentOptionTypeForPaymentInfoType:(NSString *)typeString;

/// Get a UQUIKPaymentOptionType from a UQUIKCardType
///
/// @param cardType A UQUIKCardType that represents a card
/// @return The UQUIKPaymentOptionType associated with the UQUIKCardType if it can be found. Otherwise, UQUIKPaymentOptionTypeUnknown.
+ (UQUIKPaymentOptionType)paymentMethodTypeForCardType:(UQUIKCardType *)cardType;

/// Determine if the payment option is a credit card type.
///
/// @param paymentOptionType A UQUIKPaymentOptionType
/// @return true if the payment option is a credit card type, false otherwise
+ (BOOL)isPaymentOptionTypeACreditCard:(UQUIKPaymentOptionType)paymentOptionType;

/// Get a localized string for a payment option.
///
/// @param paymentMethodType UQUIKPaymentOptionType
/// @return The localized string for the UQUIKPaymentOptionType if one can be found. `Card` will be returned in the case of UQUIKPaymentOptionTypeUnknown.
+ (NSString *)nameForPaymentMethodType:(UQUIKPaymentOptionType)paymentMethodType;

#pragma mark Helper Utilities

/// Cause the device to vibrate
+ (void)vibrate;

#pragma mark Art Utilities

/// Get a UQUIKVectorArtView from a string
///
/// @param typeString string representing a payment option type (e.g `Visa` or `PayPal`)
/// @return The UQUIKVectorArtView for the string if one can be found. Otherwise the art for a generic card.
+ (UQUIKVectorArtView *)vectorArtViewForPaymentInfoType:(NSString *)typeString;

/// Get a UQUIKVectorArtView for a payment option of UQUIKVectorArtIconSizeRegular.
///
/// @param type UQUIKPaymentOptionType
/// @return The UQUIKVectorArtView for the UQUIKPaymentOptionType if one can be found. Otherwise the art for a generic card.
+ (UQUIKVectorArtView *)vectorArtViewForPaymentOptionType:(UQUIKPaymentOptionType)type;

/// Get a UQUIKVectorArtView for a payment option.
///
/// @param type UQUIKPaymentOptionType
/// @param size The UQUIKVectorArtSize (Regular or Large)
/// @return The UQUIKVectorArtView for the UQUIKPaymentOptionType if one can be found. Otherwise the art for a generic card.
+ (UQUIKVectorArtView *)vectorArtViewForPaymentOptionType:(UQUIKPaymentOptionType)type size:(UQUIKVectorArtSize)size;

/*!
 @brief Get a UQUIKVectorArtView for a visual asset.
 
 @param type A UQUIKVisualAssetType
 @return The UQUIKVectorArtView for the UQUIKVisualAssetType if one can be found. Otherwise an empty UQUIKVectorArtView.
 */
+ (UQUIKVectorArtView *)vectorArtViewForVisualAssetType:(UQUIKVisualAssetType)type;

#pragma mark Right to Left Utilities

/// @return true if the language is right to left
+ (BOOL)isLanguageLayoutDirectionRightToLeft;
/// @return NSTextAlignmentRight if isLanguageLayoutDirectionRightToLeft is true. Ohterwise NSTextAlignmentLeft.
+ (NSTextAlignment)naturalTextAlignment;
/// @return NSTextAlignmentLeft if isLanguageLayoutDirectionRightToLeft is true. Ohterwise NSTextAlignmentRight.
+ (NSTextAlignment)naturalTextAlignmentInverse;

@end


NS_ASSUME_NONNULL_END

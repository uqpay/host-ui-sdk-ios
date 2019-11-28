//
//  UQUIKAppearance.h
//  UQPayHostUIKit
//
//  Created by uqpay on 2019/6/17.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UQUIKAppearance : NSObject

/// Shared instance used by Form elements
+ (instancetype) sharedInstance;

+ (void) darkTheme;
+ (void) lightTheme;

/// Fallback color for the overlay if blur is disabled
@property (nonatomic, strong) UIColor *overlayColor;
/// Tint color, defaults to 007aff
@property (nonatomic, strong) UIColor *tintColor;
/// Bar color
@property (nonatomic, strong) UIColor *barBackgroundColor;
/// Font family
@property (nonatomic, strong) NSString *fontFamily;
/// Bold font family
@property (nonatomic, strong) NSString *boldFontFamily;
/// Sheet background color
@property (nonatomic, strong) UIColor *formBackgroundColor;
/// Form field background color
@property (nonatomic, strong) UIColor *formFieldBackgroundColor;
/// Primary text color
@property (nonatomic, strong) UIColor *primaryTextColor;
/// Navigation title text color
/// Defaults to nil. When not set, navigation titles will use primaryTextColor
@property (nonatomic, strong) UIColor *navigationBarTitleTextColor;
/// Secondary text color
@property (nonatomic, strong) UIColor *secondaryTextColor;
/// Color of disabled buttons
@property (nonatomic, strong) UIColor *disabledColor;
/// Placeholder text color for form fields
@property (nonatomic, strong) UIColor *placeholderTextColor;
/// Line and border color
@property (nonatomic, strong) UIColor *lineColor;
/// Error foreground color
@property (nonatomic, strong) UIColor *errorForegroundColor;

@property (nonatomic, strong) UIColor *cardTitleColor;

@property (nonatomic, strong) UIColor *cardPlaceholderTextColor;

@property (nonatomic, strong) UIColor *sepLineColor;

@property (nonatomic, strong) UIFont *cardTitleFont;
/// Blur style
@property (nonatomic) UIBlurEffectStyle blurStyle;
/// Activity indicator style
@property (nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
/// Toggle blur effects
@property (nonatomic) BOOL useBlurs;
/// The keyboard the postal code field should use
@property (nonatomic) UIKeyboardType postalCodeFormFieldKeyboardType;
/// The highlighted version of the `tintColor`
@property (nonatomic, readonly, getter = highlightedTintColor) UIColor *highlightedTintColor;
/// Default Theme Color
@property (nonatomic) UIColor *defaultColor;
@property (nonatomic) UIColor *smsDisabledColor;
@property (nonatomic) UIColor *detailTitleColor;
@property (nonatomic) UIColor *defaultTableSepColor;
@property (nonatomic) UIColor *navigationBarBackItemColor;

/// Sets the color (primary or secondary) and font with family and size (large or small)
/// These properties are on the [BTUIKAppearance sharedInstance]
+ (void) styleLabelPrimary:(UILabel *) label;
+ (void) styleLabelBoldPrimary:(UILabel *) label;
+ (void) styleSmallLabelBoldPrimary:(UILabel *)label;
+ (void) styleSmallLabelPrimary:(UILabel *)label;
+ (void) styleLabelSecondary:(UILabel *)label;
+ (void) styleLargeLabelSecondary:(UILabel *)label;
+ (void) styleSystemLabelSecondary:(UILabel *)label;
+ (UILabel *) styledNavigationTitleLabel;

+ (float) horizontalFormContentPadding;
+ (float) formCellHeight;
+ (float) verticalFormSpace;
+ (float) spaceLineOfHeight;
+ (float) verticalFormSpaceTight;
+ (float) verticalSectionSpace;
+ (float) smallIconWidth;
+ (float) smallIconHeight;
+ (float) largeIconWidth;
+ (float) largeIconHeight;
+ (NSDictionary*)metrics;
@end

NS_ASSUME_NONNULL_END

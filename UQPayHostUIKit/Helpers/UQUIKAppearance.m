//
//  UQUIKAppearance.m
//  UQPayHostUIKit
//
//  Created by uqpay on 2019/6/17.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import "UQUIKAppearance.h"
#import "UIColor+UQUIK.h"

@implementation UQUIKAppearance
static UQUIKAppearance *sharedTheme;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedTheme == nil) {
            sharedTheme = [UQUIKAppearance new];
            [UQUIKAppearance lightTheme];
        }
    });
    
    return sharedTheme;
}

+ (void)lightTheme {
    sharedTheme.barBackgroundColor = [UIColor whiteColor];
    sharedTheme.overlayColor = [UIColor uquik_colorFromHex:@"000000" alpha:0.5];
    sharedTheme.tintColor = [UIColor uquik_colorFromHex:@"2489F6" alpha:1.0];
    sharedTheme.fontFamily = [UIFont systemFontOfSize:10].fontName;
    sharedTheme.boldFontFamily = [UIFont boldSystemFontOfSize:10].fontName;
    sharedTheme.formBackgroundColor = [UIColor groupTableViewBackgroundColor];
    sharedTheme.formFieldBackgroundColor = [UIColor whiteColor];
    sharedTheme.primaryTextColor = [UIColor blackColor];
    sharedTheme.secondaryTextColor = [UIColor uquik_colorFromHex:@"666666" alpha:1.0];
    sharedTheme.disabledColor = [UIColor lightGrayColor];
    sharedTheme.placeholderTextColor = [UIColor lightGrayColor];
    sharedTheme.lineColor = [UIColor uquik_colorFromHex:@"BFBFBF" alpha:1.0];
    sharedTheme.errorForegroundColor = [UIColor uquik_colorFromHex:@"ff3b30" alpha:1.0];
    sharedTheme.blurStyle = UIBlurEffectStyleExtraLight;
    sharedTheme.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    sharedTheme.useBlurs = YES;
    sharedTheme.postalCodeFormFieldKeyboardType = UIKeyboardTypeNumberPad;
    sharedTheme.cardTitleColor = [UIColor uquik_colorFromHex:@"333333" alpha:1.0];
    sharedTheme.detailTitleColor = [UIColor uquik_colorFromHex:@"3F3F3F" alpha:1.0];
    sharedTheme.defaultColor = [UIColor uquik_colorFromHex:@"4685f4" alpha:1.0];
    sharedTheme.smsDisabledColor = [UIColor uquik_colorFromHex:@"4685f4" alpha:0.5];
    sharedTheme.defaultTableSepColor = [UIColor uquik_colorFromHex:@"E5E5E5" alpha:1.0];
    sharedTheme.navigationBarBackItemColor = [UIColor uquik_colorFromHex:@"666666" alpha:1.0];
    sharedTheme.cardTitleFont = [UIFont systemFontOfSize:15.0];
    sharedTheme.cardPlaceholderTextColor = [UIColor uquik_colorFromHex:@"999999" alpha:1.0];
    sharedTheme.sepLineColor = [UIColor uquik_colorFromHex:@"E5E5E5" alpha:1.0];
}

+ (void)darkTheme {
    sharedTheme.overlayColor = [UIColor uquik_colorFromHex:@"000000" alpha:0.5];
    sharedTheme.tintColor = [UIColor uquik_colorFromHex:@"2489F6" alpha:1.0];
    sharedTheme.barBackgroundColor = [UIColor uquik_colorFromHex:@"222222" alpha:1.0];
    sharedTheme.fontFamily = [UIFont systemFontOfSize:10].fontName;
    sharedTheme.boldFontFamily = [UIFont boldSystemFontOfSize:10].fontName;
    sharedTheme.formBackgroundColor = [UIColor uquik_colorFromHex:@"222222" alpha:1.0];
    sharedTheme.formFieldBackgroundColor = [UIColor uquik_colorFromHex:@"333333" alpha:1.0];
    sharedTheme.primaryTextColor = [UIColor whiteColor];
    sharedTheme.secondaryTextColor = [UIColor uquik_colorFromHex:@"999999" alpha:1.0];
    sharedTheme.disabledColor = [UIColor lightGrayColor];
    sharedTheme.placeholderTextColor = [UIColor uquik_colorFromHex:@"8E8E8E" alpha:1.0];
    sharedTheme.lineColor = [UIColor uquik_colorFromHex:@"666666" alpha:1.0];
    sharedTheme.errorForegroundColor = [UIColor uquik_colorFromHex:@"ff3b30" alpha:1.0];
    sharedTheme.blurStyle = UIBlurEffectStyleDark;
    sharedTheme.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    sharedTheme.useBlurs = YES;
    sharedTheme.postalCodeFormFieldKeyboardType = UIKeyboardTypeNumberPad;
    sharedTheme.cardTitleColor = [UIColor uquik_colorFromHex:@"333333" alpha:1.0];
    sharedTheme.defaultColor = [UIColor uquik_colorFromHex:@"4685f4" alpha:1.0];
    sharedTheme.smsDisabledColor = [UIColor uquik_colorFromHex:@"4685f4" alpha:0.5];
    sharedTheme.detailTitleColor = [UIColor uquik_colorFromHex:@"3F3F3F" alpha:1.0];
    sharedTheme.defaultTableSepColor = [UIColor uquik_colorFromHex:@"E5E5E5" alpha:1.0];
    sharedTheme.navigationBarBackItemColor = [UIColor uquik_colorFromHex:@"666666" alpha:1.0];
    sharedTheme.cardTitleFont = [UIFont systemFontOfSize:15.0];
    sharedTheme.cardPlaceholderTextColor = [UIColor uquik_colorFromHex:@"999999" alpha:1.0];
    sharedTheme.sepLineColor = [UIColor uquik_colorFromHex:@"E5E5E5" alpha:1.0];
}

- (UIColor *)highlightedTintColor {
    return [sharedTheme.tintColor colorWithAlphaComponent:0.4];
}

+ (void)styleLabelPrimary:(UILabel *)label {
    label.font = [UIFont fontWithName:[UQUIKAppearance sharedInstance].fontFamily size:[UIFont labelFontSize]];
    label.textColor = [UQUIKAppearance sharedInstance].primaryTextColor;
}

+ (void)styleLabelBoldPrimary:(UILabel *)label {
    label.font = [UIFont fontWithName:[UQUIKAppearance sharedInstance].boldFontFamily size:[UIFont labelFontSize]];
    label.textColor = [UQUIKAppearance sharedInstance].primaryTextColor;
}

+ (void)styleSmallLabelBoldPrimary:(UILabel *)label {
    label.font = [UIFont fontWithName:[UQUIKAppearance sharedInstance].boldFontFamily size:[UIFont smallSystemFontSize]];
    label.textColor = [UQUIKAppearance sharedInstance].primaryTextColor;
}

+ (void)styleSmallLabelPrimary:(UILabel *)label {
    label.font = [UIFont fontWithName:[UQUIKAppearance sharedInstance].fontFamily size:[UIFont smallSystemFontSize]];
    label.textColor = [UQUIKAppearance sharedInstance].primaryTextColor;
}

+ (void)styleLabelSecondary:(UILabel *)label {
    label.font = [UIFont fontWithName:[UQUIKAppearance sharedInstance].fontFamily size:[UIFont smallSystemFontSize]];
    label.textColor = [UQUIKAppearance sharedInstance].secondaryTextColor;
}

+ (void) styleLargeLabelSecondary:(UILabel *)label {
    label.font = [UIFont fontWithName:[UQUIKAppearance sharedInstance].fontFamily size:[UIFont labelFontSize]];
    label.textColor = [UQUIKAppearance sharedInstance].secondaryTextColor;
}

+ (void)styleSystemLabelSecondary:(UILabel *)label {
    label.font = [UIFont fontWithName:[UQUIKAppearance sharedInstance].fontFamily size:[UIFont systemFontSize]];
    label.textColor = [UQUIKAppearance sharedInstance].secondaryTextColor;
}

+ (UILabel *)styledNavigationTitleLabel {
    UILabel *tlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 40)];
    tlabel.textAlignment = NSTextAlignmentCenter;
    tlabel.textColor = [UQUIKAppearance sharedInstance].navigationBarTitleTextColor;
    tlabel.font = [UIFont fontWithName:[UQUIKAppearance sharedInstance].boldFontFamily size:[UIFont labelFontSize]];
    tlabel.backgroundColor = [UIColor clearColor];
    tlabel.adjustsFontSizeToFitWidth = YES;
    tlabel.numberOfLines = 2;
    return tlabel;
}

+ (float)horizontalFormContentPadding {
    return 15.0f;
}

+ (float)formCellHeight {
    return 44.0f;
}

+ (float)spaceLineOfHeight {
    return 1.0f;
}

+ (float)verticalFormSpace {
    return 35.0f;
}

+ (float)verticalFormSpaceTight {
    return 10.0f;
}

+ (float)verticalSectionSpace {
    return 30.0f;
}

+ (float)smallIconWidth {
    return 45.0;
}

+ (float)smallIconHeight {
    return 29.0;
}

+ (float)largeIconWidth {
    return 100.0;
}

+ (float)largeIconHeight {
    return 100.0;
}

+ (NSDictionary*)metrics {
    static NSDictionary *sharedMetrics;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMetrics = @{@"HORIZONTAL_FORM_PADDING":@([UQUIKAppearance horizontalFormContentPadding]),
                          @"FORM_CELL_HEIGHT":@([UQUIKAppearance formCellHeight]),
                          @"VERTICAL_FORM_SPACE":@([UQUIKAppearance verticalFormSpace]),
                          @"VERTICAL_FORM_SPACE_TIGHT":@([UQUIKAppearance verticalFormSpaceTight]),
                          @"VERTICAL_SECTION_SPACE":@([UQUIKAppearance verticalSectionSpace]),
                          @"ICON_WIDTH":@([UQUIKAppearance smallIconWidth]),
                          @"ICON_HEIGHT":@([UQUIKAppearance smallIconHeight]),
                          @"LARGE_ICON_WIDTH":@([UQUIKAppearance largeIconWidth]),
                          @"LARGE_ICON_HEIGHT":@([UQUIKAppearance largeIconHeight])};
    });
    
    return sharedMetrics;
}

- (UIColor *)navigationBarTitleTextColor {
    return _navigationBarTitleTextColor != nil ? _navigationBarTitleTextColor : _primaryTextColor;
}

@end

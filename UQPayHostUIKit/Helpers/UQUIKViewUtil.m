//
//  UQUIKViewUtil.m
//  UQPayHostUIKit
//
//  Created by uqpay on 2019/6/17.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import "UQUIKViewUtil.h"
#import "UQUIKMasterCardVectorArtView.h"
#import "UQUIKJCBVectorArtView.h"
#import "UQUIKMaestroVectorArtView.h"
#import "UQUIKVisaVectorArtView.h"
#import "UQUIKDiscoverVectorArtView.h"
#import "UQUIKUnknownCardVectorArtView.h"
#import "UQUIKDinersClubVectorArtView.h"
#import "UQUIKAmExVectorArtView.h"
#import "UQUIKPayPalMonogramCardView.h"
#import "UQUIKCoinbaseMonogramCardView.h"
#import "UQUIKVenmoMonogramCardView.h"
#import "UQUIKUnionPayVectorArtView.h"
#import "UQUIKApplePayMarkVectorArtView.h"

#import "UQUIKLargeMasterCardVectorArtView.h"
#import "UQUIKLargeJCBVectorArtView.h"
#import "UQUIKLargeMaestroVectorArtView.h"
#import "UQUIKLargeVisaVectorArtView.h"
#import "UQUIKLargeDiscoverVectorArtView.h"
#import "UQUIKLargeUnknownCardVectorArtView.h"
#import "UQUIKLargeDinersClubVectorArtView.h"
#import "UQUIKLargeAmExVectorArtView.h"
#import "UQUIKLargePayPalMonogramCardView.h"
#import "UQUIKLargeCoinbaseMonogramCardView.h"
#import "UQUIKLargeVenmoMonogramCardView.h"
#import "UQUIKLargeUnionPayVectorArtView.h"
#import "UQUIKLargeApplePayMarkVectorArtView.h"

#import "UQUIKCVVBackVectorArtView.h"
#import "UQUIKCVVFrontVectorArtView.h"

@import AudioToolbox;

@implementation UQUIKViewUtil

+ (UQUIKPaymentOptionType)paymentMethodTypeForCardType:(UQUIKCardType *)cardType {
    
    if (cardType == nil) {
        return UQUIKPaymentOptionTypeUnknown;
    }
    
    if ([cardType.brand isEqualToString:UQUIKLocalizedString(CARD_TYPE_AMERICAN_EXPRESS)]) {
        return UQUIKPaymentOptionTypeAMEX;
    } else if ([cardType.brand isEqualToString:UQUIKLocalizedString(CARD_TYPE_VISA)]) {
        return UQUIKPaymentOptionTypeVisa;
    } else if ([cardType.brand isEqualToString:UQUIKLocalizedString(CARD_TYPE_MASTER_CARD)]) {
        return UQUIKPaymentOptionTypeMasterCard;
    } else if ([cardType.brand isEqualToString:UQUIKLocalizedString(CARD_TYPE_DISCOVER)]) {
        return UQUIKPaymentOptionTypeDiscover;
    } else if ([cardType.brand isEqualToString:UQUIKLocalizedString(CARD_TYPE_JCB)]) {
        return UQUIKPaymentOptionTypeJCB;
    } else if ([cardType.brand isEqualToString:UQUIKLocalizedString(CARD_TYPE_MAESTRO)]) {
        return UQUIKPaymentOptionTypeMaestro;
    } else if ([cardType.brand isEqualToString:UQUIKLocalizedString(CARD_TYPE_DINERS_CLUB)]) {
        return UQUIKPaymentOptionTypeDinersClub;
    } else if ([cardType.brand isEqualToString:UQUIKLocalizedString(CARD_TYPE_UNION_PAY)]) {
        return UQUIKPaymentOptionTypeUnionPay;
    } else {
        return UQUIKPaymentOptionTypeUnknown;
    }
}

+ (NSString *)nameForPaymentMethodType:(UQUIKPaymentOptionType)paymentMethodType {
    switch (paymentMethodType) {
        case UQUIKPaymentOptionTypeUnknown:
            return UQUIKLocalizedString(CARD_TYPE_GENERIC_CARD);
        case UQUIKPaymentOptionTypeAMEX:
            return UQUIKLocalizedString(CARD_TYPE_AMERICAN_EXPRESS);
        case UQUIKPaymentOptionTypeDinersClub:
            return UQUIKLocalizedString(CARD_TYPE_DINERS_CLUB);
        case UQUIKPaymentOptionTypeDiscover:
            return UQUIKLocalizedString(CARD_TYPE_DISCOVER);
        case UQUIKPaymentOptionTypeMasterCard:
            return UQUIKLocalizedString(CARD_TYPE_MASTER_CARD);
        case UQUIKPaymentOptionTypeVisa:
            return UQUIKLocalizedString(CARD_TYPE_VISA);
        case UQUIKPaymentOptionTypeJCB:
            return UQUIKLocalizedString(CARD_TYPE_JCB);
        case UQUIKPaymentOptionTypeLaser:
            return UQUIKLocalizedString(CARD_TYPE_GENERIC_CARD);
        case UQUIKPaymentOptionTypeMaestro:
            return UQUIKLocalizedString(CARD_TYPE_MAESTRO);
        case UQUIKPaymentOptionTypeUnionPay:
            return UQUIKLocalizedString(CARD_TYPE_UNION_PAY);
        case UQUIKPaymentOptionTypeSolo:
            return UQUIKLocalizedString(CARD_TYPE_GENERIC_CARD);
        case UQUIKPaymentOptionTypeSwitch:
            return UQUIKLocalizedString(CARD_TYPE_GENERIC_CARD);
        case UQUIKPaymentOptionTypeUKMaestro:
            return UQUIKLocalizedString(CARD_TYPE_MAESTRO);
        case UQUIKPaymentOptionTypePayPal:
            return UQUIKLocalizedString(PAYPAL);
        case UQUIKPaymentOptionTypeCoinbase:
            return UQUIKLocalizedString(BRANDING_COINBASE);
        case UQUIKPaymentOptionTypeVenmo:
            return UQUIKLocalizedString(BRANDING_VENMO);
        case UQUIKPaymentOptionTypeApplePay:
            return UQUIKLocalizedString(BRANDING_APPLE_PAY);
    }
}

+ (void)vibrate {
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}

#pragma mark Icons

+ (UQUIKPaymentOptionType)paymentOptionTypeForPaymentInfoType:(NSString *)typeString {
    if ([typeString isEqualToString:@"Visa"]) {
        return UQUIKPaymentOptionTypeVisa;
    } else if ([typeString isEqualToString:@"MasterCard"]) {
        return UQUIKPaymentOptionTypeMasterCard;
    } else if ([typeString isEqualToString:@"Coinbase"]) {
        return UQUIKPaymentOptionTypeCoinbase;
    } else if ([typeString isEqualToString:@"PayPal"]) {
        return UQUIKPaymentOptionTypePayPal;
    } else if ([typeString isEqualToString:@"DinersClub"]) {
        return UQUIKPaymentOptionTypeDinersClub;
    } else if ([typeString isEqualToString:@"JCB"]) {
        return UQUIKPaymentOptionTypeJCB;
    } else if ([typeString isEqualToString:@"Maestro"]) {
        return UQUIKPaymentOptionTypeMaestro;
    } else if ([typeString isEqualToString:@"Discover"]) {
        return UQUIKPaymentOptionTypeDiscover;
    } else if ([typeString isEqualToString:@"UKMaestro"]) {
        return UQUIKPaymentOptionTypeUKMaestro;
    } else if ([typeString isEqualToString:@"AMEX"] || [typeString isEqualToString:@"American Express"]) {
        return UQUIKPaymentOptionTypeAMEX;
    } else if ([typeString isEqualToString:@"Solo"]) {
        return UQUIKPaymentOptionTypeSolo;
    } else if ([typeString isEqualToString:@"Laser"]) {
        return UQUIKPaymentOptionTypeLaser;
    } else if ([typeString isEqualToString:@"Switch"]) {
        return UQUIKPaymentOptionTypeSwitch;
    } else if ([typeString isEqualToString:@"UnionPay"]) {
        return UQUIKPaymentOptionTypeUnionPay;
    } else if ([typeString isEqualToString:@"Venmo"]) {
        return UQUIKPaymentOptionTypeVenmo;
    } else if ([typeString isEqualToString:@"ApplePay"]) {
        return UQUIKPaymentOptionTypeApplePay;
    } else {
        return UQUIKPaymentOptionTypeUnknown;
    }
}

+ (BOOL)isPaymentOptionTypeACreditCard:(UQUIKPaymentOptionType)paymentOptionType {
    switch(paymentOptionType) {
        case UQUIKPaymentOptionTypeVisa:
        case UQUIKPaymentOptionTypeMasterCard:
        case UQUIKPaymentOptionTypeDinersClub:
        case UQUIKPaymentOptionTypeJCB:
        case UQUIKPaymentOptionTypeMaestro:
        case UQUIKPaymentOptionTypeDiscover:
        case UQUIKPaymentOptionTypeUKMaestro:
        case UQUIKPaymentOptionTypeAMEX:
        case UQUIKPaymentOptionTypeSolo:
        case UQUIKPaymentOptionTypeLaser:
        case UQUIKPaymentOptionTypeSwitch:
        case UQUIKPaymentOptionTypeUnionPay:
            return YES;
        default:
            return NO;
    }
}

+ (UQUIKVectorArtView *)vectorArtViewForPaymentInfoType:(NSString *)typeString {
    return [self vectorArtViewForPaymentOptionType:[self.class paymentOptionTypeForPaymentInfoType:typeString]];
}

+ (UQUIKVectorArtView *)vectorArtViewForPaymentOptionType:(UQUIKPaymentOptionType)type {
    return [self vectorArtViewForPaymentOptionType:type size:UQUIKVectorArtSizeRegular];
}

+ (UQUIKVectorArtView *)vectorArtViewForPaymentOptionType:(UQUIKPaymentOptionType)type size:(UQUIKVectorArtSize)size {
    switch (type) {
        case UQUIKPaymentOptionTypeVisa:
            return size == UQUIKVectorArtSizeRegular ? [UQUIKVisaVectorArtView new] : [UQUIKLargeVisaVectorArtView new];
        case UQUIKPaymentOptionTypeMasterCard:
            return size == UQUIKVectorArtSizeRegular ? [UQUIKMasterCardVectorArtView new] : [UQUIKLargeMasterCardVectorArtView new];
        case UQUIKPaymentOptionTypeCoinbase:
            return size == UQUIKVectorArtSizeRegular ? [UQUIKCoinbaseMonogramCardView new] : [UQUIKLargeCoinbaseMonogramCardView new];
        case UQUIKPaymentOptionTypePayPal:
            return size == UQUIKVectorArtSizeRegular ? [UQUIKPayPalMonogramCardView new] : [UQUIKLargePayPalMonogramCardView new];
        case UQUIKPaymentOptionTypeDinersClub:
            return size == UQUIKVectorArtSizeRegular ? [UQUIKDinersClubVectorArtView new] : [UQUIKLargeDinersClubVectorArtView new];
        case UQUIKPaymentOptionTypeJCB:
            return size == UQUIKVectorArtSizeRegular ? [UQUIKJCBVectorArtView new] : [UQUIKLargeJCBVectorArtView new];
        case UQUIKPaymentOptionTypeMaestro:
            return size == UQUIKVectorArtSizeRegular ? [UQUIKMaestroVectorArtView new] : [UQUIKLargeMaestroVectorArtView new];
        case UQUIKPaymentOptionTypeDiscover:
            return size == UQUIKVectorArtSizeRegular ? [UQUIKDiscoverVectorArtView new] : [UQUIKLargeDiscoverVectorArtView new];
        case UQUIKPaymentOptionTypeUKMaestro:
            return size == UQUIKVectorArtSizeRegular ? [UQUIKMaestroVectorArtView new] : [UQUIKLargeMaestroVectorArtView new];
        case UQUIKPaymentOptionTypeAMEX:
            return size == UQUIKVectorArtSizeRegular ? [UQUIKAmExVectorArtView new] : [UQUIKLargeAmExVectorArtView new];
        case UQUIKPaymentOptionTypeVenmo:
            return size == UQUIKVectorArtSizeRegular ? [UQUIKVenmoMonogramCardView new] : [UQUIKLargeVenmoMonogramCardView new];
        case UQUIKPaymentOptionTypeUnionPay:
            return size == UQUIKVectorArtSizeRegular ? [UQUIKUnionPayVectorArtView new] : [UQUIKLargeUnionPayVectorArtView new];
        case UQUIKPaymentOptionTypeApplePay:
            // No large apple pay
            return [UQUIKApplePayMarkVectorArtView new];
        case UQUIKPaymentOptionTypeSolo:
        case UQUIKPaymentOptionTypeLaser:
        case UQUIKPaymentOptionTypeSwitch:
        case UQUIKPaymentOptionTypeUnknown:
            return size == UQUIKVectorArtSizeRegular ? [UQUIKUnknownCardVectorArtView new] : [UQUIKLargeUnknownCardVectorArtView new];
    }
}

+ (UQUIKVectorArtView *)vectorArtViewForVisualAssetType:(UQUIKVisualAssetType)type {
    switch (type) {
        case UQUIKVisualAssetTypeCVVFront:
            return [UQUIKCVVFrontVectorArtView new];
        case UQUIKVisualAssetTypeCVVBack:
            return [UQUIKCVVBackVectorArtView new];
        case UQUIKVisualAssetTypeUnknown:
            return [UQUIKVectorArtView new];
    }
}

+ (BOOL)isLanguageLayoutDirectionRightToLeft
{
    return [UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;
}

+ (NSTextAlignment)naturalTextAlignment
{
    return [self isLanguageLayoutDirectionRightToLeft] ? NSTextAlignmentRight : NSTextAlignmentLeft;
}

+ (NSTextAlignment)naturalTextAlignmentInverse
{
    return [self isLanguageLayoutDirectionRightToLeft] ? NSTextAlignmentLeft : NSTextAlignmentRight;
}

@end

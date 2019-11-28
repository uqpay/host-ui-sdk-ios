//
//  UQImageUtils.m
//  UQPayHostUI
//
//  Created by uqpay on 2019/7/12.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import "UQImageUtils.h"

@implementation UQImageUtils

static UQImageUtils* imageUtils;

+ (instancetype) shareInstance {
    if (imageUtils == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            imageUtils = [UQImageUtils new];
            imageUtils.icons = @{@"UnionPay":UQImageUtils.unionPayIcon,
                                 @"Visa":    UQImageUtils.visaIcon,
                                 @"Master":  UQImageUtils.maestercardIcon,
                                 @"Jcb":     UQImageUtils.jcbIcon,
                                 @"Hiper":   UQImageUtils.hiperIcon};
        });
    }
    return imageUtils;
}


+ (UIImage *)backIcon {
     return [self resourceImage:@"back"];
}

+ (UIImage *)cardIcon {
    return [self resourceImage:@"card"];
}

+ (UIImage *)selectIcon {
    return [self resourceImage:@"xuanze"];
}

+ (UIImage *)rectangleImg {
    return [self resourceImage:@"add-rectangle"];
}

+ (UIImage *)deleteIcon {
    return [self resourceImage:@"delete"];
}

+ (UIImage *)photoIcon {
    return [self resourceImage:@"photograph"];
}

+ (UIImage *)amexIcon {
    return [self resourceImage:@"bt_ic_amex"];
}

+ (UIImage *)clubIcon {
    return [self resourceImage:@"bt_ic_diners_club"];
}

+ (UIImage *)discoverIcon {
    return [self resourceImage:@"bt_ic_discover"];
}

+ (UIImage *)hiperIcon {
    return [self resourceImage:@"bt_ic_hiper"];
}

+ (UIImage *)hipercardIcon {
    return [self resourceImage:@"bt_ic_hipercard"];
}

+ (UIImage *)jcbIcon {
    return [self resourceImage:@"bt_ic_jcb"];
}

+ (UIImage *)maestroIcon {
    return [self resourceImage:@"bt_ic_maestro"];
}

+ (UIImage *)maestercardIcon {
    return [self resourceImage:@"bt_ic_mastercard"];
}

+ (UIImage *)unionPayIcon {
    return [self resourceImage:@"bt_ic_unionpay"];
}

+ (UIImage *)visaIcon {
    return [self resourceImage:@"bt_ic_visa"];
}

+ (NSBundle*)resourceBundle {

    return [NSBundle bundleWithURL:[[NSBundle mainBundle]URLForResource:@"UQHostUIResource" withExtension:@"bundle"]];
}

+ (UIImage *)resourceImage:(NSString *)imgName {
    NSString *imageName = imgName;
    CGFloat scale = [UIScreen mainScreen].scale;
    switch ((int)scale) {
        case 1:
            imageName = [NSString stringWithFormat:@"%@%@", imgName, @".png"];
            break;
        case 2:
            imageName = [NSString stringWithFormat:@"%@%@", imgName, @"@2x.png"];
            break;
        case 3:
            imageName = [NSString stringWithFormat:@"%@%@", imgName, @"@3x.png"];
        default:
            break;
    }
    NSBundle *bundle = [self resourceBundle];
    return [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil] ;
}

@end

//
//  UQImageUtils.h
//  UQPayHostUI
//
//  Created by uqpay on 2019/7/12.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UQImageUtils : NSObject

+ (UIImage *)backIcon;
+ (UIImage *)cardIcon;
+ (UIImage *)selectIcon;
+ (UIImage *)rectangleImg;
+ (UIImage *)deleteIcon;
+ (UIImage *)photoIcon;
+ (UIImage *)amexIcon;
+ (UIImage *)clubIcon;
+ (UIImage *)discoverIcon;
+ (UIImage *)hiperIcon;
+ (UIImage *)hipercardIcon;
+ (UIImage *)jcbIcon;
+ (UIImage *)maestroIcon;
+ (UIImage *)maestercardIcon;
+ (UIImage *)unionPayIcon;
+ (UIImage *)visaIcon;
+ (instancetype) shareInstance;

@property (nonatomic, copy) NSDictionary *icons;
@end

NS_ASSUME_NONNULL_END

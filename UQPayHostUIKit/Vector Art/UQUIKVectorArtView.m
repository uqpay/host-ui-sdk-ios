//
//  UQUIKVectorArtView.m
//  UQPayHostUIKit
//
//  Created by uqpay on 2019/6/17.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import "UQUIKVectorArtView.h"
@import QuartzCore;

@implementation UQUIKVectorArtView

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGFloat scaleFactor = MIN(rect.size.width/self.artDimensions.width, rect.size.height/self.artDimensions.height);
    CGContextScaleCTM(ctx, scaleFactor, scaleFactor);
    CGContextTranslateCTM(ctx, rect.origin.x, rect.origin.y);
    
    [self drawArt];
    
    CGContextRestoreGState(ctx);
}

- (void)drawArt {
    // Subclass overrides this
}

- (UIImage *)imageOfSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [self drawRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}



@end

//
//  UQUIKVectorArtView.h
//  UQPayHostUIKit
//
//  Created by uqpay on 2019/6/17.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UQUIKVectorArtView : UIView

/// Subclass and implement this method to draw within a context pre-scaled to the
/// view's size.
- (void)drawArt;

/// This property informs the BTVectorArtView drawRect method of the dimensions
/// of the artwork.
@property (nonatomic, assign) CGSize artDimensions;

/// Returns a UIImage of the artwork
///
/// @param size the size of the desired UIImage
/// @return A UIImage of of the artwork
- (UIImage *)imageOfSize:(CGSize)size;


@end

NS_ASSUME_NONNULL_END

#import <UIKit/UIKit.h>
#import "UQUIKPaymentOptionType.h"
#import "UQUIKViewUtil.h"
/// @class A UIView containing the UQUIKVectorArtView for a UQUIKPaymentOptionType within a light border.
NS_ASSUME_NONNULL_BEGIN

@interface UQUIKPaymentOptionCardView : UIView

/// The UQUIKPaymentOptionType to display
@property (nonatomic) UQUIKPaymentOptionType paymentOptionType;
/// Defaults to 4.0
@property (nonatomic) float cornerRadius;
/// Inner padding between art and border. Defaults to 3
@property (nonatomic) float innerPadding;
/// Stroke width around card border. Defaults to 1
@property (nonatomic) float borderWidth;
/// Stroke color around card border. Defaults to #C8C7CC
@property (nonatomic, strong) UIColor *borderColor;
/// Vector art size, defaults to Regular
@property (nonatomic) UQUIKVectorArtSize vectorArtSize;


/// Set the highlighted state of the view.
///
/// @param highlighted When true, change the border color to the tint color. Otherwise light gray.
- (void)setHighlighted:(BOOL)highlighted;

/// Use the art dimensions to ensure that the width/height ratio is
/// appropriate.
///
/// @return A CGSize. Usually CGSizeMake(87.0f, 55.0f)
- (CGSize)getArtDimensions;

@end

NS_ASSUME_NONNULL_END

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UQUIKExpiryInputViewDelegate;

/// @class A UIView designed to be used as an `inputView` on a text field.
/// This input view makes it possible to enter a valid expiration date with 2 taps by showing buttons for months and years.
@interface UQUIKExpiryInputView : UIView <UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/// The selected year
@property (nonatomic) NSInteger selectedYear;
/// The selected month
@property (nonatomic) NSInteger selectedMonth;
/// The delegate that should receive expiryInputViewDidChange calls
@property (nonatomic, weak) id<UQUIKExpiryInputViewDelegate> delegate;

@end

/// @protocol This protocol is required by the delegate to receive the expiryInputViewDidChange calls
@protocol UQUIKExpiryInputViewDelegate <NSObject>

- (void)expiryInputViewDidChange:(UQUIKExpiryInputView *)expiryInputView;

@end

NS_ASSUME_NONNULL_END

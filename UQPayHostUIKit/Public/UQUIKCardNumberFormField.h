#import "UQUIKFormField.h"
#import "UQUIKCardType.h"

NS_ASSUME_NONNULL_BEGIN

@protocol UQUIKCardNumberFormFieldDelegate;

/// @class Form field to collect a card number.
@interface UQUIKCardNumberFormField : UQUIKFormField

/// UQUIKCardNumberFormFieldState modifies the form field
/// Default: Allows the input of a number upto 16 digits and does Luhn checks for validity while editing.
/// Validate: Displays a `Next` button accessory view rather than validating while edting. Set the cardNumberDelegate to receive button press. Card numbers of any length can be entered.
/// Loading: Displays a loading indicator accessory view
typedef NS_ENUM(NSInteger, UQUIKCardNumberFormFieldState) {
    UQUIKCardNumberFormFieldStateDefault = 0,
    UQUIKCardNumberFormFieldStateValidate,
    UQUIKCardNumberFormFieldStateLoading,
};

/// The card type associated with the number currently being entered
@property (nonatomic, strong, readonly) UQUIKCardType *cardType;
/// The card number
@property (nonatomic, strong) NSString *number;
/// The state of the form
@property (nonatomic) UQUIKCardNumberFormFieldState state;
/// The delegate, primary used for validateButtonPressed calls
/// Not necessary unless using UQUIKCardNumberFormFieldStateValidate
@property (nonatomic, weak) id <UQUIKCardNumberFormFieldDelegate> cardNumberDelegate;

/// Whether to show the card hint accessory
- (void)showCardHintAccessory;

@end

/// @protocol This protocol is required by the delegate to receive the validateButtonPressed calls when using UQUIKCardNumberFormFieldStateValidate
@protocol UQUIKCardNumberFormFieldDelegate <NSObject>

- (void)validateButtonPressed:(UQUIKFormField *)formField;

@end

NS_ASSUME_NONNULL_END

#import "UQUIKFormField.h"

NS_ASSUME_NONNULL_BEGIN

/// @class Form field to collect a postal code
@interface UQUIKPostalCodeFormField : UQUIKFormField

/// The postal code
@property (nonatomic, strong, readonly) NSString *postalCode;

@end

NS_ASSUME_NONNULL_END

#import "UQUIKFormField.h"

NS_ASSUME_NONNULL_BEGIN

/// @class Form field to collect a mobile country code
@interface UQUIKSecurityCodeFormField : UQUIKFormField

/// The security code
@property (nonatomic, copy, nullable, readonly) NSString *securityCode;

@end

NS_ASSUME_NONNULL_END

#import "UQUIKFormField.h"

NS_ASSUME_NONNULL_BEGIN

/// @class Form field to collect a mobile phone number
@interface UQUIKMobileNumberFormField : UQUIKFormField

/// The mobile phone number
@property (nonatomic, copy, nullable, readonly) NSString *mobileNumber;

@end

NS_ASSUME_NONNULL_END

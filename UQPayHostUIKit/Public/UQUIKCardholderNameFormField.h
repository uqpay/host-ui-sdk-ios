#import "UQUIKFormField.h"

NS_ASSUME_NONNULL_BEGIN

@interface UQUIKCardholderNameFormField : UQUIKFormField

/// The cardholder name
@property (nonatomic, strong, readonly) NSString *cardholderName;

/// Is cardholder name input required
@property (nonatomic, assign) BOOL isRequired;

@end

NS_ASSUME_NONNULL_END

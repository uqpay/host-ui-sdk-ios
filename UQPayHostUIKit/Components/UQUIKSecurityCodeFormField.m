#import "UQUIKSecurityCodeFormField.h"
#import "UQUIKTextField.h"
#import "UQUIKInputAccessoryToolbar.h"
#import "UQUIKLocalizedString.h"

@interface UQUIKSecurityCodeFormField ()

@end

@implementation UQUIKSecurityCodeFormField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textField.accessibilityLabel = UQUIKLocalizedString(CVV_FIELD_PLACEHOLDER);
        self.formLabel.text = [NSString stringWithFormat:@"%@:",UQUIKLocalizedString(CVV_FIELD_PLACEHOLDER) ];
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

#pragma mark - Custom accessors

- (BOOL)valid {
    return self.securityCode.length >= 3;
}

- (NSString *)securityCode {
    return self.textField.text;
}

#pragma mark UITextFieldDelegate

- (void)fieldContentDidChange {
    [self.delegate formFieldDidChange:self];
    [self updateAppearance];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [super textFieldDidBeginEditing:textField];
    [self updateAppearance];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [super textFieldDidEndEditing:textField];
    [self updateAppearance];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return textField.text.length - range.length + string.length <= 4;
}

@end

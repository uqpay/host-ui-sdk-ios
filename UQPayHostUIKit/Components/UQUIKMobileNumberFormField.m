#import "UQUIKMobileNumberFormField.h"
#import "UQUIKTextField.h"
#import "UQUIKInputAccessoryToolbar.h"
#import "UQUIKLocalizedString.h"

@interface UQUIKMobileNumberFormField()<UQUIKTextFieldEditDelegate>

@property (nonatomic, strong) UITextField *numberField;

@end

@implementation UQUIKMobileNumberFormField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textField.accessibilityLabel = UQUIKLocalizedString(MOBILE_COUNTRY_CODE_LABEL);
        self.textField.placeholder = UQUIKLocalizedString(MOBILE_COUNTRY_CODE_LABEL);
        self.textField.adjustsFontSizeToFitWidth = false;
        self.formLabel.text = [NSString stringWithFormat:@"%@:",UQUIKLocalizedString(MOBILE_NUMBER_LABEL) ];
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        
        self.numberField = [[UITextField alloc]init];
        self.numberField.borderStyle = UITextBorderStyleNone;
        self.numberField.backgroundColor = [UIColor clearColor];
        self.numberField.opaque = NO;
        self.numberField.adjustsFontSizeToFitWidth = false;
        self.numberField.translatesAutoresizingMaskIntoConstraints = NO;
        self.numberField.accessibilityLabel = UQUIKLocalizedString(MOBILE_NUMBER_LABEL);
        self.numberField.placeholder = UQUIKLocalizedString(MOBILE_NUMBER_LABEL);
        self.numberField.delegate = self;
        
        self.accessoryView = self.numberField;
        
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.accessoryView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.textField attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.accessoryView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.textField attribute:NSLayoutAttributeRight multiplier:1.0 constant:15];
        NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.accessoryView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        NSLayoutConstraint *bottmConstraint = [NSLayoutConstraint constraintWithItem:self.accessoryView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.textField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.accessoryView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.textField attribute:NSLayoutAttributeWidth multiplier:1.5 constant:0];
        NSArray *array = [NSArray arrayWithObjects:topConstraint, leftConstraint, rightConstraint, bottmConstraint, widthConstraint];
        [self addConstraints:array];
        
    }
    return self;
}


#pragma mark - Custom accessors

- (NSString *)countryCode {
    return self.textField.text;
}

- (void)fieldContentDidChange {
    [self.delegate formFieldDidChange:self];
    [self updateAppearance];
}

#pragma mark - Custom accessors

- (BOOL)valid {
    return self.textField.text.length > 2 && self.numberField.text > 6 ;
}

- (NSString *)text {
    return [NSString stringWithFormat:@"%@-%@", self.textField.text, self.numberField.text];
}

@end

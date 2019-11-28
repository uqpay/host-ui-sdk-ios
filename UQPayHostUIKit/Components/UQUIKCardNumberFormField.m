#import "UQUIKCardNumberFormField.h"
#import "UQUIKPaymentOptionCardView.h"
#import "UQUIKLocalizedString.h"
#import "UQUIKUtil.h"
#import "UQUIKTextField.h"
#import "UQUIKViewUtil.h"
#import "UQUIKInputAccessoryToolbar.h"
#import "UQUIKAppearance.h"

#define TEMP_KERNING 8.0

@interface UQUIKCardNumberFormField ()
@property (nonatomic, strong) UQUIKPaymentOptionCardView *hint;
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@end

@implementation UQUIKCardNumberFormField

@synthesize number = _number;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.state = UQUIKCardNumberFormFieldStateDefault;

        self.textField.accessibilityLabel = UQUIKLocalizedString(UQ_CARD_Security_Identification);
        self.textField.placeholder = UQUIKLocalizedString(UQ_CARD_Security_Identification);
        self.textField.textAlignment = [UQUIKViewUtil naturalTextAlignment];
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.formLabel.text = [NSString stringWithFormat:@"%@:",UQUIKLocalizedString(CARD_NUMBER_PLACEHOLDER) ] ;
        self.formLabel.textColor = [UQUIKAppearance sharedInstance].cardTitleColor;
        self.formLabel.font = [UQUIKAppearance sharedInstance].cardTitleFont;
        self.textField.keyboardType = UIKeyboardTypeNumberPad;

        [self setAccessoryViewHidden:YES animated:NO];
        self.loadingView = [UIActivityIndicatorView new];
        self.loadingView.activityIndicatorViewStyle = [UQUIKAppearance sharedInstance].activityIndicatorViewStyle;
        [self.loadingView sizeToFit];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString: self.textField.placeholder];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UQUIKAppearance sharedInstance].cardPlaceholderTextColor range:NSMakeRange(0, self.textField.placeholder.length)];
        [attributedString addAttribute:NSFontAttributeName value:[UQUIKAppearance sharedInstance].cardTitleFont range:NSMakeRange(0, self.textField.placeholder.length)];
        self.textField.attributedPlaceholder = attributedString;
    }
    return self;
}

- (BOOL)valid {
    return [self.cardType validNumber:self.number];
}

- (BOOL)entryComplete {
    return [super entryComplete] && [self.cardType validAndNecessarilyCompleteNumber:self.number];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = textField.text.length - range.length + string.length;
    NSUInteger maxLength = self.cardType == nil ? [UQUIKCardType maxNumberLength] : self.cardType.maxNumberLength;
    if ([self isShowingValidateButton]) {
        return YES;
    } else {
        return newLength <= maxLength;
    }
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self fieldContentDidChange];
}

- (void)fieldContentDidChange {
    _number = [UQUIKUtil stripNonDigits:self.textField.text];
    UQUIKCardType *oldCardType = _cardType;
    _cardType = [UQUIKCardType cardTypeForNumber:_number];
    [self formatCardNumber];

    if (self.cardType != oldCardType) {
        [self updateCardHint];
    }
    
    self.displayAsValid = self.valid || (!self.isValidLength && self.isPotentiallyValid) || self.state == UQUIKCardNumberFormFieldStateValidate;
    [self updateAppearance];
    [self setNeedsDisplay];
    
    [self.delegate formFieldDidChange:self];
}

- (void)formatCardNumber {
    if (self.cardType != nil) {
        UITextRange *r = self.textField.selectedTextRange;
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:[self.cardType formatNumber:_number kerning:TEMP_KERNING]];
        self.textField.attributedText = text;
        self.textField.selectedTextRange = r;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.textField.text = _number;
    [super textFieldDidBeginEditing:textField];
    self.displayAsValid = self.valid || (!self.isValidLength && self.isPotentiallyValid);
    [UIView transitionWithView:self
                      duration:0.2
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        if ([self isShowingValidateButton]) {
                            [self setAccessoryViewHidden:NO animated:NO];
                        } else {
                            [self setAccessoryViewHidden:YES animated:YES];
                        }
                        [self updateConstraints];
                        [self updateAppearance];
                        
                        if (self.isPotentiallyValid) {
                            [self formatCardNumber];
                        }
                    } completion:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [super textFieldDidEndEditing:textField];
    self.displayAsValid = self.number.length == 0 || (![self isValidLength] && self.state == UQUIKCardNumberFormFieldStateValidate) || (_cardType != nil && [_cardType validNumber:_number]);
    [UIView animateWithDuration:0.2 animations:^{
        if ([self isShowingValidateButton]) {
            [self setAccessoryViewHidden:NO animated:NO];
        } else {
            if (self.number.length == 0) {
                [self setAccessoryViewHidden:YES animated:YES];
            } else {
                [self showCardHintAccessory];
            }
        }
        if (self.number.length > 7 && ([self isValidLength] || self.state != UQUIKCardNumberFormFieldStateValidate)) {
            NSString *lastFour = [self.number substringFromIndex: [self.number length] - 4];
            self.textField.text = [NSString stringWithFormat:@"•••• %@", lastFour];
        }
        [self updateConstraints];
        [self updateAppearance];
    }];
}

- (void)resetFormField {
    self.textField.text = @"";
    [self setAccessoryViewHidden:YES animated:NO];
    [self updateConstraints];
    [self updateAppearance];
}

#pragma mark - Public Methods

- (void)setNumber:(NSString *)number {
    self.text = number;
    _number = self.textField.text;
}

- (void)showCardHintAccessory {
    [self setAccessoryViewHidden:NO animated:YES];
}

#pragma mark - Private Helpers

- (BOOL)isShowingValidateButton {
    return self.state == UQUIKCardNumberFormFieldStateValidate;
}

- (BOOL)isValidCardType {
    return self.cardType != nil || _number.length == 0;
}

- (BOOL)isPotentiallyValid {
    return [UQUIKCardType cardTypeForNumber:self.number] != nil;
}

- (BOOL)isValidLength {
    return self.cardType != nil && [self.cardType completeNumber:_number];
}

- (void)updateCardHint {
    UQUIKPaymentOptionType paymentMethodType = [UQUIKViewUtil paymentMethodTypeForCardType:self.cardType];
}

@end

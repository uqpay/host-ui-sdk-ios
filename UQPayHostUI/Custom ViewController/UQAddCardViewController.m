//
//  UQAddCardViewController.m
//  UQPayHostUI
//
//  Created by uqpay on 2019/7/5.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import "UQAddCardViewController.h"
#import "../Helpers/SystemUtils.h"
#import "../Helpers/UQDropInUIUtilities.h"
#import "../Models/SMSModel.h"
#import "../Models/AddCardModel.h"
#import "../Models/CardModel.h"
#import "../Models/ResultModel.h"
#import "../Public/UQHostResult.h"



@interface UQAddCardViewController()

@property (nonatomic, strong) UIScrollView*                    scrollView;
@property (nonatomic, strong) UIView*                          scrollViewContentWrapper;
@property (nonatomic, strong) UIButton*                        photoBtn;


@property (nonatomic, strong) UQUIKCardNumberFormField*        cardNumberField;
@property (nonatomic, strong) UQUIKExpiryFormField*            expirationDateField;
@property (nonatomic, strong) UQUIKSecurityCodeFormField*      securityCodeField;
@property (nonatomic, strong) UQUIKPostalCodeFormField*        postalCodeField;
@property (nonatomic, strong) UQUIKMobileNumberFormField*      mobilePhoneField;
@property (nonatomic, strong) UQUIKSMSFormField*               smsFormField;
@property (nonatomic, strong) UIButton*                        nextButton;
@property (nonatomic, strong) UIStackView*                     stackView;
@property (nonatomic, strong) NSArray <UQUIKFormField *>*      formFields;


@property (nonatomic, strong) UIStackView *cardNumberErrorView;
@property (nonatomic, strong) UIStackView *cardNumberHeader;
@property (nonatomic, strong) UIStackView *cardNumberFooter;
@property (nonatomic, strong) UIStackView *enrollmentFooter;

@property (nonatomic,weak) NSTimer* countDownTimer;

@property (nonatomic, strong) NSString*                        cardNumber;
@property (nonatomic, getter=isCollapsed) BOOL collapsed;

@property (nonatomic, copy) NSString* uqOrderId;

@property (nonatomic) BOOL  needPostCardInfo;

@end

@interface CardIOSurrogate : NSObject
+ (NSString*)cardIOLibraryVersion;
+ (id)initWithPaymentDelegate:id;
+ (BOOL)canReadCardWithCamera;
@property (nonatomic, strong) NSString *cardNumber;
@property (nonatomic, assign, readwrite) BOOL hideCardIOLogo;
@property (nonatomic, retain, readwrite) UIColor *navigationBarTintColor;
@property (nonatomic, assign, readwrite) BOOL collectExpiry;
@property (nonatomic, assign, readwrite) BOOL collectCVV;
@end

@implementation UQAddCardViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];
    [self setupForms];
//    [self resetForm];
//    [self showLoadingScreen: YES];
//    [self loadConfiguration];
//    [self updateFormBorders];
//    [self test];
}

- (void)initUI{

    _collapsed = NO;
    _needPostCardInfo = NO;
    
    self.view.backgroundColor = [UQUIKAppearance sharedInstance].formBackgroundColor;
    
    self.navigationItem.leftBarButtonItem = [[UQUIKBarButtonItem alloc]initWithImage:[UQImageUtils backIcon] style:UIBarButtonItemStylePlain target:self action:@selector(cancelTapped)];
    self.title = UQUIKLocalizedString(UQ_ADD_BANK_CARD);
    
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView setAlwaysBounceVertical:NO];
    self.scrollView.scrollEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    self.scrollViewContentWrapper = [[UIView alloc]init];
    self.scrollViewContentWrapper.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.scrollViewContentWrapper];
    
    self.stackView = [self newStackView];
    [self.scrollViewContentWrapper addSubview:self.stackView];
    
    [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [self.scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    
    NSDictionary *viewBindings = @{@"stackView": self.stackView,
                                   @"scrollView": self.scrollView,
                                   @"scrollViewContentWrapper": self.scrollViewContentWrapper};

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollViewContentWrapper]"
                                                                      options:0
                                                                      metrics:[UQUIKAppearance metrics]
                                                                        views:viewBindings]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollViewContentWrapper(scrollView)]"
                                                                      options:0
                                                                      metrics:[UQUIKAppearance metrics]
                                                                        views:viewBindings]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[stackView]|"
                                                                      options:0
                                                                      metrics:[UQUIKAppearance metrics]
                                                                        views:viewBindings]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[stackView]-|"
                                                                      options:0
                                                                      metrics:[UQUIKAppearance metrics]
                                                                        views:viewBindings]];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [self.view setUserInteractionEnabled:YES];
    [self.view addGestureRecognizer:tapGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

- (void)setupForms{
    self.cardNumberHeader = [UQDropInUIUtilities newStackView];
    self.cardNumberHeader.alignment = UIStackViewAlignmentCenter;
    self.cardNumberHeader.layoutMargins = UIEdgeInsetsMake(0, CGRectGetWidth(self.photoBtn.bounds), 0, CGRectGetHeight(self.photoBtn.bounds));
    self.cardNumberHeader.layoutMarginsRelativeArrangement = true;
    
    [self.cardNumberHeader addArrangedSubview:self.photoBtn];
    [UQDropInUIUtilities addSpacerToStackView:self.cardNumberHeader beforeView:self.photoBtn size:[UQUIKAppearance verticalFormSpace]];
    [self.stackView addArrangedSubview:self.cardNumberHeader];
    
    [self.stackView addArrangedSubview:self.cardNumberField];
    NSLayoutConstraint *heightConstraint = [self.cardNumberField.heightAnchor constraintEqualToConstant:[UQUIKAppearance formCellHeight]];
    heightConstraint.priority = UILayoutPriorityDefaultHigh;
    heightConstraint.active = true;
    [self.cardNumberField updateConstraints];
    [UQDropInUIUtilities addSpacerToStackView:self.stackView beforeView:self.cardNumberField size:[UQUIKAppearance verticalFormSpace]];
    
    self.formFields = @[self.expirationDateField, self.securityCodeField, self.mobilePhoneField, self.smsFormField];
    for (UQUIKFormField *formField in self.formFields) {
        [self.stackView addArrangedSubview:formField];
        NSLayoutConstraint *heightConstraint = [formField.heightAnchor constraintEqualToConstant:[UQUIKAppearance formCellHeight]];
        heightConstraint.priority = UILayoutPriorityDefaultHigh;
        heightConstraint.active = YES;
        [formField updateConstraints];
    }
    
    self.cardNumberFooter = [UQDropInUIUtilities newStackView];
    self.cardNumberFooter.layoutMargins = UIEdgeInsetsMake(0, 12, 0, 8);
    self.cardNumberFooter.layoutMarginsRelativeArrangement = true;
    [self.cardNumberFooter addArrangedSubview:self.nextButton];
    heightConstraint = [self.nextButton.heightAnchor constraintEqualToConstant:[UQUIKAppearance formCellHeight]];
    heightConstraint.priority = UILayoutPriorityDefaultHigh;
    heightConstraint.active = true;
    [UQDropInUIUtilities addSpacerToStackView:self.cardNumberFooter beforeView:self.nextButton size:[UQUIKAppearance verticalFormSpace]];
    [self.stackView addArrangedSubview:self.cardNumberFooter];
    
    [self setCollapsed:true];
}

- (BOOL)isCardIOAvailable {
    Class kCardIOView = NSClassFromString(@"CardIOPaymentViewController");
    Class kCardIOUtilities = NSClassFromString(@"CardIOUtilities");
    if (kCardIOView != nil && kCardIOView != nil
        && [kCardIOUtilities respondsToSelector:@selector(cardIOLibraryVersion)]
        && [kCardIOUtilities respondsToSelector:@selector(canReadCardWithCamera)]) {
        NSString *cardIOVersion = [kCardIOUtilities cardIOLibraryVersion];
        NSString *majorVersion = [cardIOVersion length] >= 2 ? [cardIOVersion substringToIndex:2] : @"";
        // Require 5.x.x strictly
        return [majorVersion isEqualToString:@"5."] && [kCardIOUtilities canReadCardWithCamera];
    }
    return NO;
}

- (void)presentCardIO {
    Class kCardIOPaymentViewController = NSClassFromString(@"CardIOPaymentViewController");
    id scanViewController = [[kCardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    [scanViewController setNavigationBarTintColor:[[UINavigationBar appearance] barTintColor]];
    [scanViewController setHideCardIOLogo:YES];
    [scanViewController setCollectCVV:NO];
    [scanViewController setCollectExpiry:NO];
    [self presentViewController:scanViewController animated:YES completion:nil];
}

- (void)userDidCancelPaymentViewController:(UIViewController *)scanViewController {
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)userDidProvideCreditCardInfo:(id)info inPaymentViewController:(UIViewController *)scanViewController {
    NSString *cardNumber = [info cardNumber];
    [scanViewController dismissViewControllerAnimated:YES completion:^{
        [self.cardNumberField setNumber:cardNumber];
        [self.cardNumberField textFieldDidEndEditing:self.cardNumberField.textField];
        [self validateButtonPressed:self.cardNumberField];
    }];
}

- (void)updateUI {
}

- (void)resetForm {
    
}

- (void)showLoadingScreen:(BOOL)show {
    
}

- (void)loadConfiguration {
    
}


- (void)cancelTapped {
    [self hideKeyboard];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tokenizedCard {
    [self.view endEditing:YES];
    if ([self validateAddCard]){
        UIActivityIndicatorView *spinner = [UIActivityIndicatorView new];
        spinner.activityIndicatorViewStyle = [UQUIKAppearance sharedInstance].activityIndicatorViewStyle;
        [spinner startAnimating];

        UIBarButtonItem *addCardButton = self.navigationItem.rightBarButtonItem;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
        self.view.userInteractionEnabled = NO;

        NSString* date = self.expirationDateField.text;
        CardModel *cardModel = [CardModel new];
        cardModel.cardNum = self.cardNumber;
        cardModel.cvv = self.securityCodeField.text;
        cardModel.expireMonth = [date componentsSeparatedByString:@"/"].firstObject;
        cardModel.expireYear =  [[date componentsSeparatedByString:@"/"].lastObject substringFromIndex:2];
        cardModel.phone = self.mobilePhoneField.text;

        AddCardModel *addCardModel = [AddCardModel new];
        addCardModel.card = cardModel;
        addCardModel.uqOrderId = self.uqOrderId;
        addCardModel.verifyCode = self.smsFormField.text;

        [[UQHttpClient sharedInstance]addCard:addCardModel success:^(NSDictionary * _Nonnull dict, BOOL isSuccess) {
            if (isSuccess && dict) {
                NSDictionary* date = [dict objectForKey:@"data"];
                UQHostResult *resultModel = [[UQHostResult alloc]initWithDictionary:date error:nil];

                [self dismissViewControllerAnimated:YES completion:^{
                    if (self.delegate && [self.delegate respondsToSelector:@selector(UQHostResult:)]) {
                        [self.delegate UQHostResult:resultModel];
                    }
                }];
            }
        } fail:^(NSError * _Nonnull error) {
            NSLog(@"error = %@",error);
            self.navigationItem.rightBarButtonItem = addCardButton;
            self.view.userInteractionEnabled = YES;
        }];
    }
}


#pragma mark -- lazy init--
- (UQUIKCardNumberFormField *)cardNumberField {
    if (_cardNumberField == nil) {
        _cardNumberField = [[UQUIKCardNumberFormField alloc]init];
        _cardNumberField.state = UQUIKCardNumberFormFieldStateValidate;
        _cardNumberField.delegate = self;
        _cardNumberField.cardNumberDelegate = self;
    }
    return _cardNumberField;
}

- (UQUIKExpiryFormField *)expirationDateField {
    if (_expirationDateField == nil) {
        _expirationDateField = [[UQUIKExpiryFormField alloc]init];
    }
    return _expirationDateField;
}

- (UQUIKSecurityCodeFormField *)securityCodeField {
    if (_securityCodeField == nil) {
        _securityCodeField = [[UQUIKSecurityCodeFormField alloc]init];
    }
    return _securityCodeField;
}

- (UQUIKPostalCodeFormField *)postalCodeField {
    if (_postalCodeField == nil) {
        _postalCodeField = [[UQUIKPostalCodeFormField alloc]init];
        _postalCodeField.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _postalCodeField;
}

- (UQUIKMobileNumberFormField *)mobilePhoneField {
    if (_mobilePhoneField == nil) {
        _mobilePhoneField = [[UQUIKMobileNumberFormField alloc]init];
        _mobilePhoneField.delegate = self;
    }
    return _mobilePhoneField;
}

- (UQUIKSMSFormField *)smsFormField {
    if (_smsFormField == nil) {
        _smsFormField = [[UQUIKSMSFormField alloc]init];
        _smsFormField.smsDelegate = self;
    }
    return _smsFormField;
}

- (UIButton *)photoBtn {
    if (_photoBtn == nil) {
        _photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _photoBtn.backgroundColor = [UIColor clearColor];
        [_photoBtn setImage:[UQImageUtils photoIcon] forState:UIControlStateNormal];
        _photoBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [_photoBtn addTarget:self action:@selector(presentCardIO) forControlEvents:UIControlEventTouchUpInside];
    }
    return _photoBtn;
}

- (UIButton *)nextButton {
    if (_nextButton == nil) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.backgroundColor = [[UQUIKAppearance sharedInstance].defaultColor colorWithAlphaComponent:0.5];
        _nextButton.layer.cornerRadius = 4.0;
        _nextButton.titleLabel.font = [UQUIKAppearance sharedInstance].cardTitleFont;
        [_nextButton setTitle:UQUIKLocalizedString(NEXT_ACTION) forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

- (UIStackView *)newStackView {
    UIStackView *stackView = [[UIStackView alloc]init];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionFill;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.spacing = 0;
    return stackView;
}

#pragma mark - keyboard management
- (void)hideKeyboard {
    [self.view endEditing:YES];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardRectInWindow = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGSize keyboardSize = [self.view convertRect:keyboardRectInWindow fromView:nil].size;
    UIEdgeInsets scrollInsets = self.scrollView.contentInset;
    scrollInsets.bottom = keyboardSize.height;
    self.scrollView.contentInset = scrollInsets;
    self.scrollView.scrollIndicatorInsets = scrollInsets;
}

- (void)keyboardWillHide:(__unused NSNotification *)notification {
    UIEdgeInsets scrollInsets = self.scrollView.contentInset;
    scrollInsets.bottom = 0.0;
    self.scrollView.contentInset = scrollInsets;
    self.scrollView.scrollIndicatorInsets = scrollInsets;
}

- (void)updateFormBorders {
    self.cardNumberField.bottomBorder = YES;
    self.cardNumberField.topBorder = YES;
    self.mobilePhoneField.bottomBorder = YES;
    
    NSArray *groupedFormFields = @[self.expirationDateField, self.securityCodeField, self.mobilePhoneField, self.postalCodeField];
    BOOL topBorderAdded = NO;
    UQUIKFormField* lastVisibleFormField;
    for (NSUInteger i = 0; i < groupedFormFields.count; i++) {
        UQUIKFormField *formField = groupedFormFields[i];
        if (!formField.hidden) {
            if (!topBorderAdded) {
                formField.topBorder = YES;
                topBorderAdded = YES;
            } else {
                formField.topBorder = NO;
            }
            formField.bottomBorder = NO;
            formField.interFieldBorder = YES;
            lastVisibleFormField = formField;
        }
    }
    if (lastVisibleFormField) {
        lastVisibleFormField.bottomBorder = YES;
    }
}

#pragma mark -- switch card number

- (void)setCollapsed:(BOOL)collapsed {
    if (collapsed == self.collapsed) {
        return;
    }
    // Using ivar so that setter is not called
    _collapsed = collapsed;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.15
                              delay:0.0
                            options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
            self.cardNumberHeader.hidden = !collapsed;
            self.expirationDateField.hidden = collapsed;
            self.securityCodeField.hidden = collapsed;
            self.mobilePhoneField.hidden = collapsed;
            self.smsFormField.hidden = collapsed;
            [self updateFormBorders];
        } completion:^(__unused BOOL finished) {
            self.cardNumberHeader.hidden = !collapsed;
            self.expirationDateField.hidden = collapsed;
            self.securityCodeField.hidden = collapsed;
            self.mobilePhoneField.hidden =  collapsed;
            self.smsFormField.hidden = collapsed;
            [self updateFormBorders];
        }];
    });
}

#pragma mark - Protocol conformance
#pragma mark FormField Delegate Methods
- (void)validateButtonPressed:(__unused UQUIKFormField *)formField {
    self.collapsed = NO;
    self.navigationItem.rightBarButtonItem.enabled = true;
}

- (void)formFieldDidChange:(UQUIKFormField *)formField {
    if (formField.class == self.mobilePhoneField.class) {
    }else if ([formField isKindOfClass:UQUIKCardNumberFormField.class]) {
        self.cardNumber = formField.text;
        if (self.cardNumber.length > 12) {
            self.nextButton.backgroundColor = [UQUIKAppearance sharedInstance].defaultColor ;
        }else {
            self.nextButton.backgroundColor = [[UQUIKAppearance sharedInstance].defaultColor colorWithAlphaComponent:0.5];
        }
    }
}

- (void)sendSMS:(UIButton *)btn success:(SendSuccess)smsSuccess{
    if (self.cardNumber && self.cardNumber.length >0 && self.mobilePhoneField.text && self.mobilePhoneField.text.length > 0) {
        [[UQHttpClient sharedInstance]getSms:@{@"cardNum":self.cardNumber, @"phone":self.mobilePhoneField.text} success:^(NSDictionary * _Nonnull dict, BOOL isSuccess) {
            if (isSuccess) {
                if (dict != nil) {
                    NSDictionary *data = [dict objectForKey:@"data"];
                    NSError *error;
                    SMSModel *model = [[SMSModel alloc]initWithDictionary:data error:&error];
                    self.uqOrderId = model.uqOrderId;
                    smsSuccess(true);
                }
            }
        } fail:^(NSError * _Nonnull error) {
            NSLog(@"error %@",error);
        }];
    }
}


- (void)nextButtonAction {
    
    if (![self validateCardNumber]){
        return ;
    }
    if (_needPostCardInfo) {
        if (![self validateAddCard]) {
            return ;
        }else {
            [self tokenizedCard];
        }
    }else {
        _needPostCardInfo = true;
        [self setCollapsed:NO];
         [UQDropInUIUtilities addSpacerToStackView:self.stackView beforeView:self.expirationDateField size: [UQUIKAppearance verticalSectionSpace]];
    }
}

#pragma mark

- (BOOL)validateCardNumber {
    return self.cardNumber && self.cardNumber.length > 12;
}

- (BOOL)validateAddCard {
    NSArray * array = @[self.expirationDateField, self.mobilePhoneField, self.smsFormField];
    
    for (int i=0; i < array.count; i++) {
        UQUIKFormField *formField = array[i];
        if (!formField.text.length){
            return false;
        }
    }
    return true;
}

#pragma mark ---

-(void)test {
    self.cardNumber = @"6223164991230014";
    self.cardNumberField.text = self.cardNumber;
    self.mobilePhoneField.text = @"13012345678";
    self.postalCodeField.text = @"111111";
    self.securityCodeField.text = @"123";

}
@end

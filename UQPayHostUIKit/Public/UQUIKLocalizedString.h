//
//  UQUIKitLocalizedString.h
//  UQPayHostUIKit
//
//  Created by uqpay on 2019/6/17.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define UQUIKLocalizedString(KEY) [UQUIKLocalizedString KEY]

@interface UQUIKLocalizedString : NSObject

+ (void)setCustomTranslations: (NSArray*) locales;

+ (NSString *)insertIntoLocalizedString:(NSString *)string replacement:(NSString* )replacement;

+ (NSString *)insertIntoLocalizedString:(NSString *)string replacement:(NSString* )replacement token:(NSString *)token;


+ (NSString *)CARD_DETAILS_LABEL;
+ (NSString *)ENTER_CARD_DETAILS_HELP_LABEL;
+ (NSString *)VALID_CARD_ERROR_LABEL;
+ (NSString *)CARD_REQUIRED;
+ (NSString *)CARD_INVALID;
+ (NSString *)EXPIRATION_REQUIRED;
+ (NSString *)EXPIRATION_INVALID;
+ (NSString *)CVV_REQUIRED;
+ (NSString *)CVV_INVALID;
+ (NSString *)POSTAL_CODE_HELP_LABEL;
+ (NSString *)POSTAL_CODE_REQUIRED;
+ (NSString *)POSTAL_CODE_INVALID;
+ (NSString *)COUNTRY_CODE_REQUIRED;
+ (NSString *)COUNTRY_CODE_INVALID;
+ (NSString *)MOBILE_NUMBER_REQUIRED;
+ (NSString *)MOBILE_NUMBER_INVALID;
+ (NSString *)ENROLLMENT_WITH_SMS_HELP_LABEL;
+ (NSString *)SMS_CODE_REQUIRED;
+ (NSString *)SMS_CODE_INVALID;

+ (NSString *)CANCEL_ACTION;
+ (NSString *)RETRY_ACTION;
+ (NSString *)CONTINUE_ACTION;
+ (NSString *)ADD_CARD_ACTION;
+ (NSString *)DONE_ACTION;
+ (NSString *)EDIT_ACTION;
+ (NSString *)NEXT_ACTION;
+ (NSString *)TOP_LEVEL_ERROR_ALERT_VIEW_OK_BUTTON_TEXT;
+ (NSString *)SCAN_CARD_IO_ACTION;
+ (NSString *)EDIT_PAYMENT_METHOD;
+ (NSString *)THERE_WAS_AN_ERROR;
+ (NSString *)REVIEW_AND_TRY_AGAIN;
+ (NSString *)INVALID_LABEL;
+ (NSString *)YEAR_LABEL;
+ (NSString *)MONTH_LABEL;
+ (NSString *)OTHER_LABEL;
+ (NSString *)CREDIT_OR_DEBIT_CARD_LABEL;
+ (NSString *)RECENT_LABEL;
+ (NSString *)SELECT_PAYMENT_LABEL;
+ (NSString *)CONFIRM_ENROLLMENT_LABEL;
+ (NSString *)CONFIRM_ACTION;
+ (NSString *)ENTER_SMS_CODE_SENT_HELP_LABEL;
+ (NSString *)SMS_CODE_LABEL;
+ (NSString *)CARD_TYPE_GENERIC_CARD;
+ (NSString *)MOBILE_COUNTRY_CODE_LABEL;
+ (NSString *)SECURITY_CODE_LABEL;
+ (NSString *)CVV_FIELD_PLACEHOLDER;
+ (NSString *)CVC_FIELD_PLACEHOLDER;
+ (NSString *)CID_FIELD_PLACEHOLDER;
+ (NSString *)CVN_FIELD_PLACEHOLDER;
+ (NSString *)POSTAL_CODE_PLACEHOLDER;
+ (NSString *)MOBILE_NUMBER_LABEL;
+ (NSString *)EXPIRATION_DATE_LABEL;
+ (NSString *)CARD_NUMBER_PLACEHOLDER;
+ (NSString *)EXPIRY_PLACEHOLDER_FOUR_DIGIT_YEAR;
+ (NSString *)EXPIRY_PLACEHOLDER_TWO_DIGIT_YEAR;
+ (NSString *)CARDHOLDER_NAME_LABEL;

+ (NSString *)PAYPAL;
+ (NSString *)CARD_TYPE_AMERICAN_EXPRESS;
+ (NSString *)CARD_TYPE_DISCOVER;
+ (NSString *)CARD_TYPE_DINERS_CLUB;
+ (NSString *)CARD_TYPE_MASTER_CARD;
+ (NSString *)CARD_TYPE_VISA;
+ (NSString *)CARD_TYPE_JCB;
+ (NSString *)CARD_TYPE_MAESTRO;
+ (NSString *)CARD_TYPE_UNION_PAY;
+ (NSString *)BRANDING_COINBASE;
+ (NSString *)BRANDING_VENMO;
+ (NSString *)BRANDING_APPLE_PAY;
+ (NSString *)USE_DIFFERENT_PHONE_NUMBER_ACTION;
+ (NSString *)CARD_NOT_ACCEPTED_ERROR_LABEL;
+ (NSString *)SELECT_BANK_CARD;
+ (NSString *)UQ_CARD_LIST;
+ (NSString *)UQ_ADD_CARD;
+ (NSString *)UQ_SEND_CODE;
+ (NSString *)UQ_WARNING;
+ (NSString *)UQ_DELETE_CARD;
+ (NSString *)UQ_SELECT_CARD;
+ (NSString *)UQ_NO_CARD;
+ (NSString *)UQ_MORE;
+ (NSString *)UQ_ADD_BANK_CARD;
+ (NSString *)UQ_UNBIND_CARD_MESSAGE;
+ (NSString *)UQ_CARD_Security_Identification;
+ (NSString *)UQ_SEND_ANAGIN;
+ (NSString *)UQ_DELETE;

#pragma mark Development Strings (usually not localized)

+ (NSString *)DEV_SAMPLE_SMS_CODE_TITLE;
+ (NSString *)DEV_SAMPLE_SMS_CODE_INFO;

@end

NS_ASSUME_NONNULL_END

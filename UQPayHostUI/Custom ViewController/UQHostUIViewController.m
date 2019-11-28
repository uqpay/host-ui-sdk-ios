//
//  UQHostUIViewController.m
//  UQPayHostUI
//
//  Created by uqpay on 2019/7/4.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import "UQHostUIViewController.h"
#import "../Custom View/UQCardItemView.h"
#import "../Helpers/SystemUtils.h"
#import "../Models/ResultModel.h"
#import "../Models/CardListModel.h"

#if __has_include("UQPayHostUIKit.h")
#import "UQPayHostUIKit.h"
#else
#import <UQPayHostUIKit/UQPayHostUIKit.h>
#endif


#define UQ_ANIMATION_SLIDE_SPEED 0.35
#define UQ_ANIMATION_TRANSITION_SPEED 0.1
#define UQ_HALF_SHEET_MARGIN 0
#define UQ_HALF_SHEET_CORNER_RADIUS 0
#define UQ_CONTENT_HEIGHT 300
#define UQ_CARD_ITEM_HEIGHT 66
#define UQ_CARD_ITEM_PADDING_SIDE 40
#define UQ_CARD_ITEM_PADDING 20

@interface UQHostUIViewController()<UIGestureRecognizerDelegate>

@property (nonatomic) BOOL useBlur;
@property (nonatomic, strong) UIToolbar* toolbar;
@property (nonatomic, strong) UIView* contentView;
@property (nonatomic, strong) UIView* contentClippingView;
@property (nonatomic, strong) UIVisualEffectView *blurredContentBackgroundView;
@property (nonatomic, strong) UIView* splitLine;
@property (nonatomic, strong) UQCardItemView    *cardItemView;
@property (nonatomic, assign) UQClientModelType modelType;
@property (nonatomic, retain) UQHostResult* resultModel;
@property (nonatomic, strong) UIButton* moreBtn;
@property (nonatomic, retain) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UILabel *unExistCardLabel;
@property (nonatomic, strong) UIButton *addCardBtn;
@property (nonatomic, strong) NSMutableArray *data;
@end


@implementation UQHostUIViewController

- (instancetype)init {
    return [self initWithModel:PROTYPE];
}

- (instancetype)initWithModel:(UQClientModelType)modelType
{
    self = [super init];
    if (self) {
        if (SystemUtils.systemVersion >= 8.0) {
            self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }else{
            self.modalPresentationStyle = UIModalPresentationCurrentContext;
        }
        
        self.useBlur = !UIAccessibilityIsReduceTransparencyEnabled();
        if (![UQUIKAppearance sharedInstance].useBlurs) {
            self.useBlur = NO;
        }
        self.modelType = modelType;
    }
    return self;
}

- (void)viewDidLoad {
    [self initClient];
    [self initUI];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
     [self initData];
}

- (UIToolbar *)toolbar {
    if (_toolbar == nil) {
        _toolbar = [[UIToolbar alloc]init];
        _toolbar.userInteractionEnabled = YES;
        _toolbar.barStyle = UIBarStyleDefault;
        _toolbar.translucent = YES;
        _toolbar.backgroundColor = [UIColor clearColor];
        [_toolbar setBackgroundImage:[UIImage new] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        _toolbar.barTintColor = [UIColor clearColor];
        _toolbar.frame = CGRectMake(0, 0, SystemUtils.SCREEN_WIDTH, 55);
    }
    return _toolbar;
}


- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.layer.cornerRadius = UQ_HALF_SHEET_CORNER_RADIUS;
        _contentView.clipsToBounds = true;
    }
    return _contentView;
}


- (UIView *)contentClippingView {
    if (_contentClippingView == nil) {
        _contentClippingView = [[UIView alloc]init];
        _contentClippingView.backgroundColor = [UIColor whiteColor];
        _contentClippingView.clipsToBounds = true;
    }
    return _contentClippingView;
}

- (UIVisualEffectView *)blurredContentBackgroundView {
    if(_blurredContentBackgroundView == nil) {
        UIBlurEffect *contentEffect = [UIBlurEffect effectWithStyle:[UQUIKAppearance sharedInstance].blurStyle];
        _blurredContentBackgroundView = [[UIVisualEffectView alloc]initWithEffect:contentEffect];
        _blurredContentBackgroundView.hidden = !self.useBlur;
    }
    return _blurredContentBackgroundView;
}

- (UIView *)splitLine {
    if (_splitLine == nil) {
        _splitLine = [UIView new];
        _splitLine.backgroundColor = [UIColor colorWithRed:228./255 green:228./255 blue:228./255 alpha:1];
    }
    return _splitLine;
}

- (void)gotoCardListView {
    UQCardListViewController *viewController = [[UQCardListViewController alloc]init];
    viewController.data = self.data;
    [self pushtoNavigationController:viewController];
}

- (void)gotoCardAddView {
    UQAddCardViewController *viewController = [[UQAddCardViewController alloc]init];
    [self pushtoNavigationController:viewController];
}

- (UQCardItemView *)cardItemView {
    if (_cardItemView == nil) {
        _cardItemView = [[UQCardItemView alloc]init];
        [_cardItemView addTarget:self action:@selector(selectItem)];
    }
    return _cardItemView;
}

- (UIActivityIndicatorView *)activityIndicatorView {
    if (_activityIndicatorView == nil) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndicatorView.color = [UQUIKAppearance sharedInstance].defaultColor;
        _activityIndicatorView.backgroundColor = [UIColor clearColor];
        _activityIndicatorView.frame = CGRectMake(0, 0, 40, 40);
    }
    return _activityIndicatorView;
}

- (UIButton *)moreBtn {
    if (_moreBtn == nil) {
        _moreBtn = [UIButton new];
        [_moreBtn setTitle:UQUIKLocalizedString(UQ_MORE) forState:UIControlStateNormal];
        [_moreBtn setTitleColor:[UQUIKAppearance sharedInstance].defaultColor forState:UIControlStateNormal];
        [_moreBtn setTitleColor:[UQUIKAppearance sharedInstance].disabledColor forState:UIControlStateSelected];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_moreBtn addTarget:self action:@selector(gotoCardListView) forControlEvents:UIControlEventTouchUpInside];
        [_moreBtn sizeToFit];
    }
    return _moreBtn;
}

- (UILabel *)unExistCardLabel {
    if (_unExistCardLabel == nil) {
        _unExistCardLabel = [[UILabel alloc]init];
        _unExistCardLabel.font = [UIFont systemFontOfSize:16];
        _unExistCardLabel.textColor = [UIColor colorWithRed:153./255 green:153./255. blue:144./255 alpha:1];
        _unExistCardLabel.text = UQUIKLocalizedString(UQ_NO_CARD);
        [_unExistCardLabel sizeToFit];
    }
    return _unExistCardLabel;
}

- (UIButton *)addCardBtn {
    if (_addCardBtn == nil) {
        _addCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addCardBtn setBackgroundImage:[UQImageUtils rectangleImg] forState:UIControlStateNormal];
        [_addCardBtn setTitle:UQUIKLocalizedString(UQ_ADD_CARD) forState:UIControlStateNormal];
        [_addCardBtn setTitleColor:[UQUIKAppearance sharedInstance].defaultColor forState:UIControlStateNormal];
        _addCardBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _addCardBtn.frame = CGRectMake(0, 0, 128, 36);
        [_addCardBtn addTarget:self action:@selector(gotoCardAddView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addCardBtn;
}

- (UITapGestureRecognizer *)tapGestureRecognizer {
    if (_tapGestureRecognizer == nil) {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancel)];
        _tapGestureRecognizer.delegate = self;
    }
    return _tapGestureRecognizer;
}

- (void)initClient{
    [[UQHttpClient sharedInstance]setModelType:self.modelType];
    [[UQHttpClient sharedInstance] setToken:self.token];
}

- (void)initUI {
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.contentClippingView];
    [self.contentView addSubview:self.blurredContentBackgroundView];
    [self.contentView sendSubviewToBack:self.blurredContentBackgroundView];
    [self.contentView addSubview:self.toolbar];
    [self.contentView addSubview:self.splitLine];
    self.view.backgroundColor = [UQUIKAppearance sharedInstance].overlayColor;
    [self updateTooolbar];
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    [self.contentView addSubview:self.activityIndicatorView];
}


- (void)setupUI {
    self.contentView.frame = CGRectMake(UQ_HALF_SHEET_MARGIN, SystemUtils.SCREEN_HEIGHT - UQ_CONTENT_HEIGHT, SystemUtils.SCREEN_WIDTH - UQ_HALF_SHEET_MARGIN * 2, UQ_CONTENT_HEIGHT);
    self.blurredContentBackgroundView.frame = self.contentClippingView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), CGRectGetHeight(self.contentView.bounds));
    self.splitLine.frame = CGRectMake(0, CGRectGetMaxY(self.toolbar.frame), SystemUtils.SCREEN_WIDTH, 1);
    
    self.activityIndicatorView.center = CGPointMake(CGRectGetWidth(self.contentView.bounds) / 2, CGRectGetHeight(self.contentView.bounds) /2 + CGRectGetHeight(self.toolbar.bounds) /2);

}

- (void)initData {
    [self.activityIndicatorView startAnimating];
    
    [[UQHttpClient sharedInstance] getCardList:^(NSDictionary * _Nonnull dict, BOOL isSuccess) {
        if (isSuccess) {
            if (dict != nil && dict.count > 0) {
                CardListModel *model = [[CardListModel alloc]initWithDictionary:dict error:nil];
                if (model.data.count > 0) {
                    self.data = [model.data mutableCopy];
                    NSDictionary* indexDic = (NSDictionary*)model.data.firstObject;
                    self.resultModel = [[UQHostResult alloc]initWithDictionary:indexDic error:nil];
                }
                [self updateUI];
            }
        }
        [self.activityIndicatorView stopAnimating];
    } fail:^(NSError * _Nonnull error) {
        if ([self.delegate respondsToSelector:@selector(UQHostError:)]) {
            [self.delegate UQHostError:error];
        }
        [self cancel];
    }];
}


- (void)updateTooolbar {
    UILabel *titleLabel = [UQUIKAppearance styledNavigationTitleLabel];
    titleLabel.text = UQUIKLocalizedString(SELECT_BANK_CARD);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    titleLabel.tintColor = [UQUIKAppearance sharedInstance].cardTitleColor;
    titleLabel.font = [UIFont systemFontOfSize:17];
    [titleLabel sizeToFit];
    UIBarButtonItem *barTitle = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    fixed.width = 1.0;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UQImageUtils cardIcon] style:UIBarButtonItemStyleDone target:self action:nil];
    leftItem.tintColor = [UIColor colorWithRed:148./255 green:148./255 blue:148./255 alpha:1];
    [self.toolbar setItems:@[leftItem, flex, barTitle, flex, fixed] animated:YES];
    [self.toolbar invalidateIntrinsicContentSize];
}


- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)selectItem {
    if (self.delegate) {
        [self.delegate UQHostResult:self.resultModel];
    }
    [self cancel];
}

- (void)updateUI {
    [self.unExistCardLabel removeFromSuperview];
    [self.addCardBtn removeFromSuperview];
    [self.cardItemView removeFromSuperview];
    [self.moreBtn removeFromSuperview];
    if (self.resultModel != NULL) {
        self.cardItemView.cardId = self.resultModel.panTail;
        self.cardItemView.frame = CGRectMake(0, 38 + 55 , CGRectGetWidth(self.view.bounds), 24);
        [self.cardItemView setCardImageName:self.resultModel.issuer];
        [self.contentView addSubview:self.cardItemView];
        
        [self.contentView addSubview:self.moreBtn];
        self.moreBtn.center = CGPointMake(CGRectGetWidth(self.contentView.bounds)/2, CGRectGetMaxY(self.cardItemView.frame) + CGRectGetHeight(self.moreBtn.bounds) /2 + 20);
    } else {
        self.unExistCardLabel.center = CGPointMake(CGRectGetWidth(self.contentView.bounds) /2 , 88 + CGRectGetHeight(self.unExistCardLabel.bounds) /2);
        [self.contentView addSubview:self.unExistCardLabel];
        
        self.addCardBtn.center = CGPointMake(CGRectGetWidth(self.contentView.bounds) /2 , CGRectGetMaxY(self.unExistCardLabel.frame) + 12 + CGRectGetHeight(self.addCardBtn.bounds) /2);
        [self.contentView addSubview:self.addCardBtn];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(nonnull UITouch *)touch {
    if ([touch.view  isDescendantOfView:_contentView]) {
        return NO;
    }
    return YES;
}

@end

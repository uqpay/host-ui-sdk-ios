//
//  UQHttpClient.m
//  UQPayHostUI
//
//  Created by uqpay on 2019/7/8.
//  Copyright © 2019 优钱付. All rights reserved.
//

#import "UQHttpClient.h"
#if __has_include("AFNetworking.h")
#import "AFNetworking.h"
#else
#import <AFNetworking/AFNetworking.h>
#endif
#import "../Models/AddCardModel.h"
#import <WHToast/WHToast.h>


#define TEST  @"https://appgate.uqpay.net"
#define PRO   @"https://appgate.uqpay.com"
#define LOCAL @"https://appgate.uqpay.cn"

#define TimeoutInterval 30.0f

@interface UQHttpClient()

@property (nonatomic, assign) UQClientModelType modelType;
@property (nonatomic, getter=getUri) NSString * uri;
@property (nonatomic, getter=getUnbindUri) NSString *unbindUri;
@property (nonatomic, getter=getBindUri) NSString *bindUri;
@property (nonatomic, getter=getCardListUri) NSString *cardListUri;
@property (nonatomic, getter=getSmsUri) NSString *smsUri;
@property (nonatomic) NSString *token;

@end
@implementation UQHttpClient

static UQHttpClient *httpClient;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (httpClient == nil) {
            httpClient = [UQHttpClient new];
        }
    });
    return httpClient;
}

- (void)setToken:(NSString *)token {
    _token = token;
}

- (NSString *)getUri {
    switch (self.modelType) {
        case TESTTYPE:
            return TEST;
        case PROTYPE:
            return PRO;
        case LOCALTYPE:
            return LOCAL;
        default:
            return PRO;
    }
}

- (NSString *)getUnbindUri {
    return [NSString stringWithFormat:@"%@/api/hosted/revoke",httpClient.uri];
}

- (NSString *)getBindUri {
    return [NSString stringWithFormat:@"%@/api/hosted/enroll",httpClient.uri];
}

- (NSString *)getSmsUri {
    return [NSString stringWithFormat:@"%@/api/hosted/otp",httpClient.uri];
}

- (NSString *)getCardListUri {
    return [NSString stringWithFormat:@"%@/api/hosted/cardlist",httpClient.uri];
}

- (void)setModelType:(UQClientModelType)modelType {
    _modelType = modelType;
}


+ (AFHTTPSessionManager *)manager {
    static AFHTTPSessionManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = TimeoutInterval;
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    });
    return manager;
}

+ (void)getToken:(SuccessBlock)success fail:(FailureBlock)fail {
    NSString *URLString = @"https://demo.uqpay.cn/api/guest/hostinit";
    [[UQHttpClient manager]GET:URLString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"请求返回的进度");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-->%@",responseObject);
        if (responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:nil];
            success(dict, YES);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-->%@",error);
        fail(error);
    }];
}

- (void)getCardList:(SuccessBlock)success fail:(FailureBlock)fail{
    NSString *URLString = [NSString  stringWithFormat:@"%@", self.cardListUri];
    NSDictionary *parameters=@{@"token":self.token};
    [[UQHttpClient manager]GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"请求返回的进度");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-->%@",responseObject);
        if (responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:nil];
            success(dict, YES);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-->%@",error);
        fail(error);
    }];
}

- (void)postCardRevoke:(NSDictionary*)dic success:(SuccessBlock)success fail:(FailureBlock)fail {

    NSString *URLString = [NSString stringWithFormat:@"%@", self.unbindUri];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]initWithDictionary:dic];
    [parameters setValue:self.token forKey:@"token"];
    [parameters setValue:@"IOS" forKey:@"clientType"];
    [self postWithURL:URLString parameters:parameters Success:success fail:fail];
}


- (void)getSms:(NSDictionary*)dic success:(SuccessBlock)success fail:(FailureBlock)fail {
    NSString *URLString = [NSString stringWithFormat:@"%@", self.smsUri];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]initWithDictionary:dic];
    [parameters setValue:self.token forKey:@"token"];
    [parameters setValue:@"IOS" forKey:@"clientType"];
    [self postWithURL:URLString parameters:parameters Success:success fail:fail];
}

- (void)addCard:(AddCardModel*)model success:(SuccessBlock)success fail:(FailureBlock)fail {
    NSString *URLString = [NSString stringWithFormat:@"%@", self.bindUri];
    model.token = self.token;
    model.clientType = @"IOS";
    [self postWithURL:URLString parameters:[model toDictionary] Success:success fail:fail];
}

- (void)postWithURL:(NSString*)url parameters:(NSDictionary*)parameters Success:(SuccessBlock)success fail:(FailureBlock)fail {
    [[UQHttpClient manager]POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:NSJSONReadingMutableContainers
                                                               error:nil];
        success(dict, YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-->%@",[error domain]);
        [WHToast showMessage:[error localizedDescription] originY:([UIScreen mainScreen].bounds.size.height - 100) duration:2 finishHandler:nil];
        fail(error);
    }];
}

@end

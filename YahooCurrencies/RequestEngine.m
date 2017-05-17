//
//  RequestEngine.m
//  YahooCurrencies
//
//  Created by Темирлан Алпысбаев on 5/17/17.
//  Copyright © 2017 TemirlanAlpysbayev. All rights reserved.
//

#import "RequestEngine.h"

@implementation RequestEngine

static NSString * const APIUrl = @"http://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote?format=json";

+ (instancetype)shared {
    static RequestEngine *shared = nil;
    static dispatch_once_t session;
    
    dispatch_once(&session, ^{
        shared = [[self alloc] init];
    });

    return shared;
}

- (void)getCurrenciesWithCompletion:(ObjectBlock)completion {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    [[AFHTTPSessionManager manager] GET:APIUrl parameters:NULL progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *resultArray = responseObject[@"list"][@"resources"];
        NSMutableArray *currencies = [NSMutableArray array];
        NSArray *currs = @[@"KZT", @"RUB", @"KGS", @"EUR", @"GBP"];
        
        for (NSDictionary *d in resultArray) {
            Currency *currency = [Currency initWithData:d];
            
            if (currency && [currs containsObject:currency.name]) {
                [currencies addObject:currency];
            }
        }
        
        [DataController saveToCoreData:currencies];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        completion(currencies, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        completion(nil, error.localizedDescription);
    }];
}

@end

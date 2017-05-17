//
//  Currency.m
//  YahooCurrencies
//
//  Created by Темирлан Алпысбаев on 5/17/17.
//  Copyright © 2017 TemirlanAlpysbayev. All rights reserved.
//

#import "Currency.h"

@implementation Currency

+ (instancetype)initWithName:(NSString *)name price:(double)price {
    Currency *currency = [[Currency alloc] init];
    
    [currency setName:name];
    [currency setPrice:price];
    
    return currency;
}

+ (instancetype)initWithData:(NSDictionary *)data {
    Currency *currency = [[Currency alloc] init];
    
    NSArray *arr = [data[@"resource"][@"fields"][@"name"] componentsSeparatedByString:@"/"];
    
    if (arr.count == 2) {
        [currency setName:arr[1]];
        [currency setPrice:[data[@"resource"][@"fields"][@"price"] doubleValue]];
        
        return currency;
    } else {
        return nil;
    }

}

@end

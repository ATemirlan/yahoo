//
//  Currency.h
//  YahooCurrencies
//
//  Created by Темирлан Алпысбаев on 5/17/17.
//  Copyright © 2017 TemirlanAlpysbayev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Currency : NSObject

@property (nonatomic) double price;
@property (strong, nonatomic) NSString *name;

+ (instancetype)initWithName:(NSString *)name price:(double)price;
+ (instancetype)initWithData:(NSDictionary *)data;

@end

//
//  RequestEngine.h
//  YahooCurrencies
//
//  Created by Темирлан Алпысбаев on 5/17/17.
//  Copyright © 2017 TemirlanAlpysbayev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataController.h"
#import <AFNetworking.h>
#import "Currency.h"
#import "Utils.h"

@interface RequestEngine : NSObject

typedef void (^ ObjectBlock)(NSArray *currencies, NSString *error);

+ (instancetype)shared;

- (void)getCurrenciesWithCompletion:(ObjectBlock)completion;

@end

//
//  DataController.h
//  YahooCurrencies
//
//  Created by Темирлан Алпысбаев on 5/17/17.
//  Copyright © 2017 TemirlanAlpysbayev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataController : NSObject

+ (BOOL)isEmpty;
+ (NSArray *)fetchCurrencies;
+ (void)saveToCoreData:(NSArray *)currencies;

@end

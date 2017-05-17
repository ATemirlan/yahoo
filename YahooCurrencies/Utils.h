//
//  Utils.h
//  YahooCurrencies
//
//  Created by Темирлан Алпысбаев on 5/17/17.
//  Copyright © 2017 TemirlanAlpysbayev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Currency.h"

@interface Utils : NSObject

+ (void)saveMainCurrency:(Currency *)currency;
+ (Currency *)getMainCurrency;

+ (double)priceFrom:(double)price;

+ (void)saveFavourites:(NSArray *)favourites;
+ (NSMutableArray *)getFavourites;

@end

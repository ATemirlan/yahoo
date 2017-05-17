//
//  Utils.m
//  YahooCurrencies
//
//  Created by Темирлан Алпысбаев on 5/17/17.
//  Copyright © 2017 TemirlanAlpysbayev. All rights reserved.
//

#import "Utils.h"

@implementation Utils

static NSString * const mainCurrencyName = @"CURRENCY_NAME";
static NSString * const mainCurrencyPrice = @"CURRENCY_PRICE";
static NSString * const favouriteCurrencies = @"FAVOURITES";

+ (void)saveMainCurrency:(Currency *)currency {
    [[NSUserDefaults standardUserDefaults] setObject:currency.name forKey:mainCurrencyName];
    [[NSUserDefaults standardUserDefaults] setDouble:currency.price forKey:mainCurrencyPrice];
}

+ (Currency *)getMainCurrency {
    return [Currency initWithName:[[NSUserDefaults standardUserDefaults] objectForKey:mainCurrencyName]
                            price:[[[NSUserDefaults standardUserDefaults] objectForKey:mainCurrencyPrice] doubleValue]];
}

+ (double)priceFrom:(double)price {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:mainCurrencyPrice]) {
        double mainPrice = [[[NSUserDefaults standardUserDefaults] objectForKey:mainCurrencyPrice] doubleValue];
        return mainPrice / price;
    }
    
    return price;
}


+ (void)saveFavourites:(NSArray *)favourites {
    [[NSUserDefaults standardUserDefaults] setObject:favourites forKey:favouriteCurrencies];
}

+ (NSMutableArray *)getFavourites {
    if (![[NSUserDefaults standardUserDefaults] objectForKey:favouriteCurrencies]) {
        return [NSMutableArray array];
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:favouriteCurrencies];
}

@end

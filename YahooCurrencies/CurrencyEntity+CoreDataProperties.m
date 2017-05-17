//
//  CurrencyEntity+CoreDataProperties.m
//  YahooCurrencies
//
//  Created by Темирлан Алпысбаев on 5/17/17.
//  Copyright © 2017 TemirlanAlpysbayev. All rights reserved.
//

#import "CurrencyEntity+CoreDataProperties.h"

@implementation CurrencyEntity (CoreDataProperties)

+ (NSFetchRequest<CurrencyEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CurrencyEntity"];
}

@dynamic name;
@dynamic price;

@end

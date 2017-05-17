//
//  CurrencyEntity+CoreDataProperties.h
//  YahooCurrencies
//
//  Created by Темирлан Алпысбаев on 5/17/17.
//  Copyright © 2017 TemirlanAlpysbayev. All rights reserved.
//

#import "CurrencyEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CurrencyEntity (CoreDataProperties)

+ (NSFetchRequest<CurrencyEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) double price;

@end

NS_ASSUME_NONNULL_END

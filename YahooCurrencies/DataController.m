//
//  DataController.m
//  YahooCurrencies
//
//  Created by Темирлан Алпысбаев on 5/17/17.
//  Copyright © 2017 TemirlanAlpysbayev. All rights reserved.
//

#import "DataController.h"
#import "AppDelegate.h"
#import "Currency.h"
#import "CurrencyEntity+CoreDataClass.h"

@implementation DataController

+ (BOOL)isEmpty {
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = del.persistentContainer.viewContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CurrencyEntity"];
    NSError *error = nil;
    
    return [moc countForFetchRequest:request error:&error] == 0 ? YES : NO;
}

+ (NSArray *)fetchCurrencies {
    NSMutableArray *currencies = [NSMutableArray array];
    
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = del.persistentContainer.viewContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CurrencyEntity"];
    NSError *error = nil;
    
    NSArray *result = [moc executeFetchRequest:request error:&error];
    
    if (result) {
        for (CurrencyEntity *entity in result) {
            [currencies addObject:[Currency initWithName:entity.name price:entity.price]];
        }
    }
    
    return currencies;
}

+ (void)saveToCoreData:(NSArray *)currencies {
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = del.persistentContainer.viewContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CurrencyEntity"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    NSError *error = nil;
    
    NSArray *result = [moc executeFetchRequest:request error:&error];
    
    if (result.count == 0) {
        for (Currency *c in currencies) {
            CurrencyEntity *currencyEntity = [NSEntityDescription insertNewObjectForEntityForName:@"CurrencyEntity" inManagedObjectContext:moc];
            currencyEntity.name = c.name;
            currencyEntity.price = c.price;
        }
    } else {
        for (int i = 0; i < result.count - 1; i++) {
            CurrencyEntity *currencyEntity = [result objectAtIndex:i];
            currencyEntity.name = ((Currency *)currencies[i]).name;
            currencyEntity.price = ((Currency *)currencies[i]).price;
        }
    }
    
    error = nil;
    if ([moc save:&error] == NO) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
}

@end

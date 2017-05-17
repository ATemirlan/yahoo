//
//  ViewController.m
//  YahooCurrencies
//
//  Created by Темирлан Алпысбаев on 5/17/17.
//  Copyright © 2017 TemirlanAlpysbayev. All rights reserved.
//

#import "ViewController.h"
#import "SettingsViewController.h"
#import "CurrencyTableViewCell.h"
#import "RequestEngine.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *currencies;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setups];
}

- (void)fetchCurrenciesWithCompletion:(void (^)(UIBackgroundFetchResult))completion {
    [[RequestEngine shared] getCurrenciesWithCompletion:^(NSArray *currencies, NSString *error) {
        if (currencies.count > 0) {
            completion(UIBackgroundFetchResultNewData);
            NSLog(@"new data");
        }
    }];
}

- (void)setups {
    self.title = [Utils getMainCurrency].name;
    
    self.currencies = [Utils getFavourites];
    
    if (self.currencies.count == 0) {
        if (![DataController isEmpty]) {
            self.currencies = [DataController fetchCurrencies];
            [self.tableView reloadData];
        } else {
            [self getCurrencies];
        }
    } else {
        [self.tableView reloadData];
    }
    
}

- (void)getCurrencies {
    [[RequestEngine shared] getCurrenciesWithCompletion:^(NSArray *currencies, NSString *error) {
        if (currencies.count > 0) {
            self.currencies = currencies;
            [self.tableView reloadData];
        }
    }];
}

- (IBAction)edit:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"editSegue" sender:self.currencies];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currencies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    
    CurrencyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) cell = [[CurrencyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    
    if (indexPath.row <= self.currencies.count) {
        Currency *currency = self.currencies[indexPath.row];
        
        cell.nameLabel.text = currency.name;
        cell.priceLabel.text = [NSString stringWithFormat:@"%f", [Utils priceFrom:currency.price]];
    }
    
    return cell;
}

@end

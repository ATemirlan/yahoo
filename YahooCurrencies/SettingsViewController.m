//
//  SettingsViewController.m
//  YahooCurrencies
//
//  Created by Темирлан Алпысбаев on 5/17/17.
//  Copyright © 2017 TemirlanAlpysbayev. All rights reserved.
//

#import "SettingsViewController.h"
#import "FavoriteTableViewCell.h"
#import "OptionViewController.h"
#import "AppDelegate.h"
#import "Utils.h"

@interface SettingsViewController () <OptionDelegate>

@property (weak, nonatomic) IBOutlet UIButton *optionButton;
@property (strong, nonatomic) NSMutableArray *favourites;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.favourites = [Utils getFavourites];
    NSLog(@"%@", self.favourites);
    [self setups];
    
    if ([Utils getMainCurrency].name) {
        [self.optionButton setTitle:[NSString stringWithFormat:@"%@ ▼", [Utils getMainCurrency].name] forState:UIControlStateNormal];
    }
}

- (void)setups {
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (IBAction)save:(UIBarButtonItem *)sender {
    [Utils saveFavourites:self.favourites];
    [self goBack:nil];
}

- (IBAction)goBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)setCurrency:(UIButton *)sender {
    [self performSegueWithIdentifier:@"showPicker" sender:nil];
}

- (void)currencySet:(Currency *)currency {
    [self.optionButton setTitle:[NSString stringWithFormat:@"%@ ▼", currency.name] forState:UIControlStateNormal];
    [Utils saveMainCurrency:currency];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showPicker"]) {
        OptionViewController *vc = [segue destinationViewController];
        vc.delegate = self;
    }
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currencies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    
    FavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) cell = [[FavoriteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    
    if (self.currencies[indexPath.row]) {
        Currency *currency = self.currencies[indexPath.row];
        cell.currencyName.text = currency.name;
        
        cell.accessoryType = [self.favourites containsObject:currency] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FavoriteTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    Currency *currency = self.currencies[indexPath.row];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [self.favourites addObject:currency];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [self.favourites removeObject:currency];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end

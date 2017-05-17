//
//  OptionViewController.m
//  YahooCurrencies
//
//  Created by Темирлан Алпысбаев on 5/17/17.
//  Copyright © 2017 TemirlanAlpysbayev. All rights reserved.
//

#import "OptionViewController.h"
#import "DataController.h"

@interface OptionViewController () <UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) NSArray *currencies;

@end

@implementation OptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currencies = [DataController fetchCurrencies];
    self.view.backgroundColor = [UIColor clearColor];
}

- (IBAction)hide:(UITapGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate currencySet:((Currency *)self.currencies[[self.picker selectedRowInComponent:0]])];
    }];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return ((Currency *)self.currencies[row]).name;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.currencies.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

@end

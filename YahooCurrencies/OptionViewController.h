//
//  OptionViewController.h
//  YahooCurrencies
//
//  Created by Темирлан Алпысбаев on 5/17/17.
//  Copyright © 2017 TemirlanAlpysbayev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Currency.h"

@protocol OptionDelegate <NSObject>

- (void)currencySet:(Currency *)currency;

@end

@interface OptionViewController : UIViewController

@property (assign, nonatomic) id <OptionDelegate> delegate;

@end

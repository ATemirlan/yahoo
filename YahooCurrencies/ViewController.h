//
//  ViewController.h
//  YahooCurrencies
//
//  Created by Темирлан Алпысбаев on 5/17/17.
//  Copyright © 2017 TemirlanAlpysbayev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (void)fetchCurrenciesWithCompletion:(void (^)(UIBackgroundFetchResult))completion;

@end


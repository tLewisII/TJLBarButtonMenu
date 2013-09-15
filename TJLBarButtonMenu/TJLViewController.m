//
//  TJLViewController.m
//  TJLBarButtonMenu
//
//  Created by Terry Lewis II on 8/21/13.
//  Copyright (c) 2013 Terry Lewis. All rights reserved.
//

#import "TJLViewController.h"
#import "TJLBarButtonMenu.h"

@interface TJLViewController ()

@end

@implementation TJLViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (IBAction)showRight:(UIBarButtonItem *)sender {
    NSArray *images = @[
            [UIImage imageNamed:@"Blue"],
            [UIImage imageNamed:@"Green"]
    ];
    TJLBarButtonMenu *barMenu = [[TJLBarButtonMenu alloc]initWithViewController:self
                                                               images:images
                                                         buttonTitles:@[@"Blue", @"Green"]
                                                             position:TJLBarButtonMenuRightTop];
   
    [barMenu setButtonTappedBlock:^(TJLBarButtonMenu *buttonView, NSString *title) {
        NSLog(@"%@", title);
    }];
    [barMenu show];
}
- (IBAction)showLeft:(UIBarButtonItem *)sender {
    NSArray *images = @[
                        [UIImage imageNamed:@"Blue"],
                        [UIImage imageNamed:@"Green"],
                        [UIImage imageNamed:@"Orange"]
                        ];
    TJLBarButtonMenu *barMenu = [[TJLBarButtonMenu alloc]initWithViewController:self
                                                               images:images
                                                         buttonTitles:@[@"Blue", @"Green", @"Orange"]
                                                             position:TJLBarButtonMenuLeftTop];
    
    [barMenu setButtonTappedBlock:^(TJLBarButtonMenu *buttonView, NSString *title) {
        NSLog(@"%@", title);
    }];
    [barMenu show];
}

@end

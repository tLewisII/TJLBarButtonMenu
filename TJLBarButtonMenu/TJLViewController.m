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
@property(strong, nonatomic) TJLBarButtonMenu *barMenu;
@end

@implementation TJLViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (IBAction)showRight:(UIBarButtonItem *)sender {
    NSArray *images = @[
            [UIImage imageNamed:@"Blue"],
            [UIImage imageNamed:@"Green"],
            [UIImage imageNamed:@"Orange"]
    ];
    self.barMenu = [[TJLBarButtonMenu alloc]initWithView:self.view images:images buttonTitles:@[@"1", @"2", @"3"]];
   
    [self.barMenu setButtonTappedBlock:^(TJLBarButtonMenu *buttonView, NSString *title) {
        NSLog(@"%@", title);
    }];
    [self.barMenu show];
}

@end

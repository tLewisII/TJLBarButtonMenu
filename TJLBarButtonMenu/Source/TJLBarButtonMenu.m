//
//  TJLBarButtonMenu.m
//  TJLBarButtonMenu
//
//  Created by Terry Lewis II on 8/21/13.
//  Copyright (c) 2013 Terry Lewis. All rights reserved.
//

#import "TJLBarButtonMenu.h"
#import <objc/runtime.h>
static char key = 'b';
@interface TJLBarButtonMenu () {
    TJLButtonTappedBlock buttonTappedBlock;
}
@property(strong, nonatomic) NSMutableArray *constraintsArray;
@property(strong, nonatomic) NSMutableArray *firstConstraints;
@property(strong, nonatomic) UIViewController *parentView;
@property(strong, nonatomic) NSMutableArray *buttonArray;
@property(strong, nonatomic) id <TJLButtonViewDelegate> delegate;
@property(nonatomic) NSLayoutAttribute rightLeftPosition;
@property(nonatomic) NSLayoutAttribute initialButtonConstant;
@property(nonatomic) NSLayoutAttribute finalButtonConstant;
@property(nonatomic) NSLayoutAttribute finalButtonConstant1;
@end

@implementation TJLBarButtonMenu
- (instancetype)initWithViewController:(UIViewController *)viewController delegate:(id)delegate images:(NSArray *)images buttonTitles:(NSArray *)titles position:(TJLBarButtonMenuSide)position {
    self = [super init];
    if(!self) {
        return nil;
    }
    [self setupPositions:position];
    self.parentView = viewController;
    if(delegate) self.delegate = delegate;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:@[
            [NSLayoutConstraint
                    constraintWithItem:self
                             attribute:NSLayoutAttributeWidth
                             relatedBy:NSLayoutRelationEqual
                                toItem:nil
                             attribute:NSLayoutAttributeNotAnAttribute
                            multiplier:1.0
                              constant:150],
            [NSLayoutConstraint
                    constraintWithItem:self
                             attribute:NSLayoutAttributeHeight
                             relatedBy:NSLayoutRelationEqual
                                toItem:self
                             attribute:NSLayoutAttributeWidth
                            multiplier:1.0
                              constant:0]
    ]];
    self.backgroundColor = [UIColor clearColor];
    self.buttonArray = [NSMutableArray new];
    self.constraintsArray = [NSMutableArray new];

    for(NSUInteger i = 0; i < images.count; i++) {
        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.translatesAutoresizingMaskIntoConstraints = NO;
        [b setImage:images[i] forState:UIControlStateNormal];
        b.hidden = YES;
        [b addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        objc_setAssociatedObject(b, &key, titles[i], OBJC_ASSOCIATION_ASSIGN);
        self.buttonArray[i] = b;
        [self addSubview:b];
        NSLayoutConstraint *first = [NSLayoutConstraint
                constraintWithItem:b
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                            toItem:self
                         attribute:NSLayoutAttributeTop
                        multiplier:1.0
                          constant:-40];
        NSLayoutConstraint *second = [NSLayoutConstraint
                constraintWithItem:b
                         attribute:self.rightLeftPosition
                         relatedBy:NSLayoutRelationEqual
                            toItem:self
                         attribute:self.rightLeftPosition
                        multiplier:1.0
                          constant:self.initialButtonConstant];
        [self.constraintsArray addObject:@[first, second]];
        [self addConstraints:@[first, second]];
        [b addConstraints:@[
                [NSLayoutConstraint
                        constraintWithItem:b
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationLessThanOrEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:50],
                [NSLayoutConstraint
                        constraintWithItem:b
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationLessThanOrEqual
                                    toItem:b
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:0]
        ]];

    }

    return self;
}

- (void)setupPositions:(TJLBarButtonMenuSide)position {
    switch(position) {
        case TJLBarButtonMenuRightTop:
            self.rightLeftPosition = NSLayoutAttributeRight;
            self.initialButtonConstant = -10;
            self.finalButtonConstant = NSLayoutAttributeLeft;
            self.finalButtonConstant1 = 15;
            break;
        case TJLBarButtonMenuLeftTop:
            self.rightLeftPosition = NSLayoutAttributeLeft;
            self.initialButtonConstant = 10;
            self.finalButtonConstant = NSLayoutAttributeRight;
            self.finalButtonConstant1 = -15;
            break;
        default:
            break;
    }
}

- (instancetype)initWithViewController:(UIViewController *)viewController images:(NSArray *)images buttonTitles:(NSArray *)titles position:(TJLBarButtonMenuSide)position {
    return [self initWithViewController:viewController delegate:nil images:images buttonTitles:titles position:position];
}

- (void)buttonTapped:(UIButton *)sender {
    NSString *title = objc_getAssociatedObject(sender, &key);
    [self hide:title];
}

- (void)setButtonTappedBlock:(TJLButtonTappedBlock)block {
    buttonTappedBlock = [block copy];
}

- (void)show {
    [self.parentView.view addSubview:self];
    [self layoutSubviews];
    CGFloat position = (self.parentView.navigationController) ? 0 : 44;
    [self.parentView.view addConstraints:@[
            [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.parentView.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:position],
            [NSLayoutConstraint constraintWithItem:self attribute:self.rightLeftPosition relatedBy:NSLayoutRelationEqual toItem:self.parentView.view attribute:self.rightLeftPosition multiplier:1.0 constant:0]
    ]];
    [self.parentView.view layoutSubviews];
    self.firstConstraints = [@[
            @[[NSLayoutConstraint
                    constraintWithItem:self.buttonArray[0]
                             attribute:self.finalButtonConstant
                             relatedBy:NSLayoutRelationEqual
                                toItem:self
                             attribute:self.finalButtonConstant
                            multiplier:1.0
                              constant:self.finalButtonConstant1],
                    [NSLayoutConstraint
                            constraintWithItem:self.buttonArray[0]
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1.0
                                      constant:15]
            ],
            @[
                    [NSLayoutConstraint
                            constraintWithItem:self.buttonArray[1]
                                     attribute:self.rightLeftPosition
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:self.rightLeftPosition
                                    multiplier:1.0
                                      constant:self.initialButtonConstant],
                    [NSLayoutConstraint
                            constraintWithItem:self.buttonArray[1]
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1.0
                                      constant:-15]
            ]
    ] mutableCopy];

    if(self.buttonArray.count > 2) {
        self.firstConstraints[2] = @[
                [NSLayoutConstraint
                        constraintWithItem:self.buttonArray[2]
                                 attribute:self.finalButtonConstant
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:self.finalButtonConstant
                                multiplier:1.0
                                  constant:0],
                [NSLayoutConstraint
                        constraintWithItem:self.buttonArray[2]
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0]
        ];
    }
    ///You may see this and think to yourself, why is this not in a loop? It is not in a loop because UIButton's `hidden` property cannot
    ///be animated, so if it was run in a loop it would look weird, with buttons chilling on the bar button item before they moved.
    ///Setting the `alpha = 0` then animating it to 1.0 is an option, but it does not look as good, and since this is a small component, it can stay like this.
    [UIView animateWithDuration:.15 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.buttonArray[0] setHidden:NO];
        [self removeConstraints:self.constraintsArray[0]];
        [self addConstraints:self.firstConstraints[0]];
        [self layoutIfNeeded];
    }                completion:^(BOOL finished) {
        [UIView animateWithDuration:.15 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.buttonArray[1] setHidden:NO];
            [self removeConstraints:self.constraintsArray[1]];
            [self addConstraints:self.firstConstraints[1]];
            [self layoutIfNeeded];
        }                completion:^(BOOL complete) {
            [UIView animateWithDuration:.15 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                if(self.buttonArray.count > 2) {
                    [self.buttonArray[2] setHidden:NO];
                    [self removeConstraints:self.constraintsArray[2]];
                    [self addConstraints:self.firstConstraints[2]];
                    [self layoutIfNeeded];
                }
            }                completion:nil];
        }];
    }];
}

- (void)hide:(NSString *)buttonTitle {
    [UIView animateWithDuration:.15 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self removeConstraints:self.firstConstraints[0]];
        [self addConstraints:self.constraintsArray[0]];
        [self layoutIfNeeded];
    }                completion:^(BOOL finished) {
        [self.buttonArray[0] setHidden:YES];
        [UIView animateWithDuration:.15 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self removeConstraints:self.firstConstraints[1]];
            [self addConstraints:self.constraintsArray[1]];
            [self layoutIfNeeded];
        }                completion:^(BOOL complete) {
            [self.buttonArray[1] setHidden:YES];
            [UIView animateWithDuration:.15 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                if(self.buttonArray.count > 2) {
                    [self removeConstraints:self.firstConstraints[2]];
                    [self addConstraints:self.constraintsArray[2]];
                    [self layoutIfNeeded];
                }
            }                completion:^(BOOL final) {
                if(buttonTappedBlock) buttonTappedBlock(self, buttonTitle);
                if([self.delegate respondsToSelector:@selector(buttonMenu:titleForTappedButton:)]) [self.delegate buttonMenu:self titleForTappedButton:buttonTitle];
                [self removeFromSuperview];
            }];
        }];
    }];
}
@end

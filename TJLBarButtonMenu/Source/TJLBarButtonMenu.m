//
//  TJLBarButtonMenu.m
//  TJLBarButtonMenu
//
//  Created by Terry Lewis II on 8/21/13.
//  Copyright (c) 2013 Terry Lewis. All rights reserved.
//

#import "TJLBarButtonMenu.h"

@interface TJLBarButtonMenu () {
    TJLButtonTappedBlock buttonTappedBlock;
}
@property(strong, nonatomic) NSMutableArray *constraintsArray;
@property(strong, nonatomic) NSArray *firstConstraints;
@property(strong, nonatomic) UIView *parentView;
@property(strong, nonatomic) NSMutableArray *buttonArray;
@property(strong, nonatomic) id <TJLButtonViewDelegate> delegate;
@end

@implementation TJLBarButtonMenu
- (instancetype)initWithView:(UIView *)view delegate:(id)delegate images:(NSArray *)images buttonTitles:(NSArray *)titles {
    self = [super init];
    if(self) {
        self.parentView = view;
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
            [b setTitle:titles[i] forState:UIControlStateDisabled];
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
                             attribute:NSLayoutAttributeRight
                             relatedBy:NSLayoutRelationEqual
                                toItem:self
                             attribute:NSLayoutAttributeRight
                            multiplier:1.0
                              constant:-10];
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
                                      constant:60],
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
    }
    return self;
}

- (instancetype)initWithView:(UIView *)view images:(NSArray *)images buttonTitles:(NSArray *)titles {
    return [self initWithView:view delegate:nil images:images buttonTitles:titles];
}

- (void)buttonTapped:(UIButton *)sender {
    NSString *title = [sender titleForState:UIControlStateDisabled];
    [self hide:title];
}

- (void)setButtonTappedBlock:(TJLButtonTappedBlock)block {
    buttonTappedBlock = [block copy];
}

- (void)show {
    [self.parentView addSubview:self];
    [self layoutSubviews];
    [self.parentView addConstraints:@[
            [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.parentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:44],
            [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.parentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]
    ]];
    [self.parentView layoutSubviews];
    self.firstConstraints = @[
            @[[NSLayoutConstraint
                    constraintWithItem:self.buttonArray[0]
                             attribute:NSLayoutAttributeLeft
                             relatedBy:NSLayoutRelationEqual
                                toItem:self
                             attribute:NSLayoutAttributeLeft
                            multiplier:1.0
                              constant:15],
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
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeLeft
                                    multiplier:1.0
                                      constant:0],
                    [NSLayoutConstraint
                            constraintWithItem:self.buttonArray[1]
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1.0
                                      constant:0]
            ],
            @[
                    [NSLayoutConstraint
                            constraintWithItem:self.buttonArray[2]
                                     attribute:NSLayoutAttributeRight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeRight
                                    multiplier:1.0
                                      constant:-10],
                    [NSLayoutConstraint
                            constraintWithItem:self.buttonArray[2]
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1.0
                                      constant:-15]
            ]
    ];

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
                [self.buttonArray[2] setHidden:NO];
                [self removeConstraints:self.constraintsArray[2]];
                [self addConstraints:self.firstConstraints[2]];
                [self layoutIfNeeded];
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
                [self removeConstraints:self.firstConstraints[2]];
                [self addConstraints:self.constraintsArray[2]];
                [self layoutIfNeeded];
            }                completion:^(BOOL final) {
                if(buttonTappedBlock) buttonTappedBlock(self, buttonTitle);
                if([self.delegate respondsToSelector:@selector(buttonMenu:titleForTappedButton:)]) [self.delegate buttonMenu:self titleForTappedButton:buttonTitle];
                [self removeFromSuperview];
            }];
        }];
    }];
}
@end

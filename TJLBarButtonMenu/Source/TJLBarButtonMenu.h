//
//  TJLBarButtonMenu.h
//  TJLBarButtonMenu
//
//  Created by Terry Lewis II on 8/21/13.
//  Copyright (c) 2013 Terry Lewis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TJLBarButtonMenu;

@protocol TJLButtonViewDelegate <NSObject>
@optional
/**
 *       Sends the title of the button that was tapped.
 *@param buttonView The instance of the class that is currently active
 *@param title The title of the tapped button.
 */
- (void)buttonMenu:(TJLBarButtonMenu *)buttonMenu titleForTappedButton:(NSString *)title;
@end
typedef NS_ENUM(NSInteger, TJLBarButtonMenuSide) {
    TJLBarButtonMenuRightTop,
    TJLBarButtonMenuLeftTop
};
typedef void (^TJLButtonTappedBlock)(TJLBarButtonMenu *buttonView, NSString *title);

@interface TJLBarButtonMenu : UIView

- (instancetype)initWithView:(UIView *)view images:(NSArray *)images buttonTitles:(NSArray *)titles position:(TJLBarButtonMenuSide)position;

- (instancetype)initWithView:(UIView *)view delegate:(id <TJLButtonViewDelegate>)delegate images:(NSArray *)images buttonTitles:(NSArray *)titles position:(TJLBarButtonMenuSide)position;

- (void)show;

/**
 * A block that is called each time a button is tapped.
 @param block The block that will be called when a button is tapped.
 */
- (void)setButtonTappedBlock:(TJLButtonTappedBlock)block;

@end

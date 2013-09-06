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
 *@param buttonMenu The instance of the class that is currently active
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
/**
 *       Initializes and returns an instance of the button menu.
 *@param viewController The view controller to show in.
 *@param images The images used for the buttons, should be two or three images, but no more.
 *@param titles The title for each button, used for delegate and block callbacks to indicate which button was tapped.
 *@param position The position of the control, currently can be placed in the top left or top right of the view controller.
 *@return An instance of the class.
 */
- (instancetype)initWithViewController:(UIViewController *)viewController images:(NSArray *)images buttonTitles:(NSArray *)titles position:(TJLBarButtonMenuSide)position;

/**
 *       Initializes and returns an instance of the button menu.
 *@param viewController The view controller to show in.
 *@param delegate The delegate, if you choose to use the delegate method rather than the block method.
 *@param images The images used for the buttons, should be two or three images, but no more.
 *@param titles The title for each button, used for delegate and block callbacks to indicate which button was tapped.
 *@param position The position of the control, currently can be placed in the top left or top right of the view controller.
 *@return An instance of the class.
 */
- (instancetype)initWithViewController:(UIViewController *)viewController delegate:(id <TJLButtonViewDelegate>)delegate images:(NSArray *)images buttonTitles:(NSArray *)titles position:(TJLBarButtonMenuSide)position;

/**
 * Shows the control in the view controller it was initialized with.
 */
- (void)show;

/**
 * A block that is called each time a button is tapped.
 @param block The block that will be called when a button is tapped.
 */
- (void)setButtonTappedBlock:(TJLButtonTappedBlock)block;

@end

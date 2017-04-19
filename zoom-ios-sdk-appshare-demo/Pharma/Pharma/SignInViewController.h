//
//  SignInViewController.h
//  Pharma
//
//  Created by Robust on 16/1/23.
//
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView       *bgView;
@property (strong, nonatomic) IBOutlet UITextField  *emailField;
@property (strong, nonatomic) IBOutlet UITextField  *passField;
@property (strong, nonatomic) IBOutlet UIButton     *signInButton;

- (IBAction)onSignIn:(id)sender;

@end

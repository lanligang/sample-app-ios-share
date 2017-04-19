//
//  ContentViewController.h
//  Pharma
//
//  Created by Robust on 16/1/23.
//
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView           *shareView;
@property (strong, nonatomic) IBOutlet UIScrollView     *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl    *pageControl;
@property (strong, nonatomic) IBOutlet UIButton         *shareButton;
@property (strong, nonatomic) IBOutlet UIButton         *leaveButton;
@property (strong, nonatomic) IBOutlet UIButton         *showWeb;
@property (strong, nonatomic) IBOutlet UIButton         *hideWeb;

- (IBAction)onShare:(id)sender;
- (IBAction)onLeave:(id)sender;

@end

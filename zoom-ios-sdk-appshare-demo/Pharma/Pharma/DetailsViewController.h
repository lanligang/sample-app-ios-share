//
//  DetailsViewController.h
//  Pharma
//
//  Created by Robust on 16/1/23.
//
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton     *accountButton;
@property (strong, nonatomic) IBOutlet UIButton     *scheduleButton;
@property (strong, nonatomic) IBOutlet UIButton     *documentButton;

- (IBAction)onAccount:(id)sender;
- (IBAction)onSchedule:(id)sender;
- (IBAction)onDocument:(id)sender;

@end

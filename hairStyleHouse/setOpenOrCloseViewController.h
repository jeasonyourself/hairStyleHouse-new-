//
//  setOpenOrCloseViewController.h
//  hairStyleHouse
//
//  Created by jeason on 14-1-22.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface setOpenOrCloseViewController : UIViewController
{

}
@property(strong,nonatomic)NSString * _hidden;
@property (strong, nonatomic) IBOutlet UISwitch *firstSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *secondSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *thirdSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *forthSwitch;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
- (IBAction)saveButtonClick:(id)sender;

@end

//
//  toolBoxSingleCellViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-30.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "wayInforViewController.h"
@class toolBoxViewController;
@interface toolBoxSingleCellViewController : UIViewController

{
    wayInforViewController * wayView;
}
@property (nonatomic,strong)toolBoxViewController *fatherController;
@property (strong, nonatomic) IBOutlet UIView *fashionView;

- (IBAction)fashinButtonClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *protectView;

- (IBAction)protectButtonClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *storeView;

- (IBAction)storeButtonClick:(id)sender;

@end

//
//  sendEvaluateViewController.h
//  hairStyleHouse
//
//  Created by jeason on 14-4-12.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface sendEvaluateViewController : UIViewController
{
    NSString * string;
}
@property (strong, nonatomic) NSString * uid;
@property (strong, nonatomic) NSString * orderId;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segementView;
- (IBAction)segmentClick:(UISegmentedControl *)sender;

@property (strong, nonatomic) IBOutlet UITextView *evaluateView;

@property (strong, nonatomic) IBOutlet UIButton *sendButton;

- (IBAction)senfButtonClick:(id)sender;

- (IBAction)touchDown:(id)sender;


@end

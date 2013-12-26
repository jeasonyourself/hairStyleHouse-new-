//
//  pubImageViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pubImageViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    
    BOOL ifselectImage;
    NSString * sign1;
    NSString * sign2;
    NSString * sexString;
    NSString * hairStyle;
    NSMutableArray * imageArr;
}
@property(nonatomic,retain) NSString * _hidden;
@property (strong, nonatomic) IBOutlet UIImageView *firstImage;
@property (strong, nonatomic) IBOutlet UIImageView *secondImage;
@property (strong, nonatomic) IBOutlet UIImageView *thirdImage;
@property (strong, nonatomic) IBOutlet UIImageView *forthImage;
@property (strong, nonatomic) IBOutlet UITextView *deacribeText;
@property (strong, nonatomic) IBOutlet UIButton *firstButton;
@property (strong, nonatomic) IBOutlet UIButton *secondButton;
@property (strong, nonatomic) IBOutlet UIButton *thirdButton;
@property (strong, nonatomic) IBOutlet UIButton *forthButton;


@property (strong, nonatomic) IBOutlet UIButton *maleButton;
@property (strong, nonatomic) IBOutlet UIButton *femaleButton;
@property (strong, nonatomic) IBOutlet UIButton *shortButton;
@property (strong, nonatomic) IBOutlet UIButton *middleButton;
@property (strong, nonatomic) IBOutlet UIButton *longButton;
@property (strong, nonatomic) IBOutlet UIButton *otherButton;
@property (strong, nonatomic) IBOutlet UIButton *pubButton;

- (IBAction)firstButtonClick:(id)sender;

- (IBAction)maleButtonClick:(id)sender;
- (IBAction)femaleButtonClick:(id)sender;
- (IBAction)shortButtonClick:(id)sender;
- (IBAction)pubButtonClick:(id)sender;





@end

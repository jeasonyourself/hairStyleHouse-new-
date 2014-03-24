//
//  pubImageViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pubImageViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    
    BOOL ifselectImage;
    NSString * sign1;
    NSString * sign2;
    NSString * sign3;
    NSString * sexString;
    NSString * hairStyle;
    NSString * hairStyle1;
    NSString* imageString;
    NSMutableArray * imageArr;
    NSInteger imageNum;
//    UIControl * subView;
//    UIControl * alphaView;
    UITextField * severTime;
    UITextField * severPrice;
    UILabel * saleLable;
    UIButton * saleButton;
    UILabel * reallPriceLable;
    
   
    
    UIButton * sureButton;
    UIButton * cancelButton;
    UIAlertView* backAlert;
    UITableView * myTableView;
    NSMutableArray* saleArr;
}
@property(nonatomic,retain) NSString * _hidden;
@property(nonatomic,retain) NSString * dresserOrComment;


@property (strong, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) IBOutlet UIImageView *firstImage;
@property (strong, nonatomic) IBOutlet UIImageView *secondImage;
@property (strong, nonatomic) IBOutlet UIImageView *thirdImage;
@property (strong, nonatomic) IBOutlet UIImageView *forthImage;

@property (strong, nonatomic) IBOutlet UIView *secondBackView;


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

@property (strong, nonatomic) IBOutlet UIButton *allColorButton;
@property (strong, nonatomic) IBOutlet UIButton *changeColorButton;
@property (strong, nonatomic) IBOutlet UIButton *moveColorButton;
@property (strong, nonatomic) IBOutlet UIButton *manyColorButton;
@property (strong, nonatomic) IBOutlet UIView *_alphaView;

//
//@property (strong, nonatomic) IBOutlet UIButton *pubButton;
//@property (strong, nonatomic) IBOutlet UIButton *cancelButton;

- (IBAction)firstButtonClick:(id)sender;

- (IBAction)maleButtonClick:(id)sender;
- (IBAction)femaleButtonClick:(id)sender;
- (IBAction)shortButtonClick:(id)sender;
- (IBAction)colorButtonClick:(id)sender;

-(IBAction)textFiledReturnEditing:(id)sender;
- (IBAction)touchDown:(id)sender;

//
//- (IBAction)pubButtonClick:(id)sender;
//- (IBAction)cnacelButtonClick:(id)sender;





@end

//
//  pubImageViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "pubImageViewController.h"
#import "AppDelegate.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "BaiduMobStat.h"
@interface pubImageViewController ()

@end

@implementation pubImageViewController
@synthesize _hidden;
@synthesize dresserOrComment;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
    Lab.text = @"发布发型";
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
    [self refreashNav];
    
    
    _deacribeText.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _deacribeText.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _deacribeText.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _deacribeText.layer.masksToBounds = YES;//设为NO去试试
//    subView = [[UIControl alloc] initWithFrame:CGRectMake(0,+170, 320, 190)];
//    [subView addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
//    subView.backgroundColor =[UIColor redColor];
//    
//    alphaView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 320, 190)];
//    [alphaView addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
//    alphaView.backgroundColor =[UIColor redColor];
//    alphaView.alpha =0.5;
//    [subView addSubview:alphaView];
    
    
    
    
    
    UILabel * severTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 10+170, 200, 30)];
    severTimeLable.font = [UIFont systemFontOfSize:12.0];
    severTimeLable.textColor = [UIColor blackColor];
    severTimeLable.text = @"服务时间：               小时";
    [_secondBackView addSubview:severTimeLable];
    
    severTime = [[UITextField alloc] initWithFrame:CGRectMake(65, 15+170, 50, 22)];
    severTime.delegate = self;
    severTime.keyboardType = UIKeyboardTypeNumberPad;
    
    severTime.backgroundColor=[UIColor whiteColor];
    severTime.borderStyle = UITextBorderStyleRoundedRect;
    severTime.font = [UIFont systemFontOfSize:12.0];
    severTime.textAlignment = NSTextAlignmentCenter;
    
    severTime.layer.cornerRadius = 5;//设置那个圆角的有多圆
    severTime.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    severTime.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    severTime.layer.masksToBounds = YES;//设为NO去试试
    [_secondBackView addSubview:severTime];
    
    UILabel * severPriceLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 42+170, 200, 30)];
    severPriceLable.font = [UIFont systemFontOfSize:12.0];
    severPriceLable.textColor = [UIColor blackColor];
    severPriceLable.text = @"服务价格：               元";
    [_secondBackView addSubview:severPriceLable];
    
    severPrice = [[UITextField alloc] initWithFrame:CGRectMake(65, 47+170, 50, 22)];
    severPrice.delegate=self;
    severPrice.keyboardType = UIKeyboardTypeNumberPad;
    severPrice.textAlignment = NSTextAlignmentCenter;
    severPrice.backgroundColor=[UIColor whiteColor];
    severPrice.font = [UIFont systemFontOfSize:12.0];
    severPrice.borderStyle = UITextBorderStyleRoundedRect;
    severPrice.layer.cornerRadius = 5;//设置那个圆角的有多圆
    severPrice.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    severPrice.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    severPrice.layer.masksToBounds = YES;//设为NO去试试
    [_secondBackView addSubview:severPrice];
    
    
    UILabel * saleLable1 = [[UILabel alloc] initWithFrame:CGRectMake(170, 42+170, 200, 30)];
    saleLable1.font = [UIFont systemFontOfSize:12.0];
    saleLable1.textColor = [UIColor blackColor];
    saleLable1.text = @"优惠折扣：               折";
    [_secondBackView addSubview:saleLable1];
    
    saleLable = [[UILabel alloc] initWithFrame:CGRectMake(230, 47+170, 50, 22)];
    saleLable.backgroundColor=[UIColor whiteColor];
    saleLable.font = [UIFont systemFontOfSize:12.0];
    saleLable.text =@"9.5";
    saleLable.textAlignment = NSTextAlignmentCenter;
    saleLable.layer.cornerRadius = 5;//设置那个圆角的有多圆
    saleLable.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    saleLable.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    saleLable.layer.masksToBounds = YES;//设为NO去试试
    
    
    saleButton=[[UIButton alloc] init];
    saleButton.tag =1;
    saleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saleButton.layer setMasksToBounds:YES];
    [saleButton.layer setCornerRadius:5.0];
    
    [saleButton setBackgroundColor:[UIColor clearColor]];
    
    [saleButton addTarget:self action:@selector(saleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    saleButton.frame = saleLable.frame;
    
    [_secondBackView addSubview:saleButton];
    [_secondBackView addSubview:saleLable];
    
    UILabel * reallLable1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 75+170, 240, 30)];
    reallLable1.font = [UIFont systemFontOfSize:12.0];
    reallLable1.textColor = [UIColor blackColor];
    reallLable1.text = @"实际价格：";
    [_secondBackView addSubview:reallLable1];
    
    reallPriceLable = [[UILabel alloc] initWithFrame:CGRectMake(65, 75+170, 200, 30)];
    reallPriceLable.font = [UIFont systemFontOfSize:12.0];
    reallPriceLable.textColor = [UIColor blackColor];
    reallPriceLable.text = @"  --  元";
    [_secondBackView addSubview:reallPriceLable];
    
    saleArr = [[NSMutableArray alloc] initWithObjects:@"9.5",@"9",@"8.5",@"8",@"7.5",@"7",@"6.5",@"6",@"5.5",@"5",@"4.5",@"4",@"3.5",@"3",@"2.5",@"2",@"1.5",@"1",@"0.5", nil];
    
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(saleButton.frame.origin.x, saleButton.frame.origin.y+saleButton.frame.size.height, saleButton.frame.size.width, saleButton.frame.size.height*2+10) style:UITableViewStylePlain];
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.hidden = YES;
    myTableView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    myTableView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    myTableView.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    myTableView.layer.masksToBounds = YES;//设为NO去试试
    myTableView.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [_secondBackView addSubview:myTableView];
    
    
    
    
    
    
    sureButton=[[UIButton alloc] init];
    sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureButton.layer setMasksToBounds:YES];
    [sureButton.layer setCornerRadius:5.0];
    [sureButton.layer setBorderWidth:1.0];
    [sureButton setBackgroundColor:[UIColor colorWithRed:244.0/256.0 green:22.0/256.0 blue:96.0/256.0 alpha:1.0]];
    [sureButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [QQButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    sureButton.frame = CGRectMake(40,120+170, 100, 30);
    
    
    cancelButton=[[UIButton alloc] init];
    cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton.layer setMasksToBounds:YES];
    [cancelButton.layer setCornerRadius:5.0];
    [cancelButton.layer setBorderWidth:1.0];
    [cancelButton setBackgroundColor:[UIColor colorWithRed:172.0/256.0 green:172.0/256.0 blue:172.0/256.0 alpha:1.0]];
    [cancelButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [sinaButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.frame = CGRectMake(180, 120+170, 100, 30);
    
    [_secondBackView addSubview:sureButton];
    [_secondBackView addSubview:cancelButton];

//    [_secondBackView addSubview:subView];
    sexString= [[NSString alloc] init];
    sexString =@"1";
    sign1 = [[NSString alloc] init];
    sign2 = [[NSString alloc] init];
    sign3 = [[NSString alloc] init];
    
    
    hairStyle= [[NSString alloc] init];
    hairStyle=@"1";
    hairStyle1= [[NSString alloc] init];
    hairStyle1=@"1";
    ifselectImage = NO;
    imageArr = [[NSMutableArray alloc] init];


    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{

    NSString* cName = [NSString stringWithFormat:@"发布发型"];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    CGFloat keyboardTop = keyboardRect.origin.y;
    CGRect newTextViewFrame = self.view.bounds;
    newTextViewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
    
    newTextViewFrame.origin.y =newTextViewFrame.size.height+80-self.view.bounds.size.height;//自己加的，特为此界面定制
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    _backView.frame = newTextViewFrame;
    NSLog(@"_backView.frame:%@",NSStringFromCGRect(self.view.frame));
    
    [UIView commitAnimations];
}
- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    _backView.frame = self.view.bounds;
    
    [UIView commitAnimations];
}

-(void)viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"发布发型"];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)touchDown1
{
    [severPrice resignFirstResponder];
    [severTime resignFirstResponder];
    
}

-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
    
}

- (IBAction)touchDown:(id)sender
{
    [self textFiledReturnEditing:severPrice];
    [self textFiledReturnEditing:severTime];
    [_deacribeText resignFirstResponder];

}

#pragma mark -textField 代理

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    saleButton.tag=1;
    myTableView.hidden=YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if(textField == severPrice)
    {
        NSString *tmpStr = @"" ;
        tmpStr = textField.text ;
        tmpStr = [tmpStr stringByReplacingCharactersInRange:range withString:string];
        
        NSInteger oldInt= [tmpStr integerValue];
        float saleInt= [saleLable.text floatValue]/10;
        float nowInt = oldInt*saleInt;
        reallPriceLable.text = [NSString stringWithFormat:@"%.1lf 元",nowInt];
        return YES;
        
    }
    //其他的类型不需要检测，直接写入
    return YES;
}


-(void)sureButtonClick
{
    
    
    if ([_deacribeText.text isEqualToString:@""])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"尚未描述作品" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (ifselectImage==NO)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"尚未选择任何图片" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([severTime.text isEqualToString:@""]&&[dresserOrComment isEqualToString:@"dresser"])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"尚未填写服务时长" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([severPrice.text isEqualToString:@""]&&[dresserOrComment isEqualToString:@"dresser"])
    {
        
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"尚未填写服务价格" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([saleLable.text isEqualToString:@""]&&[dresserOrComment isEqualToString:@"dresser"])
    {
        
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"尚未填写服务折扣" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Up&a=add_img"]];
        
        
        
        for (UIImageView  * imageview in imageArr)
        {
            NSData *imageData = UIImageJPEGRepresentation(imageview.image, 1.0);
            NSUInteger dataLength = [imageData length];
            
            if(dataLength > MAX_IMAGEDATA_LEN) {
                imageData = UIImageJPEGRepresentation(imageview.image, 1.0 - MAX_IMAGEDATA_LEN / dataLength);
            } else {
                imageData = UIImageJPEGRepresentation(imageview.image, 1.0);
            }
            
            [request appendPostData:imageData];
            request.delegate=self;
            request.tag=1;
            [request startAsynchronous];
            
        }
    }
    

}



-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"预约失败" message:@"网络连接失败" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)cancelButtonClick
{
    [self leftButtonClick];
}

-(void)saleButtonClick
{
    [self touchDown1];
    
    if (saleButton.tag==1) {
        myTableView.hidden =NO;
        saleButton.tag=2;
    }
    else
    {
        myTableView.hidden =YES;
        saleButton.tag=1;
        
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return saleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   myTableView.frame.size.height/2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor =[UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    cell.textLabel.text = [saleArr objectAtIndex:[indexPath row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    saleButton.tag=1;
    saleLable.text=[saleArr objectAtIndex:[indexPath row]];
    myTableView.hidden=YES;
    
    NSInteger oldInt= [severPrice.text integerValue];
    float saleInt= [saleLable.text floatValue]/10;
    float nowInt = oldInt*saleInt;
    reallPriceLable.text = [NSString stringWithFormat:@"%.1lf 元",nowInt];
}


-(void)leftButtonClick
{
    if ([_hidden isEqualToString:@"yes"])
    {
        self.navigationController.navigationBar.hidden=YES;
        
    }
    else
    {
        self.navigationController.navigationBar.hidden=NO;
        
    }

    [self.navigationController popViewControllerAnimated:NO];
    
}
-(void)refreashNav
{
    UIButton * leftButton=[[UIButton alloc] init];
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton.layer setMasksToBounds:YES];
    [leftButton.layer setCornerRadius:3.0];
    [leftButton.layer setBorderWidth:1.0];
    [leftButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [leftButton setBackgroundColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0]];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(12,20, 60, 25);
    UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firstButtonClick:(id)sender {
    
    UIButton * button = (UIButton *)sender;
    if (button.tag==1)
    {
        sign1=@"1";
    }
    else if (button.tag==2)
    {
        sign1=@"2";
    }
    else if (button.tag==3)
    {
        sign1=@"3";
    }
    else if (button.tag==4)
    {
        sign1=@"4";
    }
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择方式"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"现在去拍照"
                                  otherButtonTitles:@"从相册选择",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            NSArray *temp_MediaTypes = [[NSArray alloc] initWithObjects: (NSString *)  kUTTypeImage  , nil];//如果只实现拍照或者摄像都要，那么就要用到#import <MobileCoreServices/MobileCoreServices.h>
            picker.mediaTypes = temp_MediaTypes;
            picker.allowsEditing = NO;
//            picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            picker.delegate = self;
            //      picker.allowsImageEditing = YES;
        }
        [self presentViewController:picker animated:YES completion:nil];
        
    }
    else if (buttonIndex == 1)
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSArray *temp_MediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];//如果只实现拍照或者摄像都要，那么就要用到#import <MobileCoreServices/MobileCoreServices.h>
            picker.mediaTypes = temp_MediaTypes;
            picker.delegate = self;
            
            //      picker.allowsImageEditing = YES;
        }
        [self presentViewController:picker animated:YES completion:nil];
    }
    else if(buttonIndex == 2)
    {
        
    }
}



- (void)actionSheetCancel:(UIActionSheet *)actionSheet{
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    
}
//NSSearchPathForDirectoriesInDomains，NSFileManager，NSBundle
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    //    BOOL success;
    //    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    if ([mediaType isEqualToString:@"public.image"]){
        
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSLog(@"found an image");
        if ([sign1 isEqualToString:@"1"])
        {
            _firstImage.image = image;
//            if ([imageArr objectAtIndex:0]) {
//                [imageArr removeObjectAtIndex:0];
//            }
            
            [imageArr addObject:_firstImage];
        }
        else if([sign1 isEqualToString:@"2"])
        {
            _secondImage.image = image;
//            if ([imageArr objectAtIndex:1]) {
//                [imageArr removeObjectAtIndex:1];
//            }
            
            [imageArr addObject:_secondImage];
        }
        else if([sign1 isEqualToString:@"3"])
        {
            _thirdImage.image = image;
//            if ([imageArr objectAtIndex:2]) {
//                [imageArr removeObjectAtIndex:2];
//            }
//            
            [imageArr addObject:_thirdImage];
        }
        else if([sign1 isEqualToString:@"4"])
        {
            _forthImage.image = image;
//            if ([imageArr objectAtIndex:3]) {
//                [imageArr removeObjectAtIndex:3];
//            }
            
            [imageArr addObject:_forthImage];
        }
        ifselectImage =YES;
        [picker dismissViewControllerAnimated:NO completion:nil];
//        _headImage.image = image;
//        ifchangeHeadImage =YES;
        
        //        NSData* imageData = UIImagePNGRepresentation(image);
        //        NSString *imageFile = [documentsDirectory stringByAppendingPathComponent:@"temp.jpg"];
        //        NSLog(@"%@", imageFile);
        
        //        success = [fileManager fileExistsAtPath:imageFile];
        //        if(success) {
        //            success = [fileManager removeItemAtPath:imageFile error:nil];
        //        }
        //        //        imageView.image = image;
        //        [imageData writeToFile:imageFile atomically:YES];//保存到文件
        //        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);//保存到相册
        
    }
}



- (IBAction)maleButtonClick:(id)sender {
    [_maleButton setBackgroundImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateNormal];
    [_femaleButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
    sexString = @"1";
    
}

- (IBAction)femaleButtonClick:(id)sender {
    [_maleButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
    [_femaleButton setBackgroundImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateNormal];
    sexString = @"0";
}

- (IBAction)shortButtonClick:(id)sender
{
    UIButton * button = (UIButton *)sender;
    if (button.tag==1)
    {
        sign2=@"1";
        [_shortButton setBackgroundImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateNormal];
        [_middleButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        [_longButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        [_otherButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        
    }
    else if (button.tag==2)
    {
        sign2=@"2";
        [_shortButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        [_middleButton setBackgroundImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateNormal];
        [_longButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        [_otherButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
    }
    else if (button.tag==3)
    {
        sign2=@"3";
        [_shortButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        [_middleButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        [_longButton setBackgroundImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateNormal];
        [_otherButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
    }
    else if (button.tag==4)
    {
        sign2=@"4";
        [_shortButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        [_middleButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        [_longButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        [_otherButton setBackgroundImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)colorButtonClick:(id)sender {
    
    
    
    
    
    UIButton * button = (UIButton *)sender;
    if (button.tag==1)
    {
        sign3=@"1";
        [_allColorButton setBackgroundImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateNormal];
        [_changeColorButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        [_moveColorButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        [_manyColorButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        
    }
    else if (button.tag==2)
    {
        sign3=@"2";
        [_allColorButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        [_changeColorButton setBackgroundImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateNormal];
        [_moveColorButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        [_manyColorButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
    }
    else if (button.tag==3)
    {
        sign3=@"3";
        [_allColorButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        [_changeColorButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        [_moveColorButton setBackgroundImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateNormal];
        [_manyColorButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
    }
    else if (button.tag==4)
    {
        sign3=@"4";
        [_allColorButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        [_changeColorButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        [_moveColorButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
        [_manyColorButton setBackgroundImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateNormal];
    }

}

- (IBAction)pubButtonClick:(id)sender
{
    
  }


-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (request.tag==2)
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"上传图片是否成功dic:%@",dic);
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"上传成功" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
        [self leftButtonClick];
    }
    else if (request.tag==1)
        {
            NSLog(@"%@",request.responseString);
            NSData*jsondata = [request responseData];
            NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            SBJsonParser* jsonP=[[SBJsonParser alloc] init];
            NSDictionary* dic=[jsonP objectWithString:jsonString];
            NSLog(@"图片地址dic:%@",dic);
            NSString * headString=[dic objectForKey:@"image"];
            
            NSURL * url ;
            if ([dresserOrComment isEqualToString:@"dresser"]) {
                url=[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Works&a=newAddWorks"];
            }
            else
            {
                url=[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Works&a=add_works"];
            }
            
            AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
            ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:url];
            request.delegate=self;
            request.tag=2;
            if ([dresserOrComment isEqualToString:@"dresser"])
            {
                [request setPostValue:appDele.uid forKey:@"uid"];
                [request setPostValue:appDele.userName forKey:@"username"];
                [request setPostValue:appDele.type forKey:@"type"];
                [request setPostValue:_deacribeText.text forKey:@"content"];
                [request setPostValue:headString forKey:@"work_image"];
                [request setPostValue:sexString forKey:@"sex"];
                [request setPostValue:hairStyle forKey:@"face"];
                [request setPostValue:hairStyle1 forKey:@"hair_color"];
                [request setPostValue:severTime.text forKey:@"long_service"];
                [request setPostValue:severPrice.text forKey:@"price"];
                [request setPostValue:saleLable.text forKey:@"rebate"];

            }
            else
            {
                [request setPostValue:appDele.uid forKey:@"uid"];
                [request setPostValue:appDele.userName forKey:@"username"];
                [request setPostValue:appDele.type forKey:@"type"];
                [request setPostValue:_deacribeText.text forKey:@"content"];
                [request setPostValue:headString forKey:@"work_image"];
//                [request setPostValue:sexString forKey:@"sex"];
//                [request setPostValue:hairStyle forKey:@"hair_type"];
            }
            
            
            [request startAsynchronous];
        }
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end

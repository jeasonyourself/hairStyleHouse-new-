//
//  enterPubWayViewController.m
//  hairStyleHouse
//
//  Created by jeason on 14-3-28.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import "enterPubWayViewController.h"
#import "AppDelegate.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "UIImageView+WebCache.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "BaiduMobStat.h"
@interface enterPubWayViewController ()

@end

@implementation enterPubWayViewController
@synthesize scrollView;
@synthesize style;
@synthesize _hidden;
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
    [self refreashNav];
    [self refreashNavLab];
    _secondButton.hidden=YES;
    _secondTextView.hidden=YES;
    _thirdButton.hidden =YES;
    _thirdTextView.hidden = YES;
    _forthButton.hidden = YES;
    _forthTextView.hidden=YES;
    _addButton.hidden =YES;
    _sendButton.hidden = YES;
    _addButton.frame = CGRectMake(20, 135, 280, 30);
    _sendButton.frame = CGRectMake(20, 175, 280, 30);
    
    
    ifChangeImage =NO;
    ifChangeImage2 =NO;
    ifChangeImage3 =NO;
    ifChangeImage4 =NO;
    
    firstImage =[[UIImageView alloc] init];
    secondImage = [[UIImageView alloc ] init];
    thirdImage = [[UIImageView alloc] init];
    forthImage = [[UIImageView alloc] init];


    imageString1 = [[NSString alloc] init];
imageString2 = [[NSString alloc] init];imageString3 = [[NSString alloc] init];imageString4 = [[NSString alloc] init];
    whichImage=[[NSString alloc] init];
    howMuchImage=[[NSString alloc] init];
    howMuchImage=@"1";
    // Do any additional setup after loading the view from its nib.
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //创建一个UIActivityIndicatorView对象：_activityIndicatorView，并初始化风格。
    _activityIndicatorView.frame = CGRectMake(160, self.view.center.y, 0, 0);
    //设置对象的位置，大小是固定不变的。WhiteLarge为37 * 37，White为20 * 20
    _activityIndicatorView.color = [UIColor grayColor];
    //设置活动指示器的颜色
    _activityIndicatorView.hidesWhenStopped = YES;
    //hidesWhenStopped默认为YES，会隐藏活动指示器。要改为NO
    [self.view addSubview:_activityIndicatorView];
    //将对象加入到view
}
-(void)viewDidAppear:(BOOL)animated
{
    

    _addButton.hidden =NO;
    _sendButton.hidden = NO;
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
    leftButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [leftButton setBackgroundColor:[UIColor clearColor]];
    [leftButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(0,28, 60, 25);
//    UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0];
//    self.navigationItem.leftBarButtonItem=leftButtonItem;
}
-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)refreashNavLab
{
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 7, 100, 30)];
    
    if ([self.style  isEqualToString:@"2"]) {
        Lab.text = @"发布行业名人";
        
    }
    else if ([self.style  isEqualToString:@"5"]) {
        Lab.text = @"发布优惠活动";
        
    }
    else if ([self.style  isEqualToString:@"1"]) {
        Lab.text = @"发布品牌名店";
        
    }
    else if ([self.style  isEqualToString:@"3"]) {
        Lab.text = @"发布行业新闻";
        
    }
    
    
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_titlfield resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [scrollView adjustOffsetToIdealIfNeeded];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [scrollView adjustOffsetToIdealIfNeeded];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)picButtonClick:(id)sender
{
    
    UIButton * _btn = (UIButton *)sender;
    if(_btn.tag==1)
    {
    whichImage=@"1";
    }
    else if(_btn.tag==2)
    {
        whichImage=@"2";
    }
    else if(_btn.tag==3)
    {
        whichImage=@"3";
    }
    else if(_btn.tag==4)
    {
        whichImage=@"4";
    }
    
        [_firstTextView resignFirstResponder];
        [_secondTextView resignFirstResponder];
        [_thirdTextView resignFirstResponder];
        [_forthTextView resignFirstResponder];

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
        
        if ([mediaType isEqualToString:@"public.image"]){
            
            UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            NSLog(@"found an image");
            if([whichImage isEqualToString:@"1"])
            {
                [_firstButton setBackgroundImage:image forState:UIControlStateNormal];
                firstImage.image =image;
                ifChangeImage = YES;

            }
            else if([whichImage isEqualToString:@"2"])
            {
                [_secondButton setBackgroundImage:image forState:UIControlStateNormal];
                secondImage.image = image;
                ifChangeImage2 = YES;

                
            }
            else if([whichImage isEqualToString:@"3"])
            {
                [_thirdButton setBackgroundImage:image forState:UIControlStateNormal];
                thirdImage.image = image;
                ifChangeImage3 = YES;

            }
            else if([whichImage isEqualToString:@"4"])
            {
                [_forthButton setBackgroundImage:image forState:UIControlStateNormal];
                forthImage.image = image;
                ifChangeImage4 = YES;

            }
            [picker dismissViewControllerAnimated:NO completion:nil];
            
            
        }
    }

- (IBAction)addButtonClick:(id)sender {
    UIButton * _btn = (UIButton*)sender;
    if (_btn.tag==1) {
        howMuchImage=@"2";
        _secondButton.hidden=NO;
        _secondTextView.hidden=NO;
        _addButton.frame = CGRectMake(20, 210, 280, 30);
        _sendButton.frame = CGRectMake(20, 250, 280, 30);
        _addButton.tag=2;
    }
    else if (_btn.tag==2) {
        howMuchImage=@"3";

        _thirdTextView.hidden=NO;
        _thirdButton.hidden=NO;
        _addButton.frame = CGRectMake(20, 285, 280, 30);
        _sendButton.frame = CGRectMake(20, 325, 280, 30);
        _addButton.tag=3;
    }
    else if (_btn.tag==3) {
        howMuchImage=@"4";

        _forthTextView.hidden=NO;
        _forthButton.hidden=NO;
        _addButton.hidden=YES;
        _sendButton.frame = CGRectMake(20, 365, 280, 30);
    }
    
}

- (IBAction)sendButtonClick:(id)sender
{
    if ([_titlfield.text isEqualToString:@""])
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请完善发布标题" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    else//填写标题后判断几条描述
    {
    if([howMuchImage isEqualToString:@"1"])
    {
        if (ifChangeImage==NO||[_firstTextView.text isEqualToString:@""])
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请完善发布内容" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        else
        {
            [self putData];
        }

    }
    else if([howMuchImage isEqualToString:@"2"])
    {
        if (ifChangeImage==NO||[_firstTextView.text isEqualToString:@"" ]||ifChangeImage2==NO||[_secondTextView.text isEqualToString:@"" ])
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请完善发布内容" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show]
            ;
        }
        else
        {
            [self putData];
        }
        
    }
    else  if([howMuchImage isEqualToString:@"3"])
    {
        if (ifChangeImage==NO||[_firstTextView.text isEqualToString:@"" ]||ifChangeImage2==NO||[_secondTextView.text isEqualToString:@"" ]||ifChangeImage3==NO||[_thirdTextView.text isEqualToString:@"" ])
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请完善发布内容" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show]
            ;
        }
        else
        {
            [self putData];
        }
        
    }
    else  if([howMuchImage isEqualToString:@"4"])
    {
        if (ifChangeImage==NO||[_firstTextView.text isEqualToString:@"" ]||ifChangeImage2==NO||[_secondTextView.text isEqualToString:@"" ]||ifChangeImage3==NO||[_thirdTextView.text isEqualToString:@"" ]||ifChangeImage4==NO||[_forthTextView.text isEqualToString:@"" ])
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请完善发布内容" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show]
            ;
        }
        else
        {
            [self putData];
        }
        
    }
    }
}
-(void)putData
{
    
    [_activityIndicatorView startAnimating];
    //    //开始动画
    _sendButton.userInteractionEnabled =NO;
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=up&a=add_img"]];
    
    UIImageView  * imageview =firstImage;
    NSData *imageData = UIImageJPEGRepresentation(imageview.image, 1.0);
    NSUInteger dataLength = [imageData length];
    
    if(dataLength > MAX_IMAGEDATA_LEN)
    {
        imageData = UIImageJPEGRepresentation(imageview.image, 1.0 - MAX_IMAGEDATA_LEN / dataLength);
    } else
    {
        imageData = UIImageJPEGRepresentation(imageview.image, 1.0);
    }
    
    [request appendPostData:imageData];
    request.delegate=self;
    request.tag=1;
    [request startAsynchronous];
    
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (request.tag==101)
    {
        _sendButton.userInteractionEnabled =YES;
        
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"上传论坛是否成功dic:%@",dic);
        
        [_activityIndicatorView stopAnimating];
        _activityIndicatorView.hidesWhenStopped = YES;
        if ([[dic objectForKey:@"code"] isEqualToString:@"101"]) {
             UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"上传成功" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
        }
        
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
    else if (request.tag==1)
    {
        
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"图片地址dic:%@",dic);
        if ([[dic objectForKey:@"code"] isEqualToString:@"101"])
        {
            NSString * headString=[dic objectForKey:@"image"];
            
            imageString1 = [NSString stringWithFormat:@"%@",headString];
            if ([howMuchImage isEqualToString:@"1"])
            {
                [self pubImage];
                
            }
            
            else
            {
                
                ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=up&a=add_img"]];
                UIImageView  * imageview =secondImage;
                NSLog(@"%@",imageview);
                
                
                NSData *imageData = UIImageJPEGRepresentation(imageview.image, 1.0);
                NSUInteger dataLength = [imageData length];
                
                if(dataLength > MAX_IMAGEDATA_LEN)
                {
                    imageData = UIImageJPEGRepresentation(imageview.image, 1.0 - MAX_IMAGEDATA_LEN / dataLength);
                }
                else
                {
                    imageData = UIImageJPEGRepresentation(imageview.image, 1.0);
                }
                
                [request appendPostData:imageData];
                request.delegate=self;
                request.tag=2;
                
                [request startAsynchronous];
                
            }
            
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"上传图片出错" delegate:Nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }
    
    else if (request.tag==2)
    {
        
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"图片地址dic:%@",dic);
        
        if ([[dic objectForKey:@"code"] isEqualToString:@"101"])
        {
            NSString * headString=[dic objectForKey:@"image"];
            
            imageString2 = [NSString stringWithFormat:@"%@",headString];
            
            if ([howMuchImage isEqualToString:@"2"])
            {
                [self pubImage];
                
            }
            
            else
            {
                ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=up&a=add_img"]];
                UIImageView  * imageview =thirdImage;
                NSData *imageData = UIImageJPEGRepresentation(imageview.image, 1.0);
                NSUInteger dataLength = [imageData length];
                
                if(dataLength > MAX_IMAGEDATA_LEN)
                {
                    imageData = UIImageJPEGRepresentation(imageview.image, 1.0 - MAX_IMAGEDATA_LEN / dataLength);
                } else
                {
                    imageData = UIImageJPEGRepresentation(imageview.image, 1.0);
                }
                
                [request appendPostData:imageData];
                request.delegate=self;
                request.tag=3;
                [request startAsynchronous];
            }
            
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"上传图片出错" delegate:Nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }
    
    else if (request.tag==3)
    {
        
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"图片地址dic:%@",dic);
        NSString * headString=[dic objectForKey:@"image"];
        if ([[dic objectForKey:@"code"] isEqualToString:@"101"])
        {
            imageString3 = [NSString stringWithFormat:@"%@",headString];
            
            if ([howMuchImage isEqualToString:@"3"])
            {
                [self pubImage];
                
            }
            
            else
            {
                ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=up&a=add_img"]];
                UIImageView  * imageview =forthImage;
                NSData *imageData = UIImageJPEGRepresentation(imageview.image, 1.0);
                NSUInteger dataLength = [imageData length];
                
                if(dataLength > MAX_IMAGEDATA_LEN)
                {
                    imageData = UIImageJPEGRepresentation(imageview.image, 1.0 - MAX_IMAGEDATA_LEN / dataLength);
                } else
                {
                    imageData = UIImageJPEGRepresentation(imageview.image, 1.0);
                }
                
                [request appendPostData:imageData];
                request.delegate=self;
                request.tag=4;
                [request startAsynchronous];
            }
            
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"上传图片出错" delegate:Nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }
    
    else if (request.tag==4)
    {
        
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"图片地址dic:%@",dic);
        NSString * headString=[dic objectForKey:@"image"];
        if ([[dic objectForKey:@"code"] isEqualToString:@"101"])
        {
            imageString4 = [NSString stringWithFormat:@"%@",headString];
            [self pubImage];
        }
        else
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"上传图片出错" delegate:Nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }
    
    
}


-(void)requestFailed:(ASIHTTPRequest *)request
{
    _sendButton.userInteractionEnabled =YES;
    [_activityIndicatorView stopAnimating];
    _activityIndicatorView.hidesWhenStopped = YES;
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"预约失败" message:@"网络连接失败" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)pubImage
{

    
    NSURL * url=[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=news&a=addNews"];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:url];
    request.delegate=self;
    request.tag=101;
    [request setPostValue:appDele.uid forKey:@"uid"];
    [request setPostValue:appDele.secret forKey:@"secret"];
    [request setPostValue:_titlfield.text forKey:@"title"];
    [request setPostValue:self.style forKey:@"news_type"];
    if ([howMuchImage isEqualToString:@"1"]) {
        
         NSString * josn = [NSString stringWithFormat:@"[{\"pic\":\"%@\",\"content\":\"%@\"}]",imageString1,_firstTextView.text];
        
        NSLog(@"json:%@",josn);
        
        [request setPostValue:josn forKey:@"info"];
    }
    else if ([howMuchImage isEqualToString:@"2"]) {
        NSString * josn = [NSString stringWithFormat:@"[{\"pic\":\"%@\",\"content\":\"%@\"}],[{\"pic\":\"%@\",\"content\":\"%@\"}]",imageString1,_firstTextView.text,imageString2,_secondTextView.text];
        
        [request setPostValue:josn forKey:@"info"];
    }
        else if ([howMuchImage isEqualToString:@"3"]) {
            NSString * josn = [NSString stringWithFormat:@"[{\"pic\":\"%@\",\"content\":\"%@\"}],[{\"pic\":\"%@\",\"content\":\"%@\"}],[{\"pic\":\"%@\",\"content\":\"%@\"}]",imageString1,_firstTextView.text,imageString2,_secondTextView.text,imageString3,_thirdTextView.text];
            
            [request setPostValue:josn forKey:@"info"];
            
        }
            else if ([howMuchImage isEqualToString:@"4"]) {
                NSString * josn = [NSString stringWithFormat:@"[{\"pic\":\"%@\",\"content\":\"%@\"}],[{\"pic\":\"%@\",\"content\":\"%@\"}],[{\"pic\":\"%@\",\"content\":\"%@\"}],[{\"pic\":\"%@\",\"content\":\"%@\"}]",imageString1,_firstTextView.text,imageString2,_secondTextView.text,imageString3,_thirdTextView.text,imageString4,_forthTextView.text];
                
                [request setPostValue:josn forKey:@"info"];
            }
   
    
    [request startAsynchronous];
    

}

- (NSData *)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
     NSLog(@"jsonData:%@",jsonData);
    return jsonData;
   
}
@end

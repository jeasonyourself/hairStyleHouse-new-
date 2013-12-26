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
@interface pubImageViewController ()

@end

@implementation pubImageViewController
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
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
    Lab.text = @"发布发型";
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
    [self refreashNav];
    
    sexString= [[NSString alloc] init];
    sexString =@"1";
    sign1 = [[NSString alloc] init];
    sign2 = [[NSString alloc] init];
    hairStyle= [[NSString alloc] init];
    hairStyle=@"1";
    ifselectImage = NO;
    imageArr = [[NSMutableArray alloc] init];


    // Do any additional setup after loading the view from its nib.
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
    [leftButton setBackgroundColor:[UIColor colorWithRed:214.0/256.0 green:78.0/256.0 blue:78.0/256.0 alpha:1.0]];
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
            [imageArr removeObjectAtIndex:0];
            [imageArr addObject:_firstImage];
        }
        else if([sign1 isEqualToString:@"2"])
        {
            _secondImage.image = image;
            [imageArr removeObjectAtIndex:1];
            [imageArr addObject:_secondImage];
        }
        else if([sign1 isEqualToString:@"3"])
        {
            _thirdImage.image = image;
            [imageArr removeObjectAtIndex:2];
            [imageArr addObject:_thirdImage];
        }
        else if([sign1 isEqualToString:@"4"])
        {
            _forthImage.image = image;
            [imageArr removeObjectAtIndex:3];
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

- (IBAction)pubButtonClick:(id)sender
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
    }
    }
    
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
            
            
            AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
            ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Works&a=add_works"]];
            request.delegate=self;
            request.tag=2;
            [request setPostValue:appDele.uid forKey:@"uid"];
            [request setPostValue:appDele.userName forKey:@"username"];
            [request setPostValue:appDele.type forKey:@"type"];
            [request setPostValue:_deacribeText.text forKey:@"content"];
            [request setPostValue:headString forKey:@"work_image"];
            [request setPostValue:sexString forKey:@"sex"];
            [request setPostValue:hairStyle forKey:@"hair_type"];
            
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

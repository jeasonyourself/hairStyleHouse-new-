//
//  completeViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "completeViewController.h"
#import "AppDelegate.h"
#import "LoginView.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "HZAreaPickerView.h"
#import "HZLocation.h"
#import "UIImageView+WebCache.h"
#import <MobileCoreServices/MobileCoreServices.h>


@interface completeViewController ()<UITextFieldDelegate, HZAreaPickerDelegate>
@property (retain, nonatomic) IBOutlet UITextField *areaText;
@property (retain, nonatomic) IBOutlet UITextField *cityText;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;

@property (strong, nonatomic) NSString *areaValue, *cityValue;
@property (strong, nonatomic) HZAreaPickerView *locatePicker;

-(void)cancelLocatePicker;

@end

@implementation completeViewController
@synthesize areaText;
@synthesize cityText;
@synthesize areaValue=_areaValue, cityValue=_cityValue;
@synthesize locatePicker=_locatePicker;
@synthesize  fatherView;
-(void)setAreaValue:(NSString *)areaValue
{
    if (![_areaValue isEqualToString:areaValue]) {
        
        self.areaText.text = areaValue;
    }
}

-(void)setCityValue:(NSString *)cityValue
{
    if (![_cityValue isEqualToString:cityValue]) {
        
        self.cityText.text = cityValue;
    }
}

- (void)viewDidUnload
{
    [self setAreaText:nil];
    [self setCityText:nil];
    [self cancelLocatePicker];
    // Release any retained subviews of the main view.
}

#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict)
    {
        if ([picker.locate.state isEqualToString:@"北京"]||[picker.locate.state isEqualToString:@"天津"]||[picker.locate.state isEqualToString:@"上海"]||[picker.locate.state isEqualToString:@"重庆"]) {
            self.areaValue = [NSString stringWithFormat:@"%@市", picker.locate.state];
            
        }
        else if ([picker.locate.state isEqualToString:@"香港"]||[picker.locate.state isEqualToString:@"澳门"])
        {
            self.areaValue = [NSString stringWithFormat:@"%@特别行政区", picker.locate.state];
        }
        else
        {
            self.areaValue = [NSString stringWithFormat:@"%@市", picker.locate.city];
        }
    }
    else
    {
        self.cityValue = [NSString stringWithFormat:@"%@ %@", picker.locate.state, picker.locate.city];
    }
}

-(void)cancelLocatePicker
{
    [self.locatePicker cancelPicker];
    self.locatePicker.delegate = nil;
    self.locatePicker = nil;
    [self textFiledReturnEditing:_nameField];
    [self textFiledReturnEditing:_storeNameField];
    [self textFiledReturnEditing:_mobileField];
    [self textFiledReturnEditing:_addressField];
    [self textFiledReturnEditing:areaText];
    [self textFiledReturnEditing:_selfmobileField];
    [self textFiledReturnEditing:_qqField];

}



#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.areaText]) {
        [self cancelLocatePicker];
        self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self] ;
        [self.locatePicker showInView:fatherView.view];
    } else {
        [self cancelLocatePicker];
        self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCity delegate:self] ;
        [self.locatePicker showInView:fatherView.view];
        
    }
    return NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self cancelLocatePicker];
}

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
    ifchangeHeadImage = NO;
    type = [[NSString alloc] init];
    headString= [[NSString alloc] init];
    whictButton= [[NSString alloc] init];
    whictButton=@"first";
    _storeNameLable.hidden =YES;
    _storeNameField.hidden =YES;
    _mobileLable.hidden =YES;
    _mobileField.hidden =YES;
    _addressLable.hidden =YES;
    _addressField.hidden =YES;
    _cityLable.hidden =YES;
    areaText.hidden =YES;
    _selfmobileLable.hidden =YES;
    _selfmobileField.hidden =YES;
    _qqLable.hidden =YES;
    _qqField.hidden =YES;
    _saveButton.hidden=NO;
    _saveButton2.hidden =YES;
    
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    NSLog(@"city:%@",appDele.city);
    areaText.text =appDele.city;
    
    [_saveButton.layer setMasksToBounds:YES];
    [_saveButton.layer setCornerRadius:5.0];
    [_saveButton.layer setBorderWidth:0];
    [_saveButton2.layer setMasksToBounds:YES];
    [_saveButton2.layer setCornerRadius:5.0];
    [_saveButton2.layer setBorderWidth:0];
   	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firstButtonClick:(id)sender
{
    _storeNameLable.hidden =YES;
    _storeNameField.hidden =YES;
    _mobileLable.hidden =YES;
    _mobileField.hidden =YES;
    _addressLable.hidden =YES;
    _addressField.hidden =YES;
    _cityLable.hidden =YES;
    areaText.hidden =YES;
    _selfmobileLable.hidden =YES;
    _selfmobileField.hidden =YES;
    _qqLable.hidden =YES;
    _qqField.hidden =YES;
    _saveButton.hidden=NO;
    _saveButton2.hidden =YES;
    
    whictButton=@"first";

    [_firstButton setBackgroundImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateNormal];
    [_secondButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
    type = @"1";
    
}

- (IBAction)secondButtonClick:(id)sender
{
    _storeNameLable.hidden =NO;
    _storeNameField.hidden =NO;
    _mobileLable.hidden =NO;
    _mobileField.hidden =NO;
    _addressLable.hidden =NO;
    _addressField.hidden =NO;
    _cityLable.hidden =NO;
    areaText.hidden =NO;
    _selfmobileLable.hidden =NO;
    _selfmobileField.hidden =NO;
    _qqLable.hidden =NO;
    _qqField.hidden =NO;
    _saveButton.hidden=YES;
    _saveButton2.hidden =NO;
    
    whictButton=@"second";
    [_firstButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
    [_secondButton setBackgroundImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateNormal];
    type = @"2";
}





- (IBAction)saveButtonClick:(id)sender
{
    if(ifchangeHeadImage==NO||[_nameField.text isEqualToString:@""]||[_storeNameField.text isEqualToString:@""]||[_mobileField.text isEqualToString:@""]||[_addressField.text isEqualToString:@""]||[areaText.text isEqualToString:@""]||[_selfmobileField.text isEqualToString:@""]||[_qqField.text isEqualToString:@""])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写完整的个人信息" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
       
    }
    else
    {
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Up&a=add_img"]];
        
        NSData *imageData = UIImageJPEGRepresentation(_headImage.image, 1.0);
        NSUInteger dataLength = [imageData length];
        
        if(dataLength > MAX_IMAGEDATA_LEN) {
            imageData = UIImageJPEGRepresentation(_headImage.image, 1.0 - MAX_IMAGEDATA_LEN / dataLength);
        } else {
            imageData = UIImageJPEGRepresentation(_headImage.image, 1.0);
        }
        
        [request appendPostData:imageData];
        request.delegate=self;
        request.tag=5;
    }
    
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (request.tag==4)
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"是否完善资料成功dic:%@",dic);
        
        self.navigationController.navigationBar.hidden = YES;
//        [self.navigationController popViewControllerAnimated:NO]
        
    }
    else if (request.tag==5)
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"图片地址dic:%@",dic);
        headString=[dic objectForKey:@"image"];
        
        
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=User&a=data_modify"]];
        request.delegate=self;
        request.tag=4;
        
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request setPostValue:headString forKey:@"head_photo"];
        [request setPostValue:_nameField.text forKey:@"username"];
        
        if ([whictButton isEqualToString:@"second"])
        {
            //        [request setPostValue:sexString forKey:@"sex"];
            //        [request setPostValue:areaText.text forKey:@"city"];
            //        [request setPostValue:_personSignText.text forKey:@"signature"];
        }

        
        [request startAsynchronous];
    }

}
- (IBAction)headButtonClick:(id)sender {
    
    [self.locatePicker cancelPicker];

    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择方式"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"现在去拍照"
                                  otherButtonTitles:@"从相册选择",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
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
        [fatherView presentViewController:picker animated:YES completion:nil];
        
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
        [fatherView presentViewController:picker animated:YES completion:nil];
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
        _headImage.image = image;
        ifchangeHeadImage =YES;
        [picker dismissViewControllerAnimated:NO completion:nil];
        
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

-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
    
}

- (IBAction)touchDown:(id)sender
{
    [self textFiledReturnEditing:_nameField ];
    [self textFiledReturnEditing:_storeNameField ];
    [self textFiledReturnEditing:_addressField ];
    [self textFiledReturnEditing:_mobileField ];
    [self textFiledReturnEditing:areaText ];
    [self.locatePicker cancelPicker];

    [self textFiledReturnEditing:_selfmobileField ];
    [self textFiledReturnEditing:_qqField ];

}

@end

//
//  pubQViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-10.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "pubQViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface pubQViewController ()

@end

@implementation pubQViewController

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
    Lab.text = @"发布话题";
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
    [self refreashNav];
    self.view.backgroundColor = [UIColor whiteColor];
    ifChangeImage=NO;
    
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    myTableView.allowsSelection=NO;
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.view addSubview:myTableView];
}
-(void)leftButtonClick
{
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
-(void)viewDidAppear:(BOOL)animated
{
    
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
    
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    myTableView.frame = newTextViewFrame;
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
    
    myTableView.frame = self.view.bounds;
    
    [UIView commitAnimations];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   self.view.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [self updateBackView];
    //    backView.view.backgroundColor =[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [cell.contentView addSubview:backView];
    return cell;
}

- (void)updateBackView
{
    backView=nil;
    backView = [[UIView alloc] initWithFrame:myTableView.frame];
    backView.backgroundColor =[UIColor lightGrayColor];
     headImage = [[UIImageView alloc] initWithFrame:CGRectMake(60, 20, 200, 200)];
    headImage.image = [UIImage imageNamed:@"添加图片.png"];
    
    headButton = [UIButton buttonWithType:UIButtonTypeCustom];
    headButton.frame = headImage.frame;
    headButton.backgroundColor = [UIColor clearColor];
    [headButton addTarget:self action:@selector(headButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    describeText = [[UITextView alloc] initWithFrame:CGRectMake(20, 240, 280, 120)];
    describeText.backgroundColor = [UIColor whiteColor];
    
    describeText.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    describeText.font = [UIFont systemFontOfSize:12.0];//设置字体名字和字体大小
    describeText.delegate = self;
    
    
    sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(10, 400, 300, 30);
    [sendButton setBackgroundColor:[UIColor colorWithRed:214.0/256.0 green:78.0/256.0 blue:78.0/256.0 alpha:1.0]];
    [sendButton setTitle:@"发布" forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:headImage];
    [backView addSubview:headButton];
    [backView addSubview:describeText];
    [backView addSubview:sendButton];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

    - (void)didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }


- (void)headButtonClick
    {
        
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
            headImage.image = image;
            ifChangeImage = YES;
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

- (void)sendButtonClick
{
    if (ifChangeImage==NO)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择一张配图" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    else  if ([describeText.text isEqualToString:@""])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请添加你的问题" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Up&a=add_img"]];
        
        NSData *imageData = UIImageJPEGRepresentation(headImage.image, 1.0);
        NSUInteger dataLength = [imageData length];
        
        if(dataLength > MAX_IMAGEDATA_LEN) {
            imageData = UIImageJPEGRepresentation(headImage.image, 1.0 - MAX_IMAGEDATA_LEN / dataLength);
        } else {
            imageData = UIImageJPEGRepresentation(headImage.image, 1.0);
        }
        
        [request appendPostData:imageData];
        request.delegate=self;
        request.tag=1;
    }
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    if (request.tag==1) {
        
        if (request.tag==1)
        {
            NSLog(@"%@",request.responseString);
            NSData*jsondata = [request responseData];
            NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            SBJsonParser* jsonP=[[SBJsonParser alloc] init];
            NSDictionary* dic=[jsonP objectWithString:jsonString];
            NSLog(@"图片地址dic:%@",dic);
             NSString * headString=[dic objectForKey:@"image"];
            
            
            AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
            ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Problem&a=quizadd"]];
            request.delegate=self;
            request.tag=2;
            [request setPostValue:appDele.uid forKey:@"uid"];
            [request setPostValue:appDele.city forKey:@"city"];
            [request setPostValue:headString forKey:@"image"];
            [request setPostValue:describeText.text forKey:@"content"];
            
            
            [request startAsynchronous];
        }

        else if (request.tag==2)
        {
            NSLog(@"%@",request.responseString);
            NSData*jsondata = [request responseData];
            NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            SBJsonParser* jsonP=[[SBJsonParser alloc] init];
            NSDictionary* dic=[jsonP objectWithString:jsonString];
            NSLog(@"是否发布成功dic:%@",dic);
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
}
	// Do any additional setup after loading the view.




@end

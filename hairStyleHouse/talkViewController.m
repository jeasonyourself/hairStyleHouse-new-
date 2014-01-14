//
//  talkViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "talkViewController.h"
#import "Message.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface talkViewController ()

@end
static NSString * const RCellIdentifier = @"HRChatCell";

@implementation talkViewController
@synthesize uid;
@synthesize talkOrQuestion;
@synthesize questionId;
@synthesize sameCityQuestion;
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
    [self refreashNavLab];
    [self refreashNav];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-60) style:UITableViewStylePlain];
    dresserArray =[[NSMutableArray alloc] init];
    oldArray =[[NSMutableArray alloc] init];
    headImageDiction = [[NSDictionary alloc] init];
    sendImage = [[UIImageView alloc] init];
    imageString = [[NSString alloc] init];
   
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths objectAtIndex:0];
    NSLog(@"path = %@",path);
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    NSString * plistString;
    if ([talkOrQuestion isEqualToString:@"question"])
    {
        plistString = [NSString stringWithFormat:@"%@and%@question",appDele.uid,self.uid];
    }
    else
    {
        plistString = [NSString stringWithFormat:@"%@and%@talk",appDele.uid,self.uid];
    }
    NSString *filename=[path stringByAppendingPathComponent:plistString];
    
    //读文件

    myTableView.allowsSelection=NO;
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor whiteColor];
//    UINib *chatNib = [UINib nibWithNibName:@"HRChatCell" bundle:[NSBundle bundleForClass:[HRChatCell class]]];
//    [myTableView registerNib:chatNib forCellReuseIdentifier:RCellIdentifier];
    
    [self.view addSubview:myTableView];
    
    lastView = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height-60, self.view.bounds.size.width, 60)];
    lastView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    lastView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    lastView.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    lastView.layer.masksToBounds = YES;//设为NO去试试
    lastView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lastView];
    
    contentView = [[UITextView alloc] initWithFrame:CGRectMake(60,10, 185, 40)];
    contentView.font =[UIFont systemFontOfSize:12.0];
    contentView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    contentView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    contentView.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    contentView.layer.masksToBounds = YES;//设为NO去试试
    contentView.delegate =self;
    [lastView addSubview:contentView];
    
    //    sendButton=[[UIButton alloc] initWithFrame:CGRectMake(200,10, 60, 40)];
    ifchangeHeadImage=NO;
    imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    imageButton.frame=CGRectMake(10,10, 40, 40);
    [imageButton.layer setMasksToBounds:YES];
    [imageButton.layer setCornerRadius:3.0];
    [imageButton.layer setBorderWidth:1.0];
    [imageButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [imageButton setTitle:@"+" forState:UIControlStateNormal];
    imageButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [imageButton setBackgroundColor:[UIColor colorWithRed:214.0/256.0 green:78.0/256.0 blue:78.0/256.0 alpha:1.0]];
    [imageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [imageButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [imageButton addTarget:self action:@selector(imageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame=CGRectMake(250,10, 60, 40);
    [sendButton.layer setMasksToBounds:YES];
    [sendButton.layer setCornerRadius:3.0];
    [sendButton.layer setBorderWidth:1.0];
    [sendButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [sendButton setBackgroundColor:[UIColor colorWithRed:214.0/256.0 green:78.0/256.0 blue:78.0/256.0 alpha:1.0]];
    [sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [sendButton addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [lastView addSubview:imageButton];
    [lastView addSubview:sendButton];
    
    
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:filename];
    if (!dataArray)
    {
        //1. 创建一个plist文件
        NSFileManager* fm = [NSFileManager defaultManager];
        [fm createFileAtPath:filename contents:nil attributes:nil];
    }
    else
    {
        oldArray=[NSMutableArray arrayWithArray:dataArray];
        [dresserArray addObjectsFromArray:dataArray];
    }
    
    
//    [self getData];
}
-(void)viewDidAppear:(BOOL)animated
{
    
    [contentView resignFirstResponder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    timer =  [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(getData) userInfo:nil repeats:YES];
    [timer setFireDate:[NSDate distantPast]];
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
    
    myTableView.frame = CGRectMake(newTextViewFrame.origin.x, newTextViewFrame.origin.y, newTextViewFrame.size.width, newTextViewFrame.size.height-60);
    lastView.frame =  CGRectMake(myTableView.frame.origin.x, myTableView.frame.origin.y+myTableView.frame.size.height, myTableView.frame.size.width, 60);
    [UIView commitAnimations];
}
- (void)keyboardWillHide:(NSNotification *)notification
{
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
    
    myTableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-60);
    lastView.frame = CGRectMake(0,self.view.bounds.size.height-60, self.view.bounds.size.width, 60);
    
    [UIView commitAnimations];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [timer setFireDate:[NSDate distantFuture]];
}

-(void)imageButtonClick
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
        [imageButton setImage:image forState:UIControlStateNormal];
        ifchangeHeadImage =YES;
        sendImage.image = image;
        [picker dismissViewControllerAnimated:NO completion:nil];
//        [picker.navigationController popViewControllerAnimated:NO];
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

-(void)sendButtonClick
{

    [contentView resignFirstResponder];
    if ([contentView.text isEqualToString:@""]&&ifchangeHeadImage==NO) {
        UIAlertView  * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发动内容不能为空" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        [timer setFireDate:[NSDate distantFuture]];

      if (ifchangeHeadImage==NO)
      {
          NSURL * urlString;
          if ([talkOrQuestion isEqualToString:@"question"])
          {
              urlString= [NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Problem&a=answeradd"];
              
          }
          else
          {
              urlString= [NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Message&a=publish"];
              
          }
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:urlString];
        request.delegate=self;
        request.tag=4;
          if ([talkOrQuestion isEqualToString:@"question"])
          {
              [request setPostValue:appDele.uid forKey:@"from_id"];
              [request setPostValue:self.uid forKey:@"to_id"];
              [request setPostValue:questionId forKey:@"pid"];
              [request setPostValue:contentView.text forKey:@"content"];
              [request setPostValue:imageString forKey:@"pic"];
          }
          else
          {
              [request setPostValue:appDele.uid forKey:@"uid"];
              [request setPostValue:self.uid forKey:@"to_id"];
              [request setPostValue:contentView.text forKey:@"content"];
              [request setPostValue:imageString forKey:@"pic"];

          }
          
        
        [request startAsynchronous];
      }
       else//有图片
      {
        ASIFormDataRequest* request;
        request =[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Up&a=add_img"]];
 

        NSData *imageData = UIImageJPEGRepresentation(sendImage.image, 1.0);
        NSUInteger dataLength = [imageData length];
        
        if(dataLength > MAX_IMAGEDATA_LEN) {
            imageData = UIImageJPEGRepresentation(sendImage.image, 1.0 - MAX_IMAGEDATA_LEN / dataLength);
        } else {
            imageData = UIImageJPEGRepresentation(sendImage.image, 1.0);
        }
        
        [request appendPostData:imageData];
        request.delegate=self;
        request.tag=5;
          [request startAsynchronous];

    }
    }
    
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

-(void)refreashNavLab
{
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
    Lab.text = @"聊天";
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}
-(void)getData
{
    NSURL * urlString;
    if ([talkOrQuestion isEqualToString:@"question"])
    {
        urlString= [NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Problem&a=topicview"];
        
    }
    else
    {
        urlString= [NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Message&a=talk"];

    }
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:urlString];
    request.delegate=self;
    request.tag=1;
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    [request setPostValue:appDele.uid forKey:@"uid"];
    NSInteger appid = [appDele.uid integerValue];
    NSInteger selfid = [self.uid integerValue];
    NSInteger ftid = appid+selfid;
    NSString * ftString = [NSString stringWithFormat:@"%d",ftid];
    

    if ([talkOrQuestion isEqualToString:@"question"])
    {
        [request setPostValue:questionId forKey:@"pid"];
        [request setPostValue:self.uid forKey:@"to_id"];
    }
    else
    {
        [request setPostValue:ftString forKey:@"ftid"];
    }
     NSLog(@"uid:%@",self.uid);
    NSLog(@"app.uid:%@",appDele.uid);
    NSLog(@"ftid:%d",ftid);

    NSLog(@"urlString:%@",urlString);
//    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    NSString *path=[paths objectAtIndex:0];
//    NSLog(@"path = %@",path);
//    NSString * plistString = [NSString stringWithFormat:@"%@and%@",appDele.uid,self.uid];
//    NSString *filename=[path stringByAppendingPathComponent:plistString];
    //读文件

    
//    NSArray *dataArray = [NSArray arrayWithContentsOfFile:filename];
    if (oldArray.count==0)
    {
        //1. 创建一个plist文件
//        NSFileManager* fm = [NSFileManager defaultManager];
//        [fm createFileAtPath:filename contents:nil attributes:nil];
        if([sameCityQuestion isEqualToString:@"samecity"])
        {
        [request setPostValue:@"-1" forKey:@"max_id"];
        }
        else
        {
        [request setPostValue:@"0" forKey:@"max_id"];
        }

    }
    else
    {
        [request setPostValue:[[oldArray objectAtIndex:oldArray.count-2] objectForKey:@"id"] forKey:@"max_id"];
    }
    [request startAsynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
//    if (dresserArray!=nil) {
//        [dresserArray removeAllObjects];
//    }
     NSMutableArray * arr;
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    if (request.tag==1) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"聊天列表dic:%@",dic);
        
        
        if ([talkOrQuestion isEqualToString:@"question"])
        {
            if ([[dic objectForKey:@"answer_list"] isKindOfClass:[NSString class]])
            {
                [myTableView reloadData];
            }
            else if ([[dic objectForKey:@"answer_list"] isKindOfClass:[NSArray class]])
            {
                arr= [dic objectForKey:@"answer_list"];
                [oldArray removeObject:[oldArray lastObject]];
                [oldArray addObjectsFromArray:arr];
                NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                NSString *path=[paths objectAtIndex:0];
                NSLog(@"path = %@",path);
                NSString * plistString;
                
                plistString = [NSString stringWithFormat:@"%@and%@question",appDele.uid,self.uid];
                
                
                NSString *filename=[path stringByAppendingPathComponent:plistString];
                
                
                headImageDiction = [NSDictionary dictionaryWithObjectsAndKeys:[dic objectForKey:@"my_head_photo"],@"my_head_photo", [dic objectForKey:@"ta_head_photo"],@"ta_head_photo",[dic objectForKey:@"ta_id"],@"ta_id",[dic objectForKey:@"ta_name"],@"ta_name",[dic objectForKey:@"ta_type"],@"ta_type",nil];
                [oldArray addObject:headImageDiction];
                [oldArray writeToFile:filename atomically:YES];
                
                
                [self freashView];
                
            }
            
        }
        else
        {
            
            if ([[dic objectForKey:@"message_list"] isKindOfClass:[NSString class]])
            {
                [myTableView reloadData];
            }
            else if ([[dic objectForKey:@"message_list"] isKindOfClass:[NSArray class]])
            {
                arr= [dic objectForKey:@"message_list"];
                [oldArray removeObject:[oldArray lastObject]];
                [oldArray addObjectsFromArray:arr];
                NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                NSString *path=[paths objectAtIndex:0];
                NSLog(@"path = %@",path);
                NSString * plistString;
                
                plistString = [NSString stringWithFormat:@"%@and%@talk",appDele.uid,self.uid];
                
                
                NSString *filename=[path stringByAppendingPathComponent:plistString];
                
                
                headImageDiction = [NSDictionary dictionaryWithObjectsAndKeys:[dic objectForKey:@"my_head_photo"],@"my_head_photo", [dic objectForKey:@"ta_head_photo"],@"ta_head_photo",[dic objectForKey:@"ta_id"],@"ta_id",[dic objectForKey:@"ta_name"],@"ta_name",[dic objectForKey:@"ta_type"],@"ta_type",nil];
                [oldArray addObject:headImageDiction];
                [oldArray writeToFile:filename atomically:YES];
                
                
                [self freashView];
                
            }
        }
       
    }
    
    else if (request.tag==4)
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"是否发送成功dic:%@",dic);
        
        
        ifchangeHeadImage=NO;
        [imageButton setTitle:@"+" forState:UIControlStateNormal];
        [imageButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        sendImage.image=[UIImage imageNamed:@""];
        contentView.text=@"";
        imageString = @"";
//        [self getData];
        [timer setFireDate:[NSDate distantPast]];

        
    }
    else if (request.tag==5)
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"图片地址dic:%@",dic);
        
        imageString=[dic objectForKey:@"image"];
        
        
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Message&a=publish"]];
        request.delegate=self;
        request.tag=4;
        if ([talkOrQuestion isEqualToString:@"question"])
        {
            [request setPostValue:appDele.uid forKey:@"from_id"];
            [request setPostValue:self.uid forKey:@"to_id"];
            [request setPostValue:questionId forKey:@"pid"];
            [request setPostValue:contentView.text forKey:@"content"];
            [request setPostValue:imageString forKey:@"pic"];
        }
        else
        {
            [request setPostValue:appDele.uid forKey:@"uid"];
            [request setPostValue:self.uid forKey:@"to_id"];
            [request setPostValue:contentView.text forKey:@"content"];
            [request setPostValue:imageString forKey:@"pic"];
            
        }
        
        
        [request startAsynchronous];
    }

    
}

-(void)freashView
{
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths objectAtIndex:0];
    NSLog(@"path = %@",path);
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    NSString * plistString;
    if ([talkOrQuestion isEqualToString:@"question"])
    {
        plistString = [NSString stringWithFormat:@"%@and%@question",appDele.uid,self.uid];
        
    }
    else
    {
        plistString = [NSString stringWithFormat:@"%@and%@talk",appDele.uid,self.uid];
    }
    NSString *filename=[path stringByAppendingPathComponent:plistString];
    //读文件
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:filename];
    NSLog(@"dataArray:%@",dataArray);
    
    if (!dataArray)
    {
        //1. 创建一个plist文件
        NSFileManager* fm = [NSFileManager defaultManager];
        [fm createFileAtPath:filename contents:nil attributes:nil];
    }
    else
    {
        dresserArray = [NSMutableArray arrayWithCapacity:dataArray.count];
        [dresserArray addObjectsFromArray:dataArray];
    }
    NSLog(@"dresser.count:%d",dresserArray.count);
    
    [myTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dresserArray.count-1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 测试字串
    NSString *_content =[[dresserArray objectAtIndex:[indexPath row]] objectForKey:@"content"];
    NSString *picStr =[[dresserArray objectAtIndex:[indexPath row]] objectForKey:@"pic"];
    UIFont *font = [UIFont systemFontOfSize:12.0];
    //设置一个行高上限
    CGSize size = CGSizeMake(150,2000);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [_content sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    
    if ([picStr isEqualToString:@""])
    {
            return   80+labelsize.height;
    }
    else
    {
        return 90+labelsize.height+200;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    talkCell *cell=(talkCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[talkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
//    HRChatCell *cell = [tableView dequeueReusableCellWithIdentifier:RCellIdentifier];
    NSInteger row =[indexPath row];

    [cell bindMessage:dresserArray[row] and:[dresserArray lastObject]];
    
    
    return cell;
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

@end

//
//  personInforViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "personInforViewController.h"
#import "AppDelegate.h"
#import "LoginView.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "HZAreaPickerView.h"
#import "HZLocation.h"
#import "UIImageView+WebCache.h"
#import <MobileCoreServices/MobileCoreServices.h>

#import "MobClick.h"
@interface personInforViewController ()<UITextFieldDelegate, HZAreaPickerDelegate>
@property (retain, nonatomic) IBOutlet UITextField *areaText;
@property (strong, nonatomic) NSString *areaValue, *cityValue;
@property (strong, nonatomic) HZAreaPickerView *locatePicker;

@end

@implementation personInforViewController
@synthesize _hidden;
@synthesize areaText;
@synthesize areaValue=_areaValue, cityValue=_cityValue;
@synthesize locatePicker=_locatePicker;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)setAreaValue:(NSString *)areaValue
{
    
    self.areaText.text = areaValue;
}

- (void)viewDidUnload
{
    [self setAreaText:nil];
    [self cancelLocatePicker];
    [super viewDidUnload];
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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 100, 30)];
    Lab.text = @"修改资料";
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
    [self refreashNav];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    inforDic = [[NSDictionary alloc] init];
//    headImage = [[UIImageView alloc] init];
    verifyString = [[NSString alloc] init];
    mobileString= [[NSString alloc] init];
    sexString = [[NSString alloc] init];
    headString = [[NSString alloc] init];
    ifchangeHeadImage =NO;
    
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    myTableView.allowsSelection=NO;
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.view addSubview:myTableView];
        [self getData];
    
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
	// Do any additional setup after loading the view.
}

-(void)leftButtonClick
{
    if ([_hidden  isEqualToString:@"yes"]) {
        self.navigationController.navigationBar.hidden = YES;

    }
    else
    {
        self.navigationController.navigationBar.hidden = NO;

    }
    [self.navigationController popViewControllerAnimated:NO];
    
}
-(IBAction)rightButtonClick:(id)sender
{
    if([_nameField.text isEqualToString:@""]||[_QQfield.text isEqualToString:@""]||[areaText.text isEqualToString:@""]||[_personSignText.text isEqualToString:@""])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写完整信息以便修改" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:_mobileField.text];
    
    if (!isMatch)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else
    {
    
    if (ifchangeHeadImage==NO)
    {
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
//        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=User&a=data_modify"]];
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=user&a=data_modify"]];
        request.delegate=self;
        request.tag=4;
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request setPostValue:appDele.secret forKey:@"secret"];

        [request setPostValue:_nameField.text forKey:@"username"];
        [request setPostValue:sexString forKey:@"sex"];
        [request setPostValue:areaText.text forKey:@"city"];
        [request setPostValue:_QQfield.text forKey:@"qq"];
        [request setPostValue:_personSignText.text forKey:@"signature"];
        [request setPostValue:_mobileField.text forKey:@"mobile"];
        [request startAsynchronous];
    }
    else
    {
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=up&a=add_img"]];
        
        NSData *imageData = UIImageJPEGRepresentation(_headImage.image, 1.0);
        
        NSUInteger dataLength = [imageData length];
        if(dataLength > MAX_IMAGEDATA_LEN)
        {
            imageData = UIImageJPEGRepresentation(_headImage.image, 1.0 - MAX_IMAGEDATA_LEN / dataLength);
        }
        
        NSUInteger dataLength1 = [imageData length];
        if(dataLength1 > MAX_IMAGEDATA_LEN)
        {
            imageData = UIImageJPEGRepresentation(_headImage.image, 0.1);
        }
        
        NSUInteger dataLength2 = [imageData length];
        if(dataLength2 > MAX_IMAGEDATA_LEN)
        {
            imageData = UIImageJPEGRepresentation(_headImage.image, 0.01);
        }
        
        
        [request appendPostData:imageData];
        request.delegate=self;
        request.tag=5;
        [request startAsynchronous];

    }
        
        
        
        [_activityIndicatorView startAnimating];
    }
}
-(void)refreashNav
{
    UIButton * leftButton=[[UIButton alloc] init];
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton.layer setMasksToBounds:YES];
    [leftButton.layer setCornerRadius:3.0];
    [leftButton.layer setBorderWidth:1.0];
    [leftButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [leftButton setImage:[UIImage imageNamed:@"返回.png"]  forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    
    
    [leftButton setBackgroundColor:[UIColor clearColor]];
    [leftButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(0,28, 24, 26);
    UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
    
//    UIButton * rightButton=[[UIButton alloc] init];
//    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightButton.layer setMasksToBounds:YES];
//    [rightButton.layer setCornerRadius:3.0];
//    [rightButton.layer setBorderWidth:1.0];
//    [rightButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
//    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
//    rightButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
//    [rightButton setBackgroundColor:[UIColor colorWithRed:214.0/256.0 green:78.0/256.0 blue:78.0/256.0 alpha:1.0]];
//    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [rightButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    rightButton.frame = CGRectMake(12,20, 60, 25);
//    UIBarButtonItem *rightButtonItem=[[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    self.navigationItem.rightBarButtonItem=rightButtonItem;
}

-(void)viewDidAppear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"修改资料"];
    [MobClick beginLogPageView:cName];
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
    NSString* cName = [NSString stringWithFormat:@"修改资料"];
    [MobClick endLogPageView:cName];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)getData
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        
    ASIHTTPRequest* request=[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=User&a=data_info&uid=%@",appDele.uid]]];
    request.delegate=self;
    request.tag=1;
    [request startAsynchronous];
}
    
-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    if (request.tag==1) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"个人信息dic:%@",dic);
        inforDic = [dic objectForKey:@"user_info"];
        [self freashView];
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
    NSLog(@"获取验证码dic:%@",dic);
    verifyString = [dic objectForKey:@"verify"];//设置多少分钟后过期

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
        NSLog(@"是否绑定成功dic:%@",dic);
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"修改成功" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
        
        
        _checkField.text=@"";
        _mobileLable.hidden= YES;
        _checkSignLable.hidden =YES;
        _checkField.hidden = YES;
        _getCheckButton.hidden =YES;
//        _sureButton.hidden = YES;
        _cancelButton.hidden = YES;
        
        
       
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
        NSLog(@"是否修改资料成功dic:%@",dic);
        
        
        
        [_activityIndicatorView stopAnimating];
        _activityIndicatorView.hidesWhenStopped = YES;
        if ([dic objectForKey:@"101"]) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"修改成功" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
            [self leftButtonClick];
        }
        else
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"修改出错" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
        }
        
//            AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
//            ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=User&a=success"]];
//            request.delegate=self;
//            request.tag=3;
//            [request setPostValue:appDele.uid forKey:@"uid"];
//            [request setPostValue:mobileString forKey:@"mobile"];
//            
//            [request startAsynchronous];
        

        
    }
else if (request.tag==5)
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
    headString=[dic objectForKey:@"image"];

    
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
//    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=User&a=data_modify"]];
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=user&a=data_modify"]];
    request.delegate=self;
    request.tag=4;
    [request setPostValue:appDele.uid forKey:@"uid"];
    [request setPostValue:appDele.secret forKey:@"secret"];

    [request setPostValue:headString forKey:@"head_photo"];
    [request setPostValue:_nameField.text forKey:@"username"];
    [request setPostValue:sexString forKey:@"sex"];
    [request setPostValue:_QQfield.text forKey:@"qq"];
    [request setPostValue:areaText.text forKey:@"city"];
    [request setPostValue:_personSignText.text forKey:@"signature"];
    [request setPostValue:_mobileField.text forKey:@"mobile"];

    [request startAsynchronous];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"上传图片出错" delegate:Nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}

}
-(void)freashView
{
    [myTableView reloadData];
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
    backView = [[[NSBundle mainBundle] loadNibNamed:@"changeInforViewController" owner:self options:nil] objectAtIndex:0];
    NSString* headStr=[inforDic objectForKey:@"head_photo"];
    NSString* nameStr = [inforDic objectForKey:@"username"];
    NSString * sexStr = [inforDic objectForKey:@"sex"];
    NSString* cityStr =[inforDic objectForKey:@"city"];
    NSString * qqStr = [inforDic objectForKey:@"qq"];
    NSString * signStr = [inforDic objectForKey:@"signature"];
    NSString * mobileStr = [inforDic objectForKey:@"mobile"];
    
    [_headImage setImageWithURL:[NSURL URLWithString:headStr]];
    _nameField.text = nameStr;
    if ([sexStr isEqualToString:@"1"])
    {
        [_maleButton setImage:[UIImage imageNamed:@"选中png"] forState:UIControlStateNormal];
        [_femaleButton setImage:[UIImage imageNamed:@"未选中png"] forState:UIControlStateNormal];
    }
    else
    {
        [_maleButton setImage:[UIImage imageNamed:@"未选中png"] forState:UIControlStateNormal];
        [_femaleButton setImage:[UIImage imageNamed:@"选中png"] forState:UIControlStateNormal];
    }
    _sureButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _sureButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _sureButton.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _sureButton.layer.masksToBounds = YES;//设为NO去试试
    
    _QQfield.text = qqStr;
    areaText.text=cityStr;
    _personSignText.text = signStr;
    _mobileField.text =mobileStr;
    
    _checkButton.hidden=YES;
    _mobileLable.hidden= YES;
    _checkSignLable.hidden =YES;
    _checkField.hidden = YES;
    _getCheckButton.hidden =YES;
//    _sureButton.hidden = YES;
    _cancelButton.hidden = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.areaText]) {
        [self cancelLocatePicker];
        self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self] ;
        [self.locatePicker showInView:self.view];
        [self textFiledReturnEditing:_nameField];
        [self textFiledReturnEditing:_QQfield];
        [_personSignText resignFirstResponder];
        [self textFiledReturnEditing:_mobileField];
        [self textFiledReturnEditing:_checkField];
    }

    return NO;
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
    
}

- (IBAction)touchDown:(id)sender
{
    [self cancelLocatePicker];
    [self textFiledReturnEditing:_nameField];
    [self textFiledReturnEditing:_QQfield];
    [_personSignText resignFirstResponder];
    [self textFiledReturnEditing:_mobileField];
    [self textFiledReturnEditing:_checkField];
    
}

- (IBAction)headButtonClick:(id)sender
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


- (IBAction)maleButtonClick:(id)sender
{
    [_maleButton setBackgroundImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateNormal];
    [_femaleButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
    sexString = @"1";
}

- (IBAction)femaleButtonClick:(id)sender
{
    [_maleButton setBackgroundImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
    [_femaleButton setBackgroundImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateNormal];
    sexString = @"0";
}
- (IBAction)checkButtonClick:(id)sender
{
    _mobileField.hidden= NO;
    _checkSignLable.hidden =NO;
    _checkField.hidden = NO;
    _getCheckButton.hidden =NO;
//    _sureButton.hidden = NO;
    _cancelButton.hidden = NO;
}

- (IBAction)getCheckButtonClick:(id)sender
{
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:_mobileField.text];
    
    if (!isMatch)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        mobileString = _mobileField.text;
        timer =  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(function) userInfo:nil repeats:YES];
        timeString =@"60";
        _getCheckButton.userInteractionEnabled =NO;
        
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=User&a=verify_code"]];
        request.delegate=self;
        request.tag=2;
        [request setPostValue:mobileString forKey:@"mobile"];
        [request startAsynchronous];
    }
}
-(void)function
{
    NSInteger  time = [timeString integerValue];
    [_getCheckButton setTitle:[NSString stringWithFormat:@"%ds后可再次获取验证码",time] forState:UIControlStateNormal];
    time--;
    timeString = [NSString stringWithFormat:@"%d",time];
    if (time==0) {
        [_getCheckButton setTitle:[NSString stringWithFormat:@"点击这里获取验证码"] forState:UIControlStateNormal];
        [timer invalidate];
        _getCheckButton.userInteractionEnabled =YES;

    }
    
}
- (IBAction)sureButtonClick:(id)sender
{
    if (![_checkField.text isEqualToString:verifyString])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手机验证码输入有误" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else
    {
         AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=User&a=success"]];
        request.delegate=self;
        request.tag=3;
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request setPostValue:mobileString forKey:@"mobile"];

        [request startAsynchronous];
    }
}
- (IBAction)cancelButtonClick:(id)sender {
    _mobileField.text=@"";
    _checkField.text=@"";
    _mobileField.hidden= YES;
    _checkSignLable.hidden =YES;
    _checkField.hidden = YES;
    _getCheckButton.hidden =YES;
//    _sureButton.hidden = YES;
    _cancelButton.hidden = YES;
}



@end

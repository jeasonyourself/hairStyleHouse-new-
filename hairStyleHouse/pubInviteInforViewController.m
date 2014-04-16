//
//  pubInviteInforViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-11.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "pubInviteInforViewController.h"
#import "HZAreaPickerView.h"
#import "findStyleDetailViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "AllAroundPullView.h"

#import "MobClick.h"
@interface pubInviteInforViewController () <UITextFieldDelegate, HZAreaPickerDelegate>

@property (retain, nonatomic) IBOutlet UITextField *areaText;
@property (retain, nonatomic) IBOutlet UITextField *cityText;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;

@property (strong, nonatomic) NSString *areaValue, *cityValue;
@property (strong, nonatomic) HZAreaPickerView *locatePicker;

-(void)cancelLocatePicker;

@end


@implementation pubInviteInforViewController
@synthesize areaText;
@synthesize cityText;
@synthesize areaValue=_areaValue, cityValue=_cityValue;
@synthesize locatePicker=_locatePicker;

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
    [self textFiledReturnEditing:_numTextField];
    [self textFiledReturnEditing:_addressTextField];
    [self textFiledReturnEditing:_mobileTextField];
    [self textFiledReturnEditing:_nameTextField];
}



#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.areaText]) {
        [self cancelLocatePicker];
        self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self] ;
        [self.locatePicker showInView:self.view];
    } else {
        [self cancelLocatePicker];
        self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCity delegate:self] ;
        [self.locatePicker showInView:self.view];
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
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 7, 100, 30)];
    Lab.text = @"发布招聘";
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
    [self refreashNav];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _pubButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _pubButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _pubButton.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _pubButton.layer.masksToBounds = YES;//设为NO去试试
    
    inforDic = [[NSDictionary alloc] init];
    //    headImage = [[UIImageView alloc] init];
    verifyString = [[NSString alloc] init];
    mobileString= [[NSString alloc] init];
    sexString = [[NSString alloc] init];
    headString = [[NSString alloc] init];
    
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    myTableView.allowsSelection=NO;
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.view addSubview:myTableView];
	// Do any additional setup after loading the view.
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
    [leftButton setImage:[UIImage imageNamed:@"返回.png"]  forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [leftButton setBackgroundColor:[UIColor clearColor]];
    [leftButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(0,28, 24, 26);
    UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
}

-(void)viewDidAppear:(BOOL)animated
{

    NSString* cName = [NSString stringWithFormat:@"发布招聘"];
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
    
    NSString* cName = [NSString stringWithFormat:@"发布招聘"];
    [MobClick endLogPageView:cName];
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
//    backView=nil;
    backView = [[[NSBundle mainBundle] loadNibNamed:@"pubInviteMessage" owner:self options:nil] objectAtIndex:0];
  
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pubButtonClick:(id)sender
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    if ([appDele.type isEqualToString:@"1"]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你不是发型师，不能发布招聘信息!" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
    if ([areaText.text isEqualToString:@""]||[cityText.text isEqualToString:@""]||[_numTextField.text isEqualToString:@""]||[_addressTextField.text isEqualToString:@""]||[_mobileTextField.text isEqualToString:@""]||[_nameTextField.text isEqualToString:@""])
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请完善招聘信息" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        ASIFormDataRequest* request;
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=jobs&a=jobsAdd"]]];
        
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request setPostValue:appDele.secret forKey:@"secret"];
        [request setPostValue:_numTextField.text forKey:@"number"];
        [request setPostValue:_addressTextField.text forKey:@"address"];
        [request setPostValue:_nameTextField.text forKey:@"store_name"];
        
        [request setPostValue:_mobileTextField.text forKey:@"telephone"];

        [request setPostValue:areaText.text forKey:@"city"];
        if (![cityText.text isEqualToString:@""]) {
            NSString *newStr =cityText.text;
            
            NSString *temp = nil;
            for(int i =0; i < [newStr length]; i++)
            {
                temp = [newStr substringWithRange:NSMakeRange(i, 1)];
                if ([temp isEqualToString:@"0"]||[temp isEqualToString:@"1"]||[temp isEqualToString:@"2"]||[temp isEqualToString:@"4"]||[temp isEqualToString:@"6"]||[temp isEqualToString:@"8"]||[temp isEqualToString:@"面"])
                {
                    
                    [request setPostValue:[newStr substringWithRange:NSMakeRange(0, i-1)] forKey:@"job"];
                    if ([temp isEqualToString:@"面"]) {
                        [request setPostValue:@"1" forKey:@"interviews"];
                    }
                    else
                    {
                    [request setPostValue:[newStr substringWithRange:NSMakeRange(i-1, [newStr length]+1-i)] forKey:@"money"];
                    }
                    break;
                }
            }
            
        }
        request.delegate=self;
        request.tag=1;
        [request startAsynchronous];
    }
    }
}
    -(void)requestFinished:(ASIHTTPRequest *)request
    {
        
        if (request.tag==1)
        {
            NSLog(@"%@",request.responseString);
            NSData*jsondata = [request responseData];
            NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            SBJsonParser* jsonP=[[SBJsonParser alloc] init];
            NSDictionary* dic=[jsonP objectWithString:jsonString];
            NSLog(@"是否发布成功dic:%@",dic);
            
            [self.navigationController popViewControllerAnimated:NO];

            
        }

    }
-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
    
}

- (IBAction)touchDown:(id)sender
{

    [self cancelLocatePicker];
    [self textFiledReturnEditing:_numTextField];
    [self textFiledReturnEditing:_addressTextField];
    [self textFiledReturnEditing:_mobileTextField];
    [self textFiledReturnEditing:_nameTextField];
//    [self textFiledReturnEditing:_checkField];
    
}

@end

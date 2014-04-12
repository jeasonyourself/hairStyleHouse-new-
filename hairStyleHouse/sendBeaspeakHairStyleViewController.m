//
//  sendBeaspeakHairStyleViewController.m
//  hairStyleHouse
//
//  Created by jeason on 14-1-13.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import "sendBeaspeakHairStyleViewController.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "SBJson.h"
#import "BaiduMobStat.h"
#import "TPKeyboardAvoidingScrollView.h"

//#define currentMonth [currentMonthString integerValue]
@interface sendBeaspeakHairStyleViewController ()

@end

@implementation sendBeaspeakHairStyleViewController
@synthesize inforDic;
@synthesize headImg;
@synthesize _hidden;
@synthesize scrollView;
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
    [self refreashNav];
    [self refreashNavLab];
    oldPriceString = [[NSString alloc] init];
    saleString = [[NSString alloc] init];
    newPriceString = [[NSString alloc] init];
    dateString = [[NSString alloc] init];
    dateString1 = [[NSString alloc] init];
    timeString = [[NSString alloc] init];
     timeDataString= [[NSString alloc] init];
   
    yearArray = [[NSMutableArray alloc] init];
    hoursArray = [[NSMutableArray alloc] init];
    minutesArray = [[NSMutableArray alloc] init];
    
    _firstView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _firstView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _firstView.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _firstView.layer.masksToBounds = YES;//设为NO去试试
    
    _headImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _headImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _headImage.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _headImage.layer.masksToBounds = YES;//设为NO去试试
       
    _secondView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _secondView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _secondView.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _secondView.layer.masksToBounds = YES;//设为NO去试试
    _sendBeaspeakButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _sendBeaspeakButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _sendBeaspeakButton.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _sendBeaspeakButton.layer.masksToBounds = YES;//设为NO去试试
//    NSString * headStr= [self.inforDic objectForKey:@"work_image"];
    NSString * nameStr = [self.inforDic objectForKey:@"long_service"];
    oldPriceString= [self.inforDic objectForKey:@"price"];
    saleString= [self.inforDic objectForKey:@"rebate"];
    newPriceString = [self.inforDic objectForKey:@"reserve_price"];
//    NSString * addressStr = [self.inforDic objectForKey:@"store_address"];
    
    
    
    [_headImage setImageWithURL:[NSURL URLWithString:headImg]];
    
   
    if ([nameStr isEqualToString:@"0"]) {
        _nameLable.text=@"暂无";
    }
    else
    {
        _nameLable.text=[NSString stringWithFormat:@" %@折",saleString];
    }
    
    
    if ([oldPriceString isEqualToString:@"0.00"]) {
        _oldPrice.text=@"暂无";
    }
    else
    {
        _oldPrice.text=[NSString stringWithFormat:@"￥%@",oldPriceString];
    }
    
    if ([newPriceString isEqualToString:@"0.00"]) {
        _nowPrice.text=@"暂无";
    }
    else
    {
        _nowPrice.text=[NSString stringWithFormat:@"￥%@",newPriceString];
    }
    
    
    if(iPhone5)
    {
        
    }
    else{
        _firstView.hidden=YES;
        
        _secondView.hidden=YES;
    }
    
    
    
    //新版本年月日
    
    firstTimeLoad = YES;
    self.customPicker.hidden = YES;
    self.toolbarCancelDone.hidden = YES;
    
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate * today = [NSDate date];
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    for (int i = 1; i < 31; i ++)
    {
        NSString *dateStr = [myDateFormatter stringFromDate:[today dateByAddingTimeInterval:i * secondsPerDay]];
        NSLog(@"dateString:%@",dateStr);
        [yearArray addObject:dateStr];
    }
    
    NSLog(@"yearArray:%@",yearArray);
//    NSDate *date = [NSDate date];
    
    // Get Current Year
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    // Get Current  Hour
//    [formatter setDateFormat:@"HH"];
//    NSString *currentHourString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
//    
//    // Get Current  Minutes
//    [formatter setDateFormat:@"mm"];
//    NSString *currentMinutesString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    // Get Current  AM PM
    
//    [formatter setDateFormat:@"a"];
//    NSString *currentTimeAMPMString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    
    // PickerView -  Years data
    
       // PickerView -  Hours data
    
    hoursArray = [[NSMutableArray alloc]init];
    for (int i = 9; i <= 22; i++)
    {
        
        [hoursArray addObject:[NSString stringWithFormat:@"%02d",i]];
        
    }    //    hoursArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    
    NSLog(@"hoursArray:%@",hoursArray);
    // PickerView -  Hours data
    
    minutesArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 59; i=i+15)
    {
        
        [minutesArray addObject:[NSString stringWithFormat:@"%02d",i]];
        
    }
    NSLog(@"minutesArray:%@",minutesArray);
    
    // PickerView -  AM PM data
//    amPmArray=[[NSMutableArray alloc] initWithObjects:@"AM",@"PM", nil];
    //    amPmArray = @[@"AM",@"PM"];
    
    
    
    // PickerView -  days data
    
    
    // PickerView - Default Selection as per current Date
    
    [self.customPicker selectRow:0 inComponent:0 animated:YES];
    
    [self.customPicker selectRow:0 inComponent:1 animated:YES];
    [self.customPicker selectRow:0 inComponent:2 animated:YES];
//    [self.customPicker selectRow:[amPmArray indexOfObject:currentTimeAMPMString] inComponent:5 animated:YES];

    
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

-(void)leftButtonClick
{
    if ([_hidden isEqualToString:@"yes"]) {
        self.navigationController.navigationBar.hidden=YES;
        
    }
    else
    {
        self.navigationController.navigationBar.hidden=NO;
        
    }
    
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)refreashNavLab
{
    
    
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 7, 100, 30)];
    Lab.text = @"预约发型详细";
    
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}

-(void)viewDidAppear:(BOOL)animated
{
    

    NSString* cName = [NSString stringWithFormat:@"预约发型详细"];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if(iPhone5)
    {
        
    }
    else
    {
        _firstView.hidden=NO;
        _secondView.hidden=NO;
        
        _firstView.frame = CGRectMake(0, 70, 320, 107);
        _headBackView.frame = CGRectMake(15, 10, 88, 88);
        _headImage.frame = CGRectMake(5, 5, 78, 78);
        
        
        _addressLable.frame = CGRectMake(117, 82, 193, 20);
        
        
        
        _secondView.frame = CGRectMake(0, 182, 320, 437);
 
    }
}

//- (void)keyboardWillShow:(NSNotification *)notification {
//    
//    /*
//     Reduce the size of the text view so that it's not obscured by the keyboard.
//     Animate the resize so that it's in sync with the appearance of the keyboard.
//     */
//    NSDictionary *userInfo = [notification userInfo];
//    
//    // Get the origin of the keyboard when it's displayed.
//    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
//    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
//    CGRect keyboardRect = [aValue CGRectValue];
//    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
//    
//    CGFloat keyboardTop = keyboardRect.origin.y;
//    CGRect newTextViewFrame = self.view.bounds;
//    newTextViewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
//    
//    newTextViewFrame.origin.y =newTextViewFrame.size.height+80-self.view.bounds.size.height;//自己加的，特为此界面定制
//    // Get the duration of the animation.
//    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
//    NSTimeInterval animationDuration;
//    [animationDurationValue getValue:&animationDuration];
//    
//    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:animationDuration];
//    
//    _backView.frame = newTextViewFrame;
//    NSLog(@"_backView.frame:%@",NSStringFromCGRect(_backView.frame));
//    
//    [UIView commitAnimations];
//}
//- (void)keyboardWillHide:(NSNotification *)notification {
//    
//    NSDictionary* userInfo = [notification userInfo];
//    
//    /*
//     Restore the size of the text view (fill self's view).
//     Animate the resize so that it's in sync with the disappearance of the keyboard.
//     */
//    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
//    NSTimeInterval animationDuration;
//    [animationDurationValue getValue:&animationDuration];
//    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:animationDuration];
//    
//    _backView.frame = self.view.bounds;
//    
//    [UIView commitAnimations];
//}

-(void)viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"预约发型详细"];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}



#pragma mark - UIPickerViewDelegate
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//{
//    
//    return 3;
//    
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
//    
//    if (component == 0)
//    {
//        selectedYearRow = row;
//        [self.customPicker reloadAllComponents];
//    }
//    else if (component == 1)
//    {
//        selectedMonthRow = row;
//        [self.customPicker reloadAllComponents];
//    }
//    else if (component == 2)
//    {
//        selectedDayRow = row;
//        
//        [self.customPicker reloadAllComponents];
//        
//    }
    
}


#pragma mark - UIPickerViewDatasource

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    
    // Custom View created for each component
    
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGRect frame;
        if (component == 0)
        {
             frame = CGRectMake(0.0, 0.0, 200, 60);
        }
        else
        {
         frame = CGRectMake(0.0, 0.0, 50, 60);
        }
        
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:15.0f]];
    }
    
    
    
    if (component == 0)
    {
        pickerLabel.text =  [yearArray objectAtIndex:row]; // Year
        
    }
//    else if (component == 1)
//    {
//        pickerLabel.text =  [monthArray objectAtIndex:row];  // Month
//    }
//    else if (component == 2)
//    {
//        pickerLabel.text =  [DaysArray objectAtIndex:row]; // Date
//        
//    }
    else if (component == 1)
    {
        pickerLabel.text =  [hoursArray objectAtIndex:row]; // Hours
    }
    else if (component == 2)
    {
        pickerLabel.text =  [minutesArray objectAtIndex:row]; // Mins
    }
//    else
//    {
//        pickerLabel.text =  [amPmArray objectAtIndex:row]; // AM/PM
//    }
    
    return pickerLabel;
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 3;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0)
    {
        return [yearArray count];
        
    }
//    else if (component == 1)
//    {
//        return [monthArray count];
//    }
//    else if (component == 2)
//    { // day
//        
//        if (firstTimeLoad)
//        {
//            if (currentMonth == 1 || currentMonth == 3 || currentMonth == 5 || currentMonth == 7 || currentMonth == 8 || currentMonth == 10 || currentMonth == 12)
//            {
//                return 31;
//            }
//            else if (currentMonth == 2)
//            {
//                int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
//                
//                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
//                    
//                    return 29;
//                }
//                else
//                {
//                    return 28; // or return 29
//                }
//                
//            }
//            else
//            {
//                return 30;
//            }
//            
//        }
//        else
//        {
//            
//            if (selectedMonthRow == 0 || selectedMonthRow == 2 || selectedMonthRow == 4 || selectedMonthRow == 6 || selectedMonthRow == 7 || selectedMonthRow == 9 || selectedMonthRow == 11)
//            {
//                return 31;
//            }
//            else if (selectedMonthRow == 1)
//            {
//                int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
//                
//                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
//                    return 29;
//                }
//                else
//                {
//                    return 28; // or return 29
//                }
//                
//                
//                
//            }
//            else
//            {
//                return 30;
//            }
//            
//        }
//        
//        
//    }
    else if (component == 1)
    { // hour
        
        return 14;
        
    }
    else if (component == 2)
    { // min
        return 4;
    }
    else
    { // am/pm
        return 2;
        
    }
    
    
    
}






- (IBAction)actionCancel:(id)sender
{
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.customPicker.hidden = YES;
                         self.toolbarCancelDone.hidden = YES;
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                         
                     }];
    
    
}

- (IBAction)actionDone:(id)sender
{
    
    
    _timeField.text = [NSString stringWithFormat:@"%@ %@:%@ ",[yearArray objectAtIndex:[self.customPicker selectedRowInComponent:0]],[hoursArray objectAtIndex:[self.customPicker selectedRowInComponent:1]],[minutesArray objectAtIndex:[self.customPicker selectedRowInComponent:2]]];
//    timeDataString=_timeField.text;
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.customPicker.hidden = YES;
                         self.toolbarCancelDone.hidden = YES;
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                         
                     }];
    
    
    
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==_timeField) {
    [self.view endEditing:YES];
        [_mobileField resignFirstResponder];
        [_nameField resignFirstResponder];
    }
    else
    {
    [scrollView adjustOffsetToIdealIfNeeded];
        [UIView animateWithDuration:0.5
                              delay:0.1
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             
                             self.customPicker.hidden = YES;
                             self.toolbarCancelDone.hidden = YES;
                             
                             
                         }
                         completion:^(BOOL finished){
                             
                             
                         }];
    }
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField==_timeField) {
   
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.customPicker.hidden = NO;
                         self.toolbarCancelDone.hidden = NO;
                         _timeField.text = @"";
                         
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
    
    self.customPicker.hidden = NO;
    self.toolbarCancelDone.hidden = NO;
    _timeField.text = @"";
        [_mobileField resignFirstResponder];
        [_nameField resignFirstResponder];
        return NO;
    
    }
    
    return YES;
        
    
}

//- (IBAction)actionCancel:(id)sender {
//    
//}
//
//- (IBAction)actionDone:(id)sender {
//    
//}

- (IBAction)sendBeaspeakButtonClick:(id)sender
{
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:_mobileField.text];
    
    if (!isMatch)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([_mobileField.text isEqualToString:@""])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入姓名" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        ASIFormDataRequest* request;
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=reserve&a=orderAdd"]]];
        
        [request setPostValue:@"2"forKey:@"order_type"];//预约发型为2
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        [request setPostValue:appDele.uid forKey:@"my_uid"];
        [request setPostValue:[self.inforDic objectForKey:@"uid"]forKey:@"to_uid"];
        
        [request setPostValue:@"2" forKey:@"order_type"];
        [request setPostValue:@"如图所示" forKey:@"reserve_type"];

//        [request setPostValue:dateString1 forKey:@"reserve_time"];
        
//        [request setPostValue:timeString forKey:@"reserve_hour"];
        
        [request setPostValue:oldPriceString forKey:@"price"];
        [request setPostValue:saleString forKey:@"rebate"];
        [request setPostValue:newPriceString forKey:@"reserve_price"];
        [request setPostValue:[_nameField text] forKey:@"my_name"];
        [request setPostValue:[_mobileField text] forKey:@"my_tel"];
        [request setPostValue:appDele.secret forKey:@"secret"];
        [request setPostValue:_timeField.text forKey:@"reserve_time"];
        [request setPostValue:[inforDic objectForKey:@"work_id"] forKey:@"work_id"];
//        [request setPostValue:styleString forKey:@"reserve_type"];//预约发型没有这一项
        
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"M-d HH:mm"];
//        NSDate* date = [formatter dateFromString:timeDataString];
//        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
//        NSLog(@"timeDataString:%@",timeDataString);
//        NSLog(@"timeSp:%@",timeSp);
        
//        [request setPostValue:timeSp forKey:@"reserve_time"];
        request.delegate=self;
        [request startAsynchronous];
        
        
    }
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSLog(@"%@",request.responseString);
    NSData*jsondata = [request responseData];
    NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    SBJsonParser* jsonP=[[SBJsonParser alloc] init];
    NSDictionary* dic=[jsonP objectWithString:jsonString];
    NSLog(@"预约是否成功dic:%@",dic);
    if ([[dic objectForKey:@"code"] isEqualToString:@"101"])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"预约成功" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
        [self leftButtonClick];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"预约失败" message:@"您尚有未完成预约" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}



-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"预约失败" message:@"网络连接失败" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];
}


-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
    
}
- (IBAction)touchDown:(id)sender
{
    [self textFiledReturnEditing:_nameField];
    [self textFiledReturnEditing:_mobileField];
    [self textFiledReturnEditing:_timeField];
}

//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  setBeaspeakViewController.m
//  hairStyleHouse
//
//  Created by jeason on 14-1-20.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import "setBeaspeakViewController.h"
#import "AppDelegate.h"
#import "SBJson.h"

#import "MobClick.h"
#import "TPKeyboardAvoidingTableView.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "JSONKit.h"
@interface setBeaspeakViewController ()

@end

@implementation setBeaspeakViewController
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
    [super viewDidLoad];
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 7, 100, 30)];
    Lab.text = @"预约设置";
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
    [self refreashNav];
    
    
    scrollView.hidden=NO;
    _myTableView.hidden=YES;
    dresserArray = [[NSMutableArray alloc] init];
    dresserArray1 = [[NSMutableArray alloc] init];
    string = [[NSString alloc] init];

    _myTableView.frame=CGRectMake(0, 104, 320, 370);
//    _firstPrice.keyboardType=UIKeyboardTypeDecimalPad;
    
//    _firstSale.keyboardType=UIKeyboardTypeDecimalPad;
//    _secondSale.keyboardType=UIKeyboardTypeDecimalPad;
//    _thirdSale.keyboardType=UIKeyboardTypeDecimalPad;
//    _forthSale.keyboardType=UIKeyboardTypeDecimalPad;

//    _myTableView.userInteractionEnabled=NO;
    [_myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    _sureButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _sureButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _sureButton.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _sureButton.layer.masksToBounds = YES;//设为NO去试试
    
    [self getData];
    [self getData1];
    // Do any additional setup after loading the view from its nib.
}
-(void)getData
{
    
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=goods&a=promptView"]];
    request.delegate=self;
    request.tag=101;
    [request setPostValue:appDele.uid forKey:@"uid"];
    [request startAsynchronous];
    

}

-(void)getData1
{
    
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=goods&a=goodsView"]];
    request.delegate=self;
    request.tag=102;
    [request setPostValue:appDele.uid forKey:@"uid"];
    [request startAsynchronous];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{

    NSString* cName = [NSString stringWithFormat:@"预约设置"];
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
    
    newTextViewFrame.origin.y =newTextViewFrame.size.height+80-self.view.bounds.size.height;//自己加的，特为此界面定制
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    if ([_firstTextField isFirstResponder]||[_secondTextField isFirstResponder]||[_thirdTextField isFirstResponder]||[_forthTextField isFirstResponder]||[_fifithTextField isFirstResponder]) {
        
    }
    else
    {
    _backView.frame = newTextViewFrame;
    }
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
    NSString* cName = [NSString stringWithFormat:@"预约设置"];
    [MobClick endLogPageView:cName];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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

- (IBAction)sureButtonClick:(id)sender
{
    if ([_firstTextField.text isEqualToString:@""]&&[_secondTextField.text isEqualToString:@""]&&[_thirdTextField.text isEqualToString:@""]&&[_forthTextField.text isEqualToString:@""]&&[_fifithTextField.text isEqualToString:@""])
    {
        UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入至少一个提醒设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    
//    else if ([_firstPrice.text isEqualToString:@""]||[_firstSale.text isEqualToString:@""]||[_secondPrice.text isEqualToString:@""]||[_secondSale.text isEqualToString:@""]||[_thirdPrice.text isEqualToString:@""]||[_thirdSale.text isEqualToString:@""]||[_forthPrice.text isEqualToString:@""]||[_forthSale.text isEqualToString:@""])
//    {
//        UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入完整的价格和折扣信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//    }
    else
    {
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=goods&a=promptAdd"]];
        request.delegate=self;
            request.tag=1;
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request setPostValue:appDele.secret forKey:@"secret"];
        if (![_firstTextField.text isEqualToString:@""]) {
            [request setPostValue:_firstTextField.text forKey:@"tip1"];

        }
        if (![_secondTextField.text isEqualToString:@""]) {
            [request setPostValue:_secondTextField.text forKey:@"tip2"];
            
        }
        if (![_thirdTextField.text isEqualToString:@""]) {
            [request setPostValue:_thirdTextField.text forKey:@"tip3"];
            
        }
        if (![_forthTextField.text isEqualToString:@""]) {
            [request setPostValue:_forthTextField.text forKey:@"tip4"];
            
        }
        if (![_fifithTextField.text isEqualToString:@""]) {
            [request setPostValue:_fifithTextField.text forKey:@"tip5"];
            
        }
        
        [request startAsynchronous];
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
        NSLog(@"预约提醒dic:%@",dic);
        if ([[dic objectForKey:@"code"] isEqualToString:@"101"]) {
//            
//            AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
//            ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Reserve&a=priceset"]];
//            request.delegate=self;
//            request.tag=2;
//            [request setPostValue:appDele.uid forKey:@"uid"];
//            
//            NSString * priceStr = [NSString stringWithFormat:@"%@_%@_%@_%@_%@_%@_%@_%@",_firstPrice.text,_secondPrice.text,_thirdPrice.text,_forthPrice.text,_firstSale.text,_secondSale.text,_thirdSale.text,_forthSale.text];
//            [request setPostValue:priceStr forKey:@"price_info"];
//
//            [request startAsynchronous];
        }
        else
        {
            UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"设置失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }

    }
//    if(request.tag==2)
//    {
//        NSLog(@"%@",request.responseString);
//        NSData*jsondata = [request responseData];
//        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
//            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
//            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
//        NSDictionary* dic=[jsonP objectWithString:jsonString];
//        NSLog(@"预约提醒dic:%@",dic);
//        if ([[dic objectForKey:@"code"] isEqualToString:@"101"]) {
//            
//            UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"设置成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alert show];
//            [self leftButtonClick];
//        }
//        else
//        {
//            UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"设置失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alert show];
//        }    }
    
    else if (request.tag==101) {
        
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"预约提醒dic:%@",dic);
        if ([[dic  objectForKey:@"info"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic  objectForKey:@"info"] isKindOfClass:[NSArray class]])
        {
            dresserArray = [dic objectForKey:@"info"];
            
        }

        if (dresserArray.count==1) {
            _firstTextField.text = [NSString stringWithFormat:@"%@",[dresserArray objectAtIndex:0] ];
            
        }
        else if (dresserArray.count==2) {
            _firstTextField.text = [NSString stringWithFormat:@"%@",[dresserArray objectAtIndex:0]];
            _secondTextField.text = [NSString stringWithFormat:@"%@",[dresserArray objectAtIndex:1]];
            
            
        }
        else if (dresserArray.count==3) {
            _firstTextField.text = [NSString stringWithFormat:@"%@",[dresserArray objectAtIndex:0]];
            _secondTextField.text = [NSString stringWithFormat:@"%@",[dresserArray objectAtIndex:1]];
            _thirdTextField.text= [NSString stringWithFormat:@"%@",[dresserArray objectAtIndex:2]];
        }
        else if (dresserArray.count==4) {
            _firstTextField.text = [NSString stringWithFormat:@"%@",[dresserArray objectAtIndex:0]];
            _secondTextField.text = [NSString stringWithFormat:@"%@",[dresserArray objectAtIndex:1]];
            _thirdTextField.text= [NSString stringWithFormat:@"%@",[dresserArray objectAtIndex:2]];
            _forthTextField.text= [NSString stringWithFormat:@"%@",[dresserArray objectAtIndex:3]];
        }
        else if (dresserArray.count==5) {
            
            _firstTextField.text = [NSString stringWithFormat:@"%@",[dresserArray objectAtIndex:0]];
            _secondTextField.text = [NSString stringWithFormat:@"%@",[dresserArray objectAtIndex:1]];
            _thirdTextField.text= [NSString stringWithFormat:@"%@",[dresserArray objectAtIndex:2]];
            _forthTextField.text= [NSString stringWithFormat:@"%@",[dresserArray objectAtIndex:3]];
            _fifithTextField.text= [NSString stringWithFormat:@"%@",[dresserArray objectAtIndex:4]];
        }
        else if (dresserArray.count==0)
        {
            
        }
        
        
//        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
//        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Reserve&a=priceinfo"]];
//        request.delegate=self;
//        request.tag=102;
//        [request setPostValue:appDele.uid forKey:@"uid"];
//        
//        [request startAsynchronous];
    }
    
    else if (request.tag==102) {
        
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"服务列表dic:%@",dic);
        if ([[dic objectForKey:@"goodsInfo"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"goodsInfo"] isKindOfClass:[NSArray class]])
        {
        dresserArray1 = [dic objectForKey:@"goodsInfo"];
        }
        
        
        [_myTableView reloadData];
//
//
//        _firstPrice.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
//        _firstSale.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:4]];
//       
//        
//        _secondPrice.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
//        _secondSale.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:5]];
//        _thirdPrice.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
//        _thirdSale.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:6]];
//        _forthPrice.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:3]];
//        _forthSale.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:7]];
//       
//        }
    }
    
    else if (request.tag==103) {
        
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"是否删除成功dic:%@",dic);
    }
    else if (request.tag==104) {
        
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"是否添加修改成功dic:%@",dic);
        NSLog(@"终于成功了~");

    }
       //    AppDelegate *appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;//调用appdel
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请求超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dresserArray1.count + 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row]==0) {
        return 40;
    }
    else
    {
        return 60;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString *cellID=@"cell";
        setBeaspeakCell *cell=(setBeaspeakCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[setBeaspeakCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            cell.fatherViewController=self;
            
            //            cell.fatherController=self;
        }
        
        NSInteger row =[indexPath row];
    
    if (row==0) {
//        cell.userInteractionEnabled=NO;
        [cell setFirstCell];
    }
    
    else if (row==dresserArray1.count+1) {
        [cell setLastCell];

    }
    else if (row==dresserArray1.count+2) {
        [cell setLastCell1];
        
    }
    else
    {

        [cell setOtherCell:dresserArray1 andIndex:row-1];
    }

//        cell.textLabel.text = [firstArr objectAtIndex:row];
    
    
    
   
        return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [scrollView adjustOffsetToIdealIfNeeded];
}

- (void)textFieldEditChanged:(UITextField *)textField
{
    NSInteger  index =textField.tag;
     NSLog(@"textField.tag:%d",textField.tag);
    NSLog(@"textField.text:%@",textField.text);
    switch (index) {
        case 0:
            [[dresserArray1 objectAtIndex:0] setObject:textField.text forKey:@"goods_name"];
            break;
        case 1:
            [[dresserArray1 objectAtIndex:0] setObject:textField.text forKey:@"price"];
            break;
        case 2:
            [[dresserArray1 objectAtIndex:0] setObject:textField.text forKey:@"rebate"];
            break;
        case 3:
            [[dresserArray1 objectAtIndex:0] setObject:textField.text forKey:@"reserve_price"];
            break;
            
        case 4:
            [[dresserArray1 objectAtIndex:1] setObject:textField.text forKey:@"goods_name"];
            break;
        case 5:
            [[dresserArray1 objectAtIndex:1] setObject:textField.text forKey:@"price"];
            break;
        case 6:
            [[dresserArray1 objectAtIndex:1] setObject:textField.text forKey:@"rebate"];
            break;
        case 7:
            [[dresserArray1 objectAtIndex:1] setObject:textField.text forKey:@"reserve_price"];
            break;
            
        case 8:
            [[dresserArray1 objectAtIndex:2] setObject:textField.text forKey:@"goods_name"];
            break;
        case 9:
            [[dresserArray1 objectAtIndex:2] setObject:textField.text forKey:@"price"];
            break;
        case 10:
            [[dresserArray1 objectAtIndex:2] setObject:textField.text forKey:@"rebate"];
            break;
        case 11:
            [[dresserArray1 objectAtIndex:2] setObject:textField.text forKey:@"reserve_price"];
            break;
            
        case 12:
            [[dresserArray1 objectAtIndex:3] setObject:textField.text forKey:@"goods_name"];
            break;
        case 13:
            [[dresserArray1 objectAtIndex:3] setObject:textField.text forKey:@"price"];
            break;
        case 14:
            [[dresserArray1 objectAtIndex:3] setObject:textField.text forKey:@"rebate"];
            break;
        case 15:
            [[dresserArray1 objectAtIndex:3] setObject:textField.text forKey:@"reserve_price"];
            break;
            
        case 16:
            [[dresserArray1 objectAtIndex:4] setObject:textField.text forKey:@"goods_name"];
            break;
        case 17:
            [[dresserArray1 objectAtIndex:4] setObject:textField.text forKey:@"price"];
            break;
        case 18:
            [[dresserArray1 objectAtIndex:4] setObject:textField.text forKey:@"rebate"];
            break;
        case 19:
            [[dresserArray1 objectAtIndex:4] setObject:textField.text forKey:@"reserve_price"];
            break;
        case 20:
            [[dresserArray1 objectAtIndex:4] setObject:textField.text forKey:@"goods_name"];
            break;
        case 21:
            [[dresserArray1 objectAtIndex:5] setObject:textField.text forKey:@"price"];
            break;
        case 22:
            [[dresserArray1 objectAtIndex:5] setObject:textField.text forKey:@"rebate"];
            break;
        case 23:
            [[dresserArray1 objectAtIndex:5] setObject:textField.text forKey:@"reserve_price"];
            break;
        case 24:
            [[dresserArray1 objectAtIndex:5] setObject:textField.text forKey:@"goods_name"];
            break;
        case 25:
            [[dresserArray1 objectAtIndex:6] setObject:textField.text forKey:@"price"];
            break;
        case 26:
            [[dresserArray1 objectAtIndex:6] setObject:textField.text forKey:@"rebate"];
            break;
        case 27:
            [[dresserArray1 objectAtIndex:6] setObject:textField.text forKey:@"reserve_price"];
            break;
        case 28:
            [[dresserArray1 objectAtIndex:6] setObject:textField.text forKey:@"goods_name"];
            break;
        case 29:
            [[dresserArray1 objectAtIndex:7] setObject:textField.text forKey:@"price"];
            break;
        case 30:
            [[dresserArray1 objectAtIndex:7] setObject:textField.text forKey:@"rebate"];
            break;
        case 31:
            [[dresserArray1 objectAtIndex:7] setObject:textField.text forKey:@"reserve_price"];
            break;
        case 32:
            [[dresserArray1 objectAtIndex:7] setObject:textField.text forKey:@"goods_name"];
            break;
        case 33:
            [[dresserArray1 objectAtIndex:8] setObject:textField.text forKey:@"price"];
            break;
        case 34:
            [[dresserArray1 objectAtIndex:8] setObject:textField.text forKey:@"rebate"];
            break;
        case 35:
            [[dresserArray1 objectAtIndex:8] setObject:textField.text forKey:@"reserve_price"];
            break;
        case 36:
            [[dresserArray1 objectAtIndex:8] setObject:textField.text forKey:@"goods_name"];
            break;
        case 37:
            [[dresserArray1 objectAtIndex:9] setObject:textField.text forKey:@"price"];
            break;
        case 38:
            [[dresserArray1 objectAtIndex:9] setObject:textField.text forKey:@"rebate"];
            break;
        case 39:
            [[dresserArray1 objectAtIndex:9] setObject:textField.text forKey:@"reserve_price"];
            break;
        case 40:
            [[dresserArray1 objectAtIndex:9] setObject:textField.text forKey:@"goods_name"];
            break;
        case 41:
            [[dresserArray1 objectAtIndex:10] setObject:textField.text forKey:@"price"];
            break;
        case 42:
            [[dresserArray1 objectAtIndex:10] setObject:textField.text forKey:@"rebate"];
            break;
        case 43:
            [[dresserArray1 objectAtIndex:10] setObject:textField.text forKey:@"reserve_price"];
            break;
        case 44:
            [[dresserArray1 objectAtIndex:10] setObject:textField.text forKey:@"goods_name"];
            break;
        case 45:
            [[dresserArray1 objectAtIndex:11] setObject:textField.text forKey:@"price"];
            break;
        case 46:
            [[dresserArray1 objectAtIndex:11] setObject:textField.text forKey:@"rebate"];
            break;
        case 47:
            [[dresserArray1 objectAtIndex:11] setObject:textField.text forKey:@"reserve_price"];
            break;
        case 48:
            [[dresserArray1 objectAtIndex:11] setObject:textField.text forKey:@"goods_name"];
            break;
        case 49:
            [[dresserArray1 objectAtIndex:12] setObject:textField.text forKey:@"price"];
            break;
        case 50:
            [[dresserArray1 objectAtIndex:12] setObject:textField.text forKey:@"rebate"];
            break;
        case 51:
            [[dresserArray1 objectAtIndex:12] setObject:textField.text forKey:@"reserve_price"];
            break;
        case 52:
            [[dresserArray1 objectAtIndex:12] setObject:textField.text forKey:@"goods_name"];
            break;
        case 53:
            [[dresserArray1 objectAtIndex:13] setObject:textField.text forKey:@"price"];
            break;
        case 54:
            [[dresserArray1 objectAtIndex:13] setObject:textField.text forKey:@"rebate"];
            break;
        case 55:
            [[dresserArray1 objectAtIndex:13] setObject:textField.text forKey:@"reserve_price"];
            break;
        case 56:
            [[dresserArray1 objectAtIndex:13] setObject:textField.text forKey:@"goods_name"];
            break;
        case 57:
            [[dresserArray1 objectAtIndex:14] setObject:textField.text forKey:@"price"];
            break;
        case 58:
            [[dresserArray1 objectAtIndex:14] setObject:textField.text forKey:@"rebate"];
            break;
        case 59:
            [[dresserArray1 objectAtIndex:14] setObject:textField.text forKey:@"reserve_price"];
            break;
        default:
            break;
    }

  
}
- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [textField resignFirstResponder];
    return YES;

}
-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
    
}

- (IBAction)touchDown:(id)sender
{
    [self textFiledReturnEditing:_firstTextField];
    [self textFiledReturnEditing:_secondTextField];
    [self textFiledReturnEditing:_thirdTextField];
    [self textFiledReturnEditing:_forthTextField];
    [self textFiledReturnEditing:_fifithTextField];

    [self textFiledReturnEditing:_firstPrice];
    [self textFiledReturnEditing:_secondPrice];
    [self textFiledReturnEditing:_thirdPrice];
    [self textFiledReturnEditing:_forthPrice];

    
    [self textFiledReturnEditing:_firstSale];
    [self textFiledReturnEditing:_secondSale];
    [self textFiledReturnEditing:_thirdSale];
    [self textFiledReturnEditing:_forthSale];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addNew
{
    if (dresserArray1.count>15)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"添加失败" message:@"添加项目已超过上线" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else
    {
        NSMutableDictionary * dic =[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"",@"goods_id",@"",@"goods_name",
                             @"",@"price",
                             @"",@"rebate",@"",
                             @"reserve_price", nil];
        [dresserArray1 addObject:dic];
        
        NSLog(@"dresserArray.count:%d",dresserArray1.count);
        [_myTableView reloadData];
    }
    
    
}

-(void)deleteView:(NSInteger)index
{
    if ([[dresserArray1 objectAtIndex:index] objectForKey:@"goods_id"])
    {
        
        
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=goods&a=goodsDel"]];
        request.delegate=self;
        request.tag=103;
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request setPostValue:appDele.secret forKey:@"secret"];
        [request setPostValue:[[dresserArray1 objectAtIndex:index] objectForKey:@"goods_id"] forKey:@"goods_id"];
        [request startAsynchronous];
    }
    
   else
   {
   
   }
    [dresserArray1 removeObjectAtIndex:index];
      [_myTableView reloadData];
}

-(void)lookAllcell
{
    [self resignFirstResponder];
    
    if (dresserArray1.count==0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"添加失败" message:@"尚未添加服务项目" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
        return;

    }
    else
    {
        for (NSDictionary * dic in dresserArray1)
        {
            if ([[dic objectForKey:@"goods_name"] isEqualToString:@""]||[[dic objectForKey:@"price"] isEqualToString:@""]||[[dic objectForKey:@"reserve_price"] isEqualToString:@""]||[[dic objectForKey:@"rebate"] isEqualToString:@""])
            {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"添加失败" message:@"信息不完整" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                [alert show];
                return;
 
            }
        }
        
        NSMutableArray * arr = [NSMutableArray arrayWithArray:dresserArray1];
        for (int i=0;i<dresserArray1.count;i++ )
        {
            NSMutableDictionary * dic1 =[dresserArray1 objectAtIndex:i];
            for (int j=0; j<arr.count; j++)
            {
                if (j==i) {
                    
                }
                else
                {
                NSMutableDictionary * dic2=[arr objectAtIndex:j];
                if ([[dic1 objectForKey:@"goods_name"] isEqualToString:[dic2 objectForKey:@"goods_name"]])
                {
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"添加失败" message:@"含有相同名称的服务项目" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                    [alert show];
                    return;
                }
                }
            }
        }
        
        string=[NSString stringWithFormat:@"["];
        NSDictionary * dic;
        for (int i =0;i<dresserArray1.count;i++)
        {
            dic = [dresserArray1 objectAtIndex:i];
             NSString* str = [[NSString alloc] initWithFormat:@"%@",[dic JSONString]];
            NSLog(@"strstr:%@",str);
            if (i==0)
            {
               
                string=[NSString stringWithFormat:@"%@%@",string,str];
                NSLog(@"string1~~:%@",string);
            }
            else
            {
                string=[NSString stringWithFormat:@"%@,%@",string,str];
            }
             NSLog(@"returnString:%@",[dic JSONString]);
            
        }
        string=[NSString stringWithFormat:@"%@]",string];
       
        NSLog(@"string2~~:%@",string);
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=goods&a=goodsAdd"]];
        request.delegate=self;
        request.tag=104;
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request setPostValue:string forKey:@"goodsInfo"];
        [request setPostValue:appDele.secret forKey:@"secret"];

        [request startAsynchronous];
        
        
        }
//
}

- (IBAction)firstButtonClick:(id)sender {
    
    [_firstButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [_secondButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    _firstButton.layer.borderColor =[ [UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _secondButton.layer.borderColor =[ [UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    
    scrollView.hidden=NO;
    _myTableView.hidden=YES;
    
}

- (IBAction)secondButtonClick:(id)sender {
    [_firstButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]forState:UIControlStateNormal];
    [_secondButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    _secondButton.layer.borderColor =[ [UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _firstButton.layer.borderColor =[ [UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    scrollView.hidden=YES;
    _myTableView.hidden=NO;
    
}
@end

//
//  commentViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-2.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "commentViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import "dresserInforViewController.h"
#import "BaiduMobStat.h"
@interface commentViewController ()

@end

@implementation commentViewController
@synthesize inforDic;
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
    self.view.backgroundColor = [UIColor whiteColor];
    [self refreashNavLab];
    [self refreashNav];
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-60) style:UITableViewStylePlain];
    dresserArray =[[NSMutableArray alloc] init];
    
    //    myTableView.allowsSelection=NO;
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.allowsSelection=NO;
    myTableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:myTableView];
    
    lastView = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height-60, self.view.bounds.size.width, 60)];
    lastView.backgroundColor = [UIColor colorWithRed:231.0/256.0 green:231.0/256.0 blue:231.0/256.0 alpha:1.0];
    lastView.layer.cornerRadius = 0;//设置那个圆角的有多圆
    lastView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    lastView.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    lastView.layer.masksToBounds = YES;//设为NO去试试
    lastView.backgroundColor = [UIColor colorWithRed:220.0/256.0 green:220.0/256.0 blue:220.0/256.0 alpha:1.0];
  
    [self.view addSubview:lastView];
    
    contentView = [[UITextView alloc] initWithFrame:CGRectMake(10,10, 230, 40)];
    contentView.font =[UIFont systemFontOfSize:12.0];
    contentView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    contentView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    contentView.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    contentView.layer.masksToBounds = YES;//设为NO去试试

    contentView.delegate =self;
    [lastView addSubview:contentView];
    
//    sendButton=[[UIButton alloc] initWithFrame:CGRectMake(200,10, 60, 40)];
    sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame=CGRectMake(250,10, 60, 40);
    [sendButton.layer setMasksToBounds:YES];
    [sendButton.layer setCornerRadius:3.0];
//    [sendButton.layer setBorderWidth:1.0];
    [sendButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
//    [sendButton setBackgroundColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0]];
    [sendButton setBackgroundColor:[UIColor clearColor]];

    [sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [sendButton addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [lastView addSubview:sendButton];
    
    [self getData];
    
}

-(void)viewDidAppear:(BOOL)animated
{

    NSString* cName = [NSString stringWithFormat:@"查看评论"];
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
    
    myTableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-60);
    lastView.frame = CGRectMake(0,self.view.bounds.size.height-60, self.view.bounds.size.width, 60);
    
    [UIView commitAnimations];
}

-(void)viewDidDisappear:(BOOL)animated
{
    
    NSString* cName = [NSString stringWithFormat:@"查看评论"];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
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

    -(void)leftButtonClick
    {
        [self.navigationController popViewControllerAnimated:NO];
    }

    -(void)refreashNavLab
    {
        UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
        Lab.text = [NSString stringWithFormat:@"查看评论"];
        Lab.textAlignment = NSTextAlignmentCenter;
        Lab.font = [UIFont systemFontOfSize:16];
        Lab.textColor = [UIColor blackColor];
        self.navigationItem.titleView =Lab;
    }

-(void)getData
{
//    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    NSURL * urlString= [NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Works&a=commentlist"];
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:urlString];
    request.delegate=self;
    request.tag=1;
    NSLog(@"````%@",inforDic);
    [request setPostValue:[[inforDic objectForKey:@"works_info"] objectForKey:@"work_id"] forKey:@"works_id"];
    [request startAsynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (dresserArray!=nil) {
        [dresserArray removeAllObjects];
    }
    if (request.tag==1) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"inforDic:%@",inforDic);
        NSLog(@"评论列表dic:%@",dic);
        
        
        if ([[dic objectForKey:@"comment_list"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"comment_list"] isKindOfClass:[NSArray class]])
        {
            dresserArray = [dic objectForKey:@"comment_list"];//评价列表
        }
        
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
        NSLog(@"评论是否成功dic:%@",dic);
        contentView.text=@"";
        [self getData];
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
    return dresserArray.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([indexPath row]==0)
    {
        return 400;
    }
    else
    {
    //初始化label
    //        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    //设置自动行数与字符换行
    //        [label setNumberOfLines:0];
    //        label.lineBreakMode = UILineBreakModeWordWrap;
    //        [label setFrame:CGRectMake(0,0, labelsize.width, labelsize.height)];
    
    
    // 测试字串
    NSString *_content =[[dresserArray objectAtIndex:[indexPath row]-1] objectForKey:@"content"];
    UIFont *font = [UIFont systemFontOfSize:12.0];
    //设置一个行高上限
    CGSize size = CGSizeMake(200,200);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [_content sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        
        if (labelsize.height<20) {
            return 60;
        }
       else
       {
        return   48+labelsize.height;
       }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    commentCell *cell=(commentCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[commentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.fatherController=self;
    }
    NSInteger row =[indexPath row];
    if (row==0) {

        [cell setFirstCell:inforDic andArr:dresserArray];
    }
    else
    {
        [cell setOtherCell:dresserArray and:row];
    }
    return cell;
}

-(void)sendButtonClick
{
    if ([contentView.text isEqualToString:@""]) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入内容" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
    [contentView resignFirstResponder];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    NSURL * urlString= [NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Works&a=comment"];
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:urlString];
    request.delegate=self;
    request.tag=2;
    NSLog(@"````%@",inforDic);
    [request setPostValue:appDele.uid forKey:@"from_uid"];
    [request setPostValue:[[inforDic objectForKey:@"works_info"] objectForKey:@"work_id"] forKey:@"works_id"];
    [request setPostValue:contentView.text forKey:@"content"];
    [request startAsynchronous];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)headButtonClick
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    if ([[[inforDic objectForKey:@"works_info"] objectForKey:@"uid" ] isEqualToString:appDele.uid])
    {
        
    }
    else
    {
        if ([[[inforDic objectForKey:@"works_info"] objectForKey:@"type" ] isEqualToString:@"2"])
        {
            dreserView =nil;
            dreserView =[[dresserInforViewController alloc] init];
            dreserView._hidden=@"no";
            dreserView.uid = [[inforDic objectForKey:@"works_info"] objectForKey:@"uid" ];
            [self.navigationController pushViewController:dreserView animated:NO ];
            
        }
        else
        {
            
            userView =nil;
            userView =[[userInforViewController alloc] init];
            userView._hidden=@"no";
            userView.uid = [[inforDic objectForKey:@"works_info"] objectForKey:@"uid" ];
            [self.navigationController pushViewController:userView animated:NO ];
            
        }
    }

}
-(void)headButtonClick1:(NSInteger)_index
{
    
    
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if ([[[dresserArray objectAtIndex:_index] objectForKey:@"from_uid"] isEqualToString:appDele.uid])
    {
        
    }
    else
    {
//        if (_index==-1)
//        {
//            [self headButtonClick];
//        }
//        else
//        {
            if ([[[dresserArray objectAtIndex:_index] objectForKey:@"type"] isEqualToString:@"2"])
            {
                dreserView =nil;
                dreserView =[[dresserInforViewController alloc] init];
                dreserView._hidden=@"no";
                dreserView.uid = [[dresserArray objectAtIndex:_index] objectForKey:@"from_uid"];
                [self.navigationController pushViewController:dreserView animated:NO ];
                
            }
            else
            {
                
                userView =nil;
                userView =[[userInforViewController alloc] init];
                userView._hidden=@"no";
                userView.uid = [[dresserArray objectAtIndex:_index] objectForKey:@"from_uid"];
                [self.navigationController pushViewController:userView animated:NO ];
                
            }
//        }
    }
}
-(void)smallButtonClick1:(NSInteger)_index
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if ([[[[inforDic objectForKey:@"like_list"] objectAtIndex:_index] objectForKey:@"uid"] isEqualToString:appDele.uid])
    {
        
    }
    else
    {
        if ([[[[inforDic objectForKey:@"like_list"] objectAtIndex:_index] objectForKey:@"type"] isEqualToString:@"2"])
        {
            dreserView =nil;
            dreserView =[[dresserInforViewController alloc] init];
            dreserView._hidden=@"no";
            dreserView.uid = [[[inforDic objectForKey:@"like_list"] objectAtIndex:_index] objectForKey:@"uid"];
            [self.navigationController pushViewController:dreserView animated:NO ];
            
        }
        else
        {
            
            userView =nil;
            userView =[[userInforViewController alloc] init];
            userView._hidden=@"no";
            userView.uid = [[[inforDic objectForKey:@"like_list"] objectAtIndex:_index] objectForKey:@"uid"];
            [self.navigationController pushViewController:userView animated:NO ];
            
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

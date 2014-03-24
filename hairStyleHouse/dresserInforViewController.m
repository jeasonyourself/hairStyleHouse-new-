//
//  dresserInforViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-28.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "dresserInforViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "BaiduMobStat.h"
@interface dresserInforViewController ()

@end

@implementation dresserInforViewController
@synthesize uid;
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
    inforDic = [[NSDictionary alloc] init];
    
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 7, 100, 30)];
    Lab.text = [NSString stringWithFormat:@"查看发型师"];
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
    [self refreashNav];
    
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    myTableView.allowsSelection=NO;
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.view addSubview:myTableView];
    
    [self getData];
}



#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"查看发型师"];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"查看发型师"];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}

    -(void)getData
    {
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=User&a=visitInfo"]];
        request.delegate=self;
        request.tag=1;
        [request setPostValue:self.uid forKey:@"uid"];
        [request setPostValue:appDele.uid forKey:@"to_uid"];
        [request setPostValue:@"2" forKey:@"type"];
        [request startAsynchronous];
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
        NSLog(@"发型师信息dic:%@",dic);
//        inforDic = [dic objectForKey:@"user_info"];
            inforDic = dic;
        
        [self freashView];
        }
        //    AppDelegate *appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;//调用appdel
    }
    
    -(void)requestFailed:(ASIHTTPRequest *)request
    {
        UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请求失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
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
        UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
        self.navigationItem.leftBarButtonItem=leftButtonItem;
        
//        rightButton=[[UIButton alloc] init];
//        rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [rightButton.layer setMasksToBounds:YES];
//        [rightButton.layer setCornerRadius:3.0];
//        [rightButton.layer setBorderWidth:1.0];
//        [rightButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
//        if ([str isEqualToString:@"1"])
//        {
//            [rightButton setTitle:@"取消关注" forState:UIControlStateNormal];
//            rightButton.tag=1;
//        }
//        else
//        {
//            [rightButton setTitle:@"关注" forState:UIControlStateNormal];
//            rightButton.tag=0;
//
//        }
//        rightButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
//        [rightButton setBackgroundColor:[UIColor colorWithRed:214.0/256.0 green:78.0/256.0 blue:78.0/256.0 alpha:1.0]];
//        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [rightButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//        [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        rightButton.frame = CGRectMake(12,20, 60, 25);
//        UIBarButtonItem *rightButtonItem=[[UIBarButtonItem alloc] initWithCustomView:rightButton];
//        self.navigationItem.rightBarButtonItem=rightButtonItem;
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
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightButtonClick
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=User&a=follow"]];
    request.delegate=self;
    request.tag=2;
    [request setPostValue:appDele.uid forKey:@"uid"];
    [request setPostValue:self.uid forKey:@"touid"];
    [request setPostValue:appDele.type forKey:@"type"];
    [request setPostValue:@"2" forKey:@"totype"];
    
    if ( rightButton.tag==1)//取消关注
    {
        [request setPostValue:@"0" forKey:@"status"];
        [rightButton setTitle:@"关注" forState:UIControlStateNormal];
        rightButton.tag=0;
        
    }
    else//加关注
    {
        [request setPostValue:@"1" forKey:@"status"];
        [rightButton setTitle:@"取消关注" forState:UIControlStateNormal];
        rightButton.tag=1;
        
    }
    [request startAsynchronous];
//在这里关注或取消关注
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
        [cell.contentView addSubview:backView.view];
        return cell;
    }
    
    - (void)updateBackView
    {
        backView=nil;
        
        backView=[[dresserDetailViewController alloc] init];
        backView.fatherController=self;
        backView.infoDic =inforDic;
    }

-(void)pushToViewController:(id)_sen
{
    [self.navigationController pushViewController:_sen animated:NO];
}
-(void)needAppdelegatePushToViewController:(id)_sen
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    [appDele pushToViewController:_sen];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

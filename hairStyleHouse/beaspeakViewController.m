//
//  beaspeakViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "beaspeakViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
@interface beaspeakViewController ()

@end

@implementation beaspeakViewController

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
    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320, 50)];
    [topImage setImage:[UIImage imageNamed:@"当前预约.png"]];
    
    UIButton * oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oneButton.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 160, 50);
    oneButton.backgroundColor = [UIColor clearColor];
    [oneButton addTarget:self action:@selector(oneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    twoButton.frame = CGRectMake(160,self.navigationController.navigationBar.frame.size.height+20, 160, 50);
    twoButton.backgroundColor = [UIColor clearColor];
    [twoButton addTarget:self action:@selector(twoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topImage];
    [self.view addSubview:oneButton];
    [self.view addSubview:twoButton];
    
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-50) style:UITableViewStylePlain];
    dresserArray =[[NSMutableArray alloc] init];
    nowOrhistory = YES;
    
    //    myTableView.allowsSelection=NO;
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.view addSubview:myTableView];
    
    [self getData];
}

-(void)oneButtonClick
{
    [topImage setImage:[UIImage imageNamed:@"当前预约.png"]];
    nowOrhistory = YES;

    [self getData];
    
}
-(void)twoButtonClick
{
    [topImage setImage:[UIImage imageNamed:@"历史预约.png"]];
    nowOrhistory = NO;

    [self getData];
}

-(void)leftButtonClick
{
    self.navigationController.navigationBar.hidden=YES;
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
    Lab.text = @"预约记录";
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}


-(void)getData
{
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    ASIFormDataRequest* request;
    if (nowOrhistory==YES)
    {
//        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Reserve&a=history"]];
    }
    else
    {
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Reserve&a=history"]];
    }
        request.delegate=self;
        request.tag=1;
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request startAsynchronous];   
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (dresserArray!=nil) {
        [dresserArray removeAllObjects];
    }
    if (request.tag==1)
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"预约列表dic:%@",dic);
        if ([[dic objectForKey:@"order_list"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"order_list"] isKindOfClass:[NSArray class]])
        {
            dresserArray = [dic objectForKey:@"order_list"];
            
        }
        [self freashView];
    }
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请求超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
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
    return dresserArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    beaspeakCell *cell=(beaspeakCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[beaspeakCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSInteger row =[indexPath row];
    [cell setCell:[dresserArray objectAtIndex:row] andIndex:row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    deaspeakDresser =nil;
    deaspeakDresser =[[beaspeakDresserViewController alloc] init];
    deaspeakDresser.orderId = [[dresserArray objectAtIndex:[indexPath row] ] objectForKey:@"id"];
    [self.navigationController pushViewController:deaspeakDresser animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

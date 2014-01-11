//
//  addBeaspeakHairStyleViewController.m
//  hairStyleHouse
//
//  Created by jeason on 14-1-11.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import "addBeaspeakHairStyleViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
@interface addBeaspeakHairStyleViewController ()

@end

@implementation addBeaspeakHairStyleViewController
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
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    dresserArray =[[NSMutableArray alloc] init];
    workInforDic = [[NSDictionary alloc] init];
    //    myTableView.allowsSelection=NO;
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.allowsSelection=NO;
    myTableView.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.view addSubview:myTableView];
    
    
    
    [self getData];
    
}

-(void)viewDidAppear:(BOOL)animated
{
   
}

-(void)viewDidDisappear:(BOOL)animated
{
    
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

-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)refreashNavLab
{
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
    Lab.text = [NSString stringWithFormat:@"预约发型"];
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}

-(void)getData
{
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    NSURL * urlString= [NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Willdo&a=willDoItem"];
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:urlString];
    request.delegate=self;
    request.tag=2;
    
    NSLog(@"inforDic:%@",inforDic);
    [request setPostValue:[[inforDic objectForKey:@"works_info"] objectForKey:@"work_id"] forKey:@"work_id"];
    [request setPostValue:[NSString stringWithFormat:@"%f",appDele.latitude] forKey:@"lat"];
     [request setPostValue:[NSString stringWithFormat:@"%f",appDele.longitude] forKey:@"lng"];

    [request startAsynchronous];
}

-(void)getData1
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    NSURL * urlString= [NSURL URLWithString:@"http://wap.faxingw.cn/index.php?m=Willdo&a=reWorksList"];
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:urlString];
    request.delegate=self;
    request.tag=1;
    [request setPostValue:[[inforDic objectForKey:@"works_info"] objectForKey:@"work_id"] forKey:@"work_id"];
    [request setPostValue:appDele.city forKey:@"city"];
    [request setPostValue:[NSString stringWithFormat:@"%f",appDele.latitude] forKey:@"lat"];
    [request setPostValue:[NSString stringWithFormat:@"%f",appDele.longitude] forKey:@"lng"];
    
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
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"预约作品dic:%@",dic);
        
        if ([[dic objectForKey:@"willdo_list"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"willdo_list"] isKindOfClass:[NSArray class]])
        {
            dresserArray = [dic objectForKey:@"willdo_list"];//评价列表
        }
        
        [self freashView];
    }
    else if (request.tag==2)//原创信息
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"原创dic:%@",dic);
        
        workInforDic =dic;
        [self getData1];
        
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
        
        NSString *_content =[workInforDic objectForKey:@"store_address"];
        UIFont *font = [UIFont systemFontOfSize:12.0];
        //设置一个行高上限
        CGSize size = CGSizeMake(200,200);
        //计算实际frame大小，并将label的frame变成实际大小
        CGSize labelsize = [_content sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        
        if (labelsize.height<20) {
            return 350;
        }
        else
        {
            return 350+labelsize.height;
        }

        
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
        NSString *_content =[[dresserArray objectAtIndex:[indexPath row]-1] objectForKey:@"store_address"];
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
    addbeaspeakHairStyleCell *cell=(addbeaspeakHairStyleCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[addbeaspeakHairStyleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.layer.cornerRadius =10;//设置那个圆角的有多圆
        cell.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        cell.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        cell.layer.masksToBounds = YES;//设为NO去试试
    }
    NSInteger row =[indexPath row];
    if (row==0) {
        
        [cell setFirstCell:workInforDic andArr:dresserArray];
    }
    else
    {
        [cell setOtherCell:dresserArray and:row];
    }
    return cell;
}

-(void)sendButtonClick
{
    
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

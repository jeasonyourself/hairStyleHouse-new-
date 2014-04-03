//
//  ViewController.m
//  areapicker
//
//  Created by Cloud Dai on 12-9-9.
//  Copyright (c) 2012年 clouddai.com. All rights reserved.
//

#import "inviteViewController.h"
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
#import "BaiduMobStat.h"
@interface inviteViewController () <UITextFieldDelegate, HZAreaPickerDelegate>

@property (retain, nonatomic) IBOutlet UITextField *areaText;
@property (retain, nonatomic) IBOutlet UITextField *cityText;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;

@property (strong, nonatomic) NSString *areaValue, *cityValue;
@property (strong, nonatomic) HZAreaPickerView *locatePicker;

-(void)cancelLocatePicker;

@end

@implementation inviteViewController
@synthesize areaText;
@synthesize cityText;
@synthesize areaValue=_areaValue, cityValue=_cityValue;
@synthesize locatePicker=_locatePicker;
@synthesize _hidden;

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
}

- (IBAction)searchButtonClick:(id)sender
{
     [self cancelLocatePicker];
    page=@"1";
    [dresserArray removeAllObjects];
    [self getData];
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


-(void)viewDidLoad
{
    [self refreashNavLab];
    [self refreashNav];
    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+25, 320, 40)];
    topImage.backgroundColor = [UIColor whiteColor];
    topImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
    topImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    topImage.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    topImage.layer.masksToBounds = YES;//设为NO去试试
    //    [topImage setImage:[UIImage imageNamed:@"最新发型.png"]];
    
    oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oneButton.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height+25, 320/2, 40);
    oneButton.backgroundColor = [UIColor clearColor];
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    
    [oneButton addTarget:self action:@selector(oneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    twoButton.frame = CGRectMake(320/2,self.navigationController.navigationBar.frame.size.height+25, 320/2, 40);
    twoButton.backgroundColor = [UIColor clearColor];
    
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton addTarget:self action:@selector(twoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [oneButton setTitle:@"同城" forState:UIControlStateNormal];
    [twoButton setTitle:@"我的" forState:UIControlStateNormal];
    [self.view addSubview:topImage];
    [self.view addSubview:oneButton];
    [self.view addSubview:twoButton];
    
    
    _searchButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
    _searchButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    _searchButton.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    _searchButton.layer.masksToBounds = YES;//设为NO去试试
    
    
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 210, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-160) style:UITableViewStylePlain];
    myTableView.allowsSelection=YES;
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:myTableView];
    
    dresserArray =[[NSMutableArray alloc] init];
    page =[[NSString alloc] init];
    page=@"1";
    pageCount=[[NSString alloc] init];
    
    dresserArray1 =[[NSMutableArray alloc] init];
    page1 =[[NSString alloc] init];
    page1=@"1";
    pageCount1=[[NSString alloc] init];
    
    sign =[[NSString alloc] init];
    sign = @"1";
    
    bottomRefreshView = [[AllAroundPullView alloc] initWithScrollView:myTableView position:AllAroundPullViewPositionBottom action:^(AllAroundPullView *view){
        NSLog(@"loadMore");
        [self pullLoadMore];
    }];
    bottomRefreshView.hidden=NO;
    [myTableView addSubview:bottomRefreshView];
    
    
    [self getData];
    [self getData1];
}
-(void)oneButtonClick
{
    //    [topImage setImage:[UIImage imageNamed:@"最新发型.png"]];
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    
    sign=@"1";
    [myTableView reloadData];
    
}
-(void)twoButtonClick
{
    [oneButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    //    [topImage setImage:[UIImage imageNamed:@"同城发型.png"]];
    //    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    sign=@"2";
    
    [myTableView reloadData];
    
}

#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"招聘信息"];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"招聘信息"];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}
-(void)pullLoadMore
{
    
    if ([sign isEqualToString:@"1"]) {
        NSInteger _pageCount= [pageCount integerValue];
        
        NSInteger _page = [page integerValue];
        
        NSLog(@"page:%@",page);
        NSLog(@"pageCount:%@",pageCount);
        
        if (_page<_pageCount) {
            _page++;
            page = [NSString stringWithFormat:@"%d",_page];
            NSLog(@"page:%@",page);
            [self getData];
        }
        else
        {
            [bottomRefreshView performSelector:@selector(finishedLoading)];
            
        }
    }
    else
    {
        NSInteger _pageCount= [pageCount1 integerValue];
        
        NSInteger _page = [page1 integerValue];
        
        NSLog(@"page1:%@",page1);
        NSLog(@"pageCount1:%@",pageCount1);
        
        if (_page<_pageCount) {
            _page++;
            page1 = [NSString stringWithFormat:@"%d",_page];
            NSLog(@"page:%@",page);
            [self getData1];
        }
        else
        {
            [bottomRefreshView performSelector:@selector(finishedLoading)];
            
        }
    }
    
}
-(void)getData
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=jobs&a=jobsList&page%@",page]]];
    
    [request setPostValue:appDele.uid forKey:@"uid"];
    [request setPostValue:@"new" forKey:@"condition"];
    if (![areaText.text isEqualToString:@""])
    {
        [request setPostValue:areaText.text forKey:@"city"];
        
    }
    else
    {
     [request setPostValue:appDele.city forKey:@"city"];
    }
    
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
                    [request setPostValue:@"0" forKey:@"money"];
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

-(void)getData1
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=jobs&a=jobsList&page%@",page1]]];
    
    [request setPostValue:appDele.uid forKey:@"uid"];
    [request setPostValue:@"my" forKey:@"condition"];
    if (![areaText.text isEqualToString:@""])
    {
        [request setPostValue:areaText.text forKey:@"city"];
        
    }
    else
    {
        [request setPostValue:appDele.city forKey:@"city"];
    }
    
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
                    [request setPostValue:@"0" forKey:@"money"];
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
    request.tag=2;
    [request startAsynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSMutableArray * arr;
    
    if (request.tag==1) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"%@招聘列表dic:%@",sign,dic);
        
        pageCount = [dic objectForKey:@"page_count"];
        if ([[dic objectForKey:@"jobs_list"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"jobs_list"] isKindOfClass:[NSArray class]])
        {
            arr= [dic objectForKey:@"jobs_list"];
            [dresserArray addObjectsFromArray:arr];
            NSLog(@"dresser.count:%d",dresserArray.count);
            
        }
//        [self freashView];
    }
    else if (request.tag==2) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"%@招聘列表dic:%@",sign,dic);
        
        pageCount1 = [dic objectForKey:@"page_count"];
        if ([[dic objectForKey:@"jobs_list"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"jobs_list"] isKindOfClass:[NSArray class]])
        {
            arr= [dic objectForKey:@"jobs_list"];
            [dresserArray1 addObjectsFromArray:arr];
            NSLog(@"dresser.count:%d",dresserArray1.count);
            
        }
        
    }
    if (request.tag==202) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"删除成功dic:%@",dic);
    }

    [self freashView];
}

-(void)freashView
{
    [bottomRefreshView performSelector:@selector(finishedLoading)];
    
    [myTableView reloadData];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([sign isEqualToString:@"1"]) {
        return dresserArray.count;
    }
    else
    {
    return dresserArray1.count;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   80;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    inviteCell *cell=(inviteCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[inviteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.fatherView =self;
    }
    NSUInteger row = [indexPath row];
    
    //    NSUInteger row3 = [indexPath row]*3+2;
    //    NSLog(@"row3:%d",row3);
    if ([sign isEqualToString:@"1"]) {
        [cell setCell:[dresserArray objectAtIndex:row] andIndex:row];

    }
    else
    {
        [cell setCell:[dresserArray1 objectAtIndex:row] andIndex:row];

    }
    
    
    //    if (row3<dresserArray.count)//防止可能越界
    //    {
    //        [cell setCell:[dresserArray objectAtIndex:row3] andIndex:row3];
    //    }
    
    return cell;
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([sign isEqualToString:@"2"]) {
        return YES;
    }
    else
    {
        return NO;
    }
    // Return NO if you do not want the specified item to be editable.
    
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=jobs&a=jobsDel"]];
        
        request.delegate=self;
        request.tag=202;
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request setPostValue:[[dresserArray1 objectAtIndex:[indexPath row]] objectForKey:@"id"] forKey:@"id"];
        [request setPostValue:appDele.secret forKey:@"secret"];
        
        [request startAsynchronous];
        
        [dresserArray1 removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self cancelLocatePicker];
    if ([sign isEqualToString:@"1"]) {
        inviteDetail = nil;
        inviteDetail  = [[inviteDetailViewController alloc] init] ;
        inviteDetail.inforDic = [dresserArray objectAtIndex:[indexPath row]];
        [self.navigationController pushViewController:inviteDetail animated:NO];
    }
    else
    {
        inviteDetail = nil;
        inviteDetail  = [[inviteDetailViewController alloc] init] ;
        inviteDetail.inforDic = [dresserArray1 objectAtIndex:[indexPath row]];
        [self.navigationController pushViewController:inviteDetail animated:NO];
    }
    
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

-(void)rightButtonClick
{

    punInviteView = nil;
    punInviteView =[[pubInviteInforViewController alloc] init];
    [self.navigationController pushViewController:punInviteView animated:NO];
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
    
    UIButton * rightButton=[[UIButton alloc] init];
    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton.layer setMasksToBounds:YES];
    [rightButton.layer setCornerRadius:3.0];
    [rightButton.layer setBorderWidth:1.0];
    [rightButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [rightButton setTitle:@"发布" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [rightButton setBackgroundColor:[UIColor clearColor]];
    [rightButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(12,20, 60, 25);
    UIBarButtonItem *rightButtonItem=[[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem=rightButtonItem;
}

-(void)refreashNavLab
{
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 7, 100, 30)];
    
    
    Lab.text = @"招聘信息";
    
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}

-(void)selectCell:(NSInteger)_index
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


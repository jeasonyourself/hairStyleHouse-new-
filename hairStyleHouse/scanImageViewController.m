//
//  scanImageViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-28.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "scanImageViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "AllAroundPullView.h"
@interface scanImageViewController ()

@end

@implementation scanImageViewController
@synthesize worksOrsave;
@synthesize selfOrOther;
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
    [super viewDidLoad];
    [self refreashNavLab];
    [self refreashNav];
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    dresserArray =[[NSMutableArray alloc] init];
    cleandresserArray =[[NSMutableArray alloc] init];

    page =[[NSString alloc] init];
    page=@"1";
    pageCount=[[NSString alloc] init];
    
    myTableView.allowsSelection=NO;
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.view addSubview:myTableView];
    bottomRefreshView = [[AllAroundPullView alloc] initWithScrollView:myTableView position:AllAroundPullViewPositionBottom action:^(AllAroundPullView *view){
        NSLog(@"loadMore");
        [self pullLoadMore];
    }];
    bottomRefreshView.hidden=NO;
    [myTableView addSubview:bottomRefreshView];


    [self getData];
}

-(void)pullLoadMore
{
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
        UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
        if ([worksOrsave isEqualToString:@"works"])
        {
            if ([selfOrOther isEqualToString:@"self"]) {
                Lab.text = @"我的作品";
                
            }
            else
            {
                Lab.text = @"会做作品";
            }
        }
        else
        {
            Lab.text = @"我的收藏";

        }
        
        Lab.textAlignment = NSTextAlignmentCenter;
        Lab.font = [UIFont systemFontOfSize:16];
        Lab.textColor = [UIColor blackColor];
        self.navigationItem.titleView =Lab;
    }
    
    
-(void)getData
    {
       
        ASIFormDataRequest* request;
        if ([worksOrsave isEqualToString:@"works"])
        {
            if ([selfOrOther isEqualToString:@"self"]) {
                request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Willdo&a=willDoList&page=%@",page]]];
            }
            else
            {
                request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=User&a=workslist&page=%@",page]]];
            }
            
        }
        else
        {
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=User&a=collectlist&page=%@",page]]];
        }
        
            request.delegate=self;
            request.tag=1;
       
            [request setPostValue:self.uid forKey:@"uid"];
            [request startAsynchronous];

    }
    
-(void)requestFinished:(ASIHTTPRequest *)request
    {
        NSMutableArray * arr;
     

        if (request.tag==1) {
            NSLog(@"%@",request.responseString);
            NSData*jsondata = [request responseData];
            NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            SBJsonParser* jsonP=[[SBJsonParser alloc] init];
            NSDictionary* dic=[jsonP objectWithString:jsonString];
            NSLog(@"粉丝列表dic:%@",dic);
            
            pageCount = [dic objectForKey:@"page_count"];
            if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSString class]])
            {
                
            }
            else if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSArray class]])
            {
                arr= [dic objectForKey:@"works_info"];
                [dresserArray addObjectsFromArray:arr];
                NSLog(@"dresser.count:%d",dresserArray.count);
                
            }
            if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSString class]])
            {
                
            }
            else if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSArray class]])
            {
                arr= [dic objectForKey:@"image_list"];
                [cleandresserArray addObjectsFromArray:arr];
                
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
        [bottomRefreshView performSelector:@selector(finishedLoading)];

    }
    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        return 1;
    }
    
    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        
        if (dresserArray.count%3==0)
        {
            return dresserArray.count/3;
        }
        else
        {
            return dresserArray.count/3+1;
        }
    }
    
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        return   160;
    }
    
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        static NSString *cellID=@"cell";
        scanCell *cell=(scanCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[scanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.fatherView =self;
        }
        NSUInteger row1 = [indexPath row]*3;
        NSLog(@"row1:%d",row1);
        NSUInteger row2 = [indexPath row]*3+1;
        NSLog(@"row2:%d",row2);
        NSUInteger row3 = [indexPath row]*3+2;
        NSLog(@"row3:%d",row3);
        [cell setCell:[dresserArray objectAtIndex:row1] andIndex:row1];
        if (row2<dresserArray.count)//防止可能越界
        {
          [cell setCell:[dresserArray objectAtIndex:row2] andIndex:row2];
        }
        if (row3<dresserArray.count)//防止可能越界
        {
            [cell setCell:[dresserArray objectAtIndex:row3] andIndex:row3];
        }
    return cell;
    }



-(void)selectImage:(NSInteger)_index
{
    int count = cleandresserArray.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *url = [[cleandresserArray[i] objectForKey:@"work_image"] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.work_id =[cleandresserArray[i] objectForKey:@"work_id"];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        //        photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    browser=nil;
    browser = [[MJPhotoBrowser alloc] init];
    NSInteger reallIndex;
    NSString * str = [dresserArray[_index] objectForKey:@"work_id"];
    for (int i = 0; i<count; i++)//获得真实位置
    {
        // 替换为中等尺寸图片
        NSString *string1 = [cleandresserArray[i] objectForKey:@"work_id"];
        if ([string1 isEqualToString:str])
        {
            reallIndex =i;
            break;
        }
    }
    
    browser.currentPhotoIndex = reallIndex; // 弹出相册时显示的第一张图片是？ // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [self.navigationController pushViewController:browser animated:YES];
    //    [browser show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

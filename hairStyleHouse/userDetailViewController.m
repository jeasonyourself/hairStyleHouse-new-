//
//  userDetailViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-6.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "userDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "userInforViewController.h"
@interface userDetailViewController ()

@end

@implementation userDetailViewController
@synthesize infoDic;
@synthesize fatherController;
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
    workScroll=[[UIScrollView alloc] init];
    workScroll.delegate=self;
    workScroll.frame = CGRectMake(0, 3,320,_secondBackView.frame.size.height);
    [_secondBackView addSubview:workScroll];
    
    saveScroll=[[UIScrollView alloc] init];
    saveScroll.delegate=self;
    saveScroll.scrollEnabled=NO;
    saveScroll.frame = CGRectMake(0, 3,320,_saveBackView.frame.size.height);
    [_saveBackView addSubview:saveScroll];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    NSString* headStr=[infoDic objectForKey:@"head_photo"];
    NSString* nameStr = [infoDic objectForKey:@"username"];
    NSString* cityStr = [infoDic objectForKey:@"city"];
 
    NSString* workStr = [infoDic objectForKey:@"works_num"];
    NSMutableArray * workArr;
    if ([[infoDic objectForKey:@"portfolio"] isKindOfClass:[NSString class]])
    {
        
    }
    else if ([[infoDic objectForKey:@"portfolio"] isKindOfClass:[NSArray class]])
    {
        workArr = [infoDic objectForKey:@"portfolio"];
        
    }
    
    
    
    NSString* inforStr = [infoDic objectForKey:@"signature"];

    NSMutableArray * saveArr;
    if ([[infoDic objectForKey:@"works_list"] isKindOfClass:[NSString class]])
    {
        
    }
    else if ([[infoDic objectForKey:@"works_list"] isKindOfClass:[NSArray class]])
    {
        saveArr = [infoDic objectForKey:@"works_list"];
        
    }
    
    NSString* concerStr = [infoDic objectForKey:@"isconcerns"];//是否关注
    
 
    
    
    [_headImage setImageWithURL:[NSURL URLWithString:headStr]];
    _nameLable.text = nameStr;
    _addressLable.text = cityStr;
    
    
    _worksLable.text = [NSString stringWithFormat:@"作品集(共%@张)",workStr];
    _inforTextVuew.text = [NSString stringWithFormat:@"%@",inforStr];
   
    
    
    for (UIView* _sub in workScroll.subviews)
    {
        //        if ([_sub isKindOfClass:[AllAroundPullView class]]) {
        //            continue;
        //        }
        [_sub removeFromSuperview];
    }
    
    if (workArr.count>0)
    {
        [workScroll setContentSize:CGSizeMake(workArr.count*(60+10), 60)];
        if (workScroll.contentSize.width<workScroll.frame.size.width)
        {
            [workScroll setContentSize:CGSizeMake(workScroll.frame.size.width+1, workScroll.frame.size.height)];
        }
        CGRect rect=CGRectZero;
        for (int i=0; i<workArr.count; i++)
        {
            rect=CGRectMake(60*i+10*(i+1), 10, 60, 60);
            UIImageView * workImage = [[UIImageView alloc] initWithFrame:rect];
            [workImage setImageWithURL:[[workArr objectAtIndex:i] objectForKey:@"work_image"]];
            UIButton *newvideobutton=[UIButton buttonWithType:UIButtonTypeCustom];
            newvideobutton.backgroundColor=[UIColor clearColor];
            newvideobutton.tag=i;
            [newvideobutton addTarget:self  action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
            [newvideobutton setFrame:rect];
            [workScroll addSubview:workImage];
            [workScroll addSubview:newvideobutton];
        }
    }
    
    
    for (UIView* _sub in saveScroll.subviews)
    {
        //        if ([_sub isKindOfClass:[AllAroundPullView class]]) {
        //            continue;
        //        }
        [_sub removeFromSuperview];
    }
    
    if (saveArr.count>0)
    {
        [saveScroll setContentSize:CGSizeMake(workArr.count*(60+10), 60)];
        if (saveScroll.contentSize.width<saveScroll.frame.size.width)
        {
            [saveScroll setContentSize:CGSizeMake(saveScroll.frame.size.width+1, saveScroll.frame.size.height)];
        }
        CGRect rect=CGRectZero;
        for (int i=0; i<workArr.count; i++)
        {
            rect=CGRectMake(90*i+13*(i+1),3, 90, 100);
            UIImageView * workImage = [[UIImageView alloc] initWithFrame:rect];
            [workImage setImageWithURL:[[workArr objectAtIndex:i] objectForKey:@"work_image"]];
            UIButton *newvideobutton=[UIButton buttonWithType:UIButtonTypeCustom];
            newvideobutton.backgroundColor=[UIColor clearColor];
            newvideobutton.tag=i;
            [newvideobutton addTarget:self  action:@selector(selectSaveImage:) forControlEvents:UIControlEventTouchUpInside];
            [newvideobutton setFrame:rect];
            [saveScroll addSubview:workImage];
            [saveScroll addSubview:newvideobutton];
        }
    }

    
    [fatherController refreashNav:concerStr];//设置是否关注
    
    
    
}
-(void)selectImage:(UIButton*)button
{
    scanView=nil;
    scanView = [[scanImageViewController alloc] init];
    scanView.uid=[infoDic objectForKey:@"uid"];
    scanView.worksOrsave = @"works";
    [fatherController pushToViewController:scanView];
}

-(void)selectSaveImage:(UIButton*)button
{
    scanView=nil;
    scanView = [[scanImageViewController alloc] init];
    scanView.uid=[infoDic objectForKey:@"uid"];
    scanView.worksOrsave = @"works";
    [fatherController pushToViewController:scanView];
}


- (IBAction)bespeakDresserClick:(id)sender//私聊
{
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


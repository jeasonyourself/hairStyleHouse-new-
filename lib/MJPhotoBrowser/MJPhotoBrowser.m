//
//  MJPhotoBrowser.m
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.

#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "SBJson.h"
#import "SDWebImageManager+MJ.h"
#import "MJPhotoView.h"
#import "MJPhotoToolbar.h"
#import "commentViewController.h"
#define kPadding 10
#define kPhotoViewTagOffset 1000
#define kPhotoViewIndex(photoView) ([photoView tag] - kPhotoViewTagOffset)

@interface MJPhotoBrowser () <MJPhotoViewDelegate>
{
    // 滚动的view
	UIScrollView *_photoScrollView;
    // 所有的图片view
	NSMutableSet *_visiblePhotoViews;
    NSMutableSet *_reusablePhotoViews;
    // 工具条
    MJPhotoToolbar *_toolbar;
    
    // 一开始的状态栏
    BOOL _statusBarHiddenInited;
}
@end

@implementation MJPhotoBrowser

#pragma mark - Lifecycle
- (void)loadView
{
    _statusBarHiddenInited = [UIApplication sharedApplication].isStatusBarHidden;
    // 隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    self.view = [[UIView alloc] init];
    self.view.frame =[UIScreen mainScreen].bounds;
//    self.view.frame = CGRectMake([UIScreen mainScreen].bounds.origin.x, [UIScreen mainScreen].bounds.origin.y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-self.navigationController.navigationBar.frame.size.height);
	self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self refreashNavLab];
    [self refreashNav];
    self.view.backgroundColor= [UIColor colorWithRed:220.0/256.0 green:220.0/256.0 blue:220.0/256.0 alpha:1.0];
    subView = [[UIControl alloc] initWithFrame:self.view.frame];
    [subView addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    subView.backgroundColor =[UIColor clearColor];
    
    alphaView = [[UIControl alloc] initWithFrame:CGRectMake(self.view.center.x-130, self.view.center.y-180, 260, 340)];
    [alphaView addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    alphaView.backgroundColor =[UIColor blackColor];
    alphaView.alpha =0.5;
    [subView addSubview:alphaView];
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-120, self.view.center.y-170, 240, 30)];
    titleLable.font = [UIFont systemFontOfSize:15.0];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.text = @"请填写你对此款发型的时长和价格";
    [subView addSubview:titleLable];
    
    UILabel * secondTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-120, self.view.center.y-145, 240, 30)];
    secondTitleLable.font = [UIFont systemFontOfSize:15.0];
    secondTitleLable.textColor = [UIColor whiteColor];
    secondTitleLable.text = @"（仅供参考）";
    [subView addSubview:secondTitleLable];
    
    UILabel * severTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-120, self.view.center.y-90, 200, 30)];
    severTimeLable.font = [UIFont systemFontOfSize:15.0];
    severTimeLable.textColor = [UIColor whiteColor];
    severTimeLable.text = @"服务时间：               小时";
    [subView addSubview:severTimeLable];
    
    severTime = [[UITextField alloc] initWithFrame:CGRectMake(self.view.center.x-40, self.view.center.y-86, 50, 22)];
    severTime.delegate = self;
    severTime.keyboardType = UIKeyboardTypeNumberPad;

    severTime.backgroundColor=[UIColor whiteColor];
    severTime.borderStyle = UITextBorderStyleRoundedRect;
    severTime.font = [UIFont systemFontOfSize:15.0];
    severTime.textAlignment = NSTextAlignmentCenter;

    severTime.layer.cornerRadius = 5;//设置那个圆角的有多圆
    severTime.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    severTime.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    severTime.layer.masksToBounds = YES;//设为NO去试试
    [subView addSubview:severTime];
    
    UILabel * severPriceLable = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-120, self.view.center.y-50, 200, 30)];
    severPriceLable.font = [UIFont systemFontOfSize:15.0];
    severPriceLable.textColor = [UIColor whiteColor];
    severPriceLable.text = @"服务价格：               元";
    [subView addSubview:severPriceLable];
    
    severPrice = [[UITextField alloc] initWithFrame:CGRectMake(self.view.center.x-40, self.view.center.y-46, 50, 22)];
    severPrice.delegate=self;
    severPrice.keyboardType = UIKeyboardTypeNumberPad;
    severPrice.textAlignment = NSTextAlignmentCenter;
    severPrice.backgroundColor=[UIColor whiteColor];
    severPrice.font = [UIFont systemFontOfSize:15.0];
    severPrice.borderStyle = UITextBorderStyleRoundedRect;
    severPrice.layer.cornerRadius = 5;//设置那个圆角的有多圆
    severPrice.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    severPrice.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    severPrice.layer.masksToBounds = YES;//设为NO去试试
    [subView addSubview:severPrice];
    
    
    UILabel * saleLable1 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-120, self.view.center.y-10, 200, 30)];
    saleLable1.font = [UIFont systemFontOfSize:15.0];
    saleLable1.textColor = [UIColor whiteColor];
    saleLable1.text = @"优惠折扣：               折";
    [subView addSubview:saleLable1];
    
    saleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-40, self.view.center.y-6, 50, 22)];
    saleLable.backgroundColor=[UIColor whiteColor];
    saleLable.font = [UIFont systemFontOfSize:15.0];
    saleLable.text =@"9.5";
    saleLable.textAlignment = NSTextAlignmentCenter;
    saleLable.layer.cornerRadius = 5;//设置那个圆角的有多圆
    saleLable.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    saleLable.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    saleLable.layer.masksToBounds = YES;//设为NO去试试
    
    
    saleButton=[[UIButton alloc] init];
    saleButton.tag =1;
    saleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saleButton.layer setMasksToBounds:YES];
    [saleButton.layer setCornerRadius:5.0];
    
    [saleButton setBackgroundColor:[UIColor clearColor]];
    
    [saleButton addTarget:self action:@selector(saleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    saleButton.frame = saleLable.frame;
    
    [subView addSubview:saleButton];
    [subView addSubview:saleLable];
    
    UILabel * reallLable1 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-120, self.view.center.y+30, 240, 30)];
    reallLable1.font = [UIFont systemFontOfSize:15.0];
    reallLable1.textColor = [UIColor whiteColor];
    reallLable1.text = @"实际价格：";
    [subView addSubview:reallLable1];
    
    reallPriceLable = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-40, self.view.center.y+30, 200, 30)];
    reallPriceLable.font = [UIFont systemFontOfSize:15.0];
    reallPriceLable.textColor = [UIColor whiteColor];
    reallPriceLable.text = @"  --  元";
    [subView addSubview:reallPriceLable];
    
    saleArr = [[NSMutableArray alloc] initWithObjects:@"9.5",@"9",@"8.5",@"8",@"7.5",@"7",@"6.5",@"6",@"5.5",@"5",@"4.5",@"4",@"3.5",@"3",@"2.5",@"2",@"1.5",@"1",@"0.5", nil];
    
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(saleButton.frame.origin.x, saleButton.frame.origin.y+saleButton.frame.size.height, saleButton.frame.size.width, saleButton.frame.size.height*2+10) style:UITableViewStylePlain];
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.hidden = YES;
    myTableView.layer.cornerRadius = 5;//设置那个圆角的有多圆
    myTableView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    myTableView.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    myTableView.layer.masksToBounds = YES;//设为NO去试试
    myTableView.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [subView addSubview:myTableView];
    
    
    
   
    
    
    sureButton=[[UIButton alloc] init];
    sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureButton.layer setMasksToBounds:YES];
    [sureButton.layer setCornerRadius:5.0];
    [sureButton.layer setBorderWidth:1.0];
    [sureButton setBackgroundColor:[UIColor colorWithRed:244.0/256.0 green:22.0/256.0 blue:96.0/256.0 alpha:1.0]];
    [sureButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [QQButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    sureButton.frame = CGRectMake(self.view.center.x-120, self.view.center.y+90, 100, 30);
    
    
    cancelButton=[[UIButton alloc] init];
    cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton.layer setMasksToBounds:YES];
    [cancelButton.layer setCornerRadius:5.0];
    [cancelButton.layer setBorderWidth:1.0];
    [cancelButton setBackgroundColor:[UIColor colorWithRed:172.0/256.0 green:172.0/256.0 blue:172.0/256.0 alpha:1.0]];
    [cancelButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [sinaButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.frame = CGRectMake(self.view.center.x+20, self.view.center.y+90, 100, 30);
    
    [subView addSubview:sureButton];
    [subView addSubview:cancelButton];

    // 1.创建UIScrollView
    [self createScrollView];
    
    // 2.创建工具条
    first = [[NSString alloc] init];
    first  = @"first";
    [self createToolbar];
}
-(void)viewDidAppear:(BOOL)animated
{
    
}
-(IBAction)textFiledReturnEditing:(id)sender {
    
    
}
- (void)touchDown
{
    [severPrice resignFirstResponder];
    [severTime resignFirstResponder];
}

#pragma mark -textField 代理

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    saleButton.tag=1;
    myTableView.hidden=YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    if(textField == severPrice)
    {
        NSString *tmpStr = @"" ;
        tmpStr = textField.text ;
        tmpStr = [tmpStr stringByReplacingCharactersInRange:range withString:string];
        
        NSInteger oldInt= [tmpStr integerValue];
        float saleInt= [saleLable.text floatValue]/10;
        float nowInt = oldInt*saleInt;
        reallPriceLable.text = [NSString stringWithFormat:@"%.1lf 元",nowInt];
        return YES;
        
    }
    //其他的类型不需要检测，直接写入
    return YES;
}


-(void)sureButtonClick
{
    
    if([severTime.text isEqualToString:@""]||[severPrice.text isEqualToString:@""]||[saleLable.text isEqualToString:@""])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写完整信息" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Willdo&a=addWillDo"]]];
    
    [request setPostValue:@"1"forKey:@"order_type"];//预约发型为2
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    [request setPostValue:appDele.uid forKey:@"uid"];
        
        MJPhoto *photo = _photos[_currentPhotoIndex];
    [request setPostValue:photo.work_id forKey:@"work_id"];
        
        
        
    
    [request setPostValue:[NSString stringWithFormat:@"%@小时",severTime.text] forKey:@"long_service"];
    [request setPostValue:severPrice.text forKey:@"price"];
    
    [request setPostValue:saleLable.text forKey:@"rebate"];
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
    NSLog(@"预约添加会做是否成功dic:%@",dic);
    
    if ([[dic objectForKey:@"code"] isEqualToString:@"101"])
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该作品已添加至您的会做作品" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已添加过该作品" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    }
    [self cancelButtonClick];

}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"预约失败" message:@"网络连接失败" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)cancelButtonClick
{
    [subView removeFromSuperview];
}

-(void)saleButtonClick
{
    [self touchDown];
    
    if (saleButton.tag==1) {
        myTableView.hidden =NO;
        saleButton.tag=2;
    }
    else
    {
        myTableView.hidden =YES;
        saleButton.tag=1;

    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return saleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   myTableView.frame.size.height/2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor =[UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    cell.textLabel.text = [saleArr objectAtIndex:[indexPath row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    saleButton.tag=1;
    saleLable.text=[saleArr objectAtIndex:[indexPath row]];
    myTableView.hidden=YES;
    
    NSInteger oldInt= [severPrice.text integerValue];
    float saleInt= [saleLable.text floatValue]/10;
    float nowInt = oldInt*saleInt;
    reallPriceLable.text = [NSString stringWithFormat:@"%.1lf 元",nowInt];
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    [window.rootViewController addChildViewController:self];

    if (_currentPhotoIndex == 0) {
        [self showPhotos];
    }
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
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [leftButton setBackgroundColor:[UIColor clearColor]];
    [leftButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(0,28, 60, 25);
    UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
}
-(void)refreashNavLab:(NSInteger)currentIndex and:(NSInteger)allCount
{
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 7, 100, 30)];
    Lab.text = [NSString stringWithFormat:@"发型图册(%d / %d)", currentIndex , allCount];
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
//    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
}

#pragma mark - 私有方法
#pragma mark 创建工具条
- (void)createToolbar
{
    
    CGFloat barHeight = 100;
    CGFloat barY = self.view.frame.size.height - barHeight;
    _toolbar=nil;
    _toolbar = [[MJPhotoToolbar alloc] init];
    _toolbar.fatherView =self;
    _toolbar.frame = CGRectMake(0, barY, self.view.frame.size.width, barHeight);
    _toolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _toolbar.photos = _photos;
    [self.view addSubview:_toolbar];
//    [_toolbar getData];

    [self updateTollbarState];
}

#pragma mark 创建UIScrollView
- (void)createScrollView
{
    CGRect frame;
    frame.origin.x -= kPadding;
    frame.size.width += (2 * kPadding);
    NSLog(@"frame11:%@",NSStringFromCGRect(frame));
    
    
    if (_currentPhotoIndex==0)
    {
        frame = self.view.frame;
        
    }
    else//特地为第一次加载图片点击不是第一张图片向下位移设计
    {
        frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-60, self.view.frame.size.width, self.view.frame.size.height);
       sign = [[NSString alloc] initWithFormat:@"do"];
    }
	_photoScrollView = [[UIScrollView alloc] initWithFrame:frame];
	_photoScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_photoScrollView.pagingEnabled = YES;
	_photoScrollView.delegate = self;
	_photoScrollView.showsHorizontalScrollIndicator = NO;
	_photoScrollView.showsVerticalScrollIndicator = NO;
	_photoScrollView.backgroundColor = [UIColor clearColor];
    _photoScrollView.contentSize = CGSizeMake(frame.size.width * _photos.count, 0);
	[self.view addSubview:_photoScrollView];
    _photoScrollView.contentOffset = CGPointMake(_currentPhotoIndex * frame.size.width, 0);
    
    firstContentOffSet=CGPointMake(_currentPhotoIndex * frame.size.width, 0);
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    if (photos.count > 1) {
        _visiblePhotoViews = [NSMutableSet set];
        _reusablePhotoViews = [NSMutableSet set];
    }
    
    for (int i = 0; i<_photos.count; i++) {
        MJPhoto *photo = _photos[i];
        photo.index = i;
        photo.firstShow = i == _currentPhotoIndex;
    }
}

#pragma mark 设置选中的图片
- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex
{
    _currentPhotoIndex = currentPhotoIndex;
    
    for (int i = 0; i<_photos.count; i++) {
        MJPhoto *photo = _photos[i];
        photo.firstShow = i == currentPhotoIndex;
    }
    
    if ([self isViewLoaded]) {
        _photoScrollView.contentOffset = CGPointMake(_currentPhotoIndex * _photoScrollView.frame.size.width, 0);
        
        // 显示所有的相片
        [self showPhotos];
    }
}

#pragma mark - MJPhotoView代理
- (void)photoViewSingleTap:(MJPhotoView *)photoView
{
    [UIApplication sharedApplication].statusBarHidden = _statusBarHiddenInited;
    self.view.backgroundColor = [UIColor clearColor];
    
    // 移除工具条
    [_toolbar removeFromSuperview];
}

- (void)photoViewDidEndZoom:(MJPhotoView *)photoView
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)photoViewImageFinishLoad:(MJPhotoView *)photoView
{
    _toolbar.currentPhotoIndex = _currentPhotoIndex;
}

#pragma mark 显示照片
- (void)showPhotos
{
    // 只有一张图片
    if (_photos.count == 1) {
        [self showPhotoViewAtIndex:0];
        return;
    }
    
    CGRect visibleBounds = _photoScrollView.bounds;
	int firstIndex = (int)floorf((CGRectGetMinX(visibleBounds)+kPadding*2) / CGRectGetWidth(visibleBounds));
	int lastIndex  = (int)floorf((CGRectGetMaxX(visibleBounds)-kPadding*2-1) / CGRectGetWidth(visibleBounds));
    if (firstIndex < 0) firstIndex = 0;
    if (firstIndex >= _photos.count) firstIndex = _photos.count - 1;
    if (lastIndex < 0) lastIndex = 0;
    if (lastIndex >= _photos.count) lastIndex = _photos.count - 1;
	
	// 回收不再显示的ImageView
    NSInteger photoViewIndex;
	for (MJPhotoView *photoView in _visiblePhotoViews) {
        photoViewIndex = kPhotoViewIndex(photoView);
		if (photoViewIndex < firstIndex || photoViewIndex > lastIndex) {
			[_reusablePhotoViews addObject:photoView];
			[photoView removeFromSuperview];
		}
	}
    
	[_visiblePhotoViews minusSet:_reusablePhotoViews];
    while (_reusablePhotoViews.count > 2) {
        [_reusablePhotoViews removeObject:[_reusablePhotoViews anyObject]];
    }
	
	for (NSUInteger index = firstIndex; index <= lastIndex; index++) {
		if (![self isShowingPhotoViewAtIndex:index]) {
			[self showPhotoViewAtIndex:index];
		}
	}
}

#pragma mark 显示一个图片view
- (void)showPhotoViewAtIndex:(int)index
{
    MJPhotoView *photoView = [self dequeueReusablePhotoView];
    if (!photoView) { // 添加新的图片view
        photoView = [[MJPhotoView alloc] init];
        photoView.photoViewDelegate = self;
    }
    
    // 调整当期页的frame
    CGRect bounds = _photoScrollView.bounds;
    CGRect photoViewFrame = bounds;
    photoViewFrame.size.width -= (2 * kPadding);
    photoViewFrame.origin.x = (bounds.size.width * index) + kPadding;
    photoView.tag = kPhotoViewTagOffset + index;
    
    MJPhoto *photo = _photos[index];
    photoView.frame = photoViewFrame;
    photoView.photo = photo;
    
    [_visiblePhotoViews addObject:photoView];
    [_photoScrollView addSubview:photoView];
    
    [self loadImageNearIndex:index];
}

#pragma mark 加载index附近的图片
- (void)loadImageNearIndex:(int)index
{
    if (index > 0) {
        MJPhoto *photo = _photos[index - 1];
        [SDWebImageManager downloadWithURL:photo.url];
    }
    
    if (index < _photos.count - 1) {
        MJPhoto *photo = _photos[index + 1];
        [SDWebImageManager downloadWithURL:photo.url];
    }
}

#pragma mark index这页是否正在显示
- (BOOL)isShowingPhotoViewAtIndex:(NSUInteger)index {
    
    
    
	for (MJPhotoView *photoView in _visiblePhotoViews) {
		if (kPhotoViewIndex(photoView) == index) {
           return YES;
        }
    }
	return  NO;
}

#pragma mark 循环利用某个view
- (MJPhotoView *)dequeueReusablePhotoView
{
    MJPhotoView *photoView = [_reusablePhotoViews anyObject];
	if (photoView) {
		[_reusablePhotoViews removeObject:photoView];
	}
	return photoView;
}

#pragma mark 更新toolbar状态
- (void)updateTollbarState
{
    _currentPhotoIndex = _photoScrollView.contentOffset.x / _photoScrollView.frame.size.width;
    _toolbar.currentPhotoIndex = _currentPhotoIndex;
    if ([first isEqualToString:@"first"])
    {
        first = @"noFirst";
        [_toolbar getData];

    }
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[self showPhotos];
    [self updateTollbarState];
//     [_toolbar getData];
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView //滚动结束处理
{
    CGPoint nowOffSet = _photoScrollView.contentOffset;
    if ([sign isEqualToString:@"do"])//特地为第一次加载图片点击不是第一张图片向下位移设计
    {
        if(nowOffSet.x-firstContentOffSet.x==320||_photoScrollView.contentOffset.x-firstContentOffSet.x==-320)
        {
        _photoScrollView.frame = self.view.frame;
        sign=@"donot";
        }
    }
 [_toolbar getData];
}

-(void)pushViewController:(id)Sen
{
    
    //        loginView.userInteractionEnabled=YES;
    //        [self.view addSubview:loginView];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if (appDele.uid) {
        [self.navigationController pushViewController:Sen animated:YES];
    }
    else
    {
        loginView=nil;
        loginView=[[loginViewController alloc] init];
        loginView._hidden=@"no";
        loginView.view.frame=self.view.bounds;
        [loginView getBack:self andSuc:@selector(getData) andErr:nil];
        [appDele pushToViewController:loginView ];
    }
    
}
-(void)addAlphaView:(NSDictionary*)Dic andTag:(NSInteger)_tag
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if (appDele.uid)
    {
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        if ([appDele.type isEqualToString:@"2"])
        {
            if (_tag==1) {
                beaspeakHairStyle=nil;
                beaspeakHairStyle=[[addBeaspeakHairStyleViewController alloc] init];
                beaspeakHairStyle.inforDic=Dic;
                [appDele pushToViewController:beaspeakHairStyle ];
            }
            else if(_tag==2)
            {
            [self.view addSubview:subView];
            }
        }
        else
        {
            beaspeakHairStyle=nil;
            beaspeakHairStyle=[[addBeaspeakHairStyleViewController alloc] init];
            beaspeakHairStyle.inforDic=Dic;
            [appDele pushToViewController:beaspeakHairStyle ];
        }
    }
    else
    {
        loginView=nil;
        loginView=[[loginViewController alloc] init];
        loginView._hidden=@"no";
        loginView.view.frame=self.view.bounds;
        [loginView getBack:self andSuc:@selector(getData) andErr:nil];
        [appDele pushToViewController:loginView ];
    }

}

-(void)getData
{
    [_toolbar getData];
}

@end
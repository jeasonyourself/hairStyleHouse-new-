//
//  beaspeakCellAgain.m
//  hairStyleHouse
//
//  Created by jeason on 14-1-17.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import "beaspeakCellAgain.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+MJWebCache.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "beaspeakViewController.h"
@implementation beaspeakCellAgain
@synthesize fatherView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        headImage = [[UIImageView alloc] init];
        
        
        nameLable = [[UILabel alloc] init];
        nameLable.font=[UIFont systemFontOfSize:12];
        
        
//        mobileLable = [[UILabel alloc] init];
        mobileLable.font=[UIFont systemFontOfSize:12];
        
        typeLable = [[UILabel alloc] init];
        typeLable.font=[UIFont systemFontOfSize:12];
        
        timeLable = [[UILabel alloc] init];
        timeLable.font=[UIFont systemFontOfSize:12];
        
        statusLable = [[UILabel alloc] init];
        statusLable.font=[UIFont systemFontOfSize:12];
        
        orderId=[[NSString alloc] init];
        uid=[[NSString alloc] init];
        //        [self addSubview:firstView];
        
        [self addSubview:headImage];
        [self addSubview:nameLable];
        [self addSubview:typeLable];
        [self addSubview:mobileLable];
        [self addSubview:timeLable];
        [self addSubview:statusLable];
        
        
        
        
        
        nameLable1 = [[UILabel alloc] init];
        nameLable1.font=[UIFont systemFontOfSize:12];
        
        
        mobileLable1 = [[UILabel alloc] init];
        mobileLable1.font=[UIFont systemFontOfSize:12];
        
        typeLable1 = [[UILabel alloc] init];
        typeLable1.font=[UIFont systemFontOfSize:12];
        
        timeLable1 = [[UILabel alloc] init];
        timeLable1.font=[UIFont systemFontOfSize:12];
        
        priceLable= [[UILabel alloc] init];
        priceLable.font=[UIFont systemFontOfSize:12];
        
        picImage = [[UIImageView alloc] init];
        
        
        storeNameLabel1=[[UILabel alloc] init];
        storeNameLabel1.font=[UIFont systemFontOfSize:12];;
        
       
        statusLable1=[[UILabel alloc] init];
         statusLable1.backgroundColor=[UIColor clearColor];
        statusLable1.textAlignment =NSTextAlignmentCenter;

        statusLable1.font=[UIFont systemFontOfSize:16];;
        
        storeAddressLable1=[[UILabel alloc] init];
        storeAddressLable1.font=[UIFont systemFontOfSize:12];
        
        statusView1=[[UIImageView alloc] init];
        
        lookButton1=[[UIButton alloc] init];
        lookButton1.titleLabel.font=[UIFont systemFontOfSize:12.0];
        
        changeButton1=[[UIButton alloc] init];
        changeButton1.titleLabel.font=[UIFont systemFontOfSize:14.0];;
        
//        [self addSubview:secondView];
        lookButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        lookButton1.backgroundColor = [UIColor clearColor];
        [lookButton1 setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
        lookButton1.layer.cornerRadius = 5;//设置那个圆角的有多圆
        lookButton1.layer.borderWidth =0;//设置边框的宽度，当然可以不要
        lookButton1.layer.borderColor = [[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        lookButton1.layer.masksToBounds = YES;//设为NO去试试
        
        
        changeButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        changeButton1.backgroundColor = [UIColor clearColor];
        [changeButton1 setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
        changeButton1.layer.cornerRadius = 5;//设置那个圆角的有多圆
        changeButton1.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        changeButton1.layer.borderColor = [[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        changeButton1.layer.masksToBounds = YES;//设为NO去试试

        
        
        [self addSubview:nameLable1];
        [self addSubview:typeLable1];
//        [self addSubview:mobileLable1];
        [self addSubview:timeLable1];
        [self addSubview:priceLable];
        [self addSubview:picImage];
        
        [self addSubview:storeNameLabel1];
        [self addSubview:storeAddressLable1];
        [self addSubview:statusView1];
        [self addSubview:statusLable1];
        [self addSubview:lookButton1];
        [self addSubview:changeButton1];
    }
    return self;
}


-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index//列表
{
    NSString * headStr= [dic objectForKey:@"head_photo"];
    
    NSString * nameStr = [dic objectForKey:@"to_name"];
    NSString * cityStr = [dic objectForKey:@"to_tel"];
    NSString * typeStr = [dic objectForKey:@"reserve_type"];
    NSString * timeStr = [dic objectForKey:@"reserve_time"];
//    NSString * hourStr = [dic objectForKey:@"reserve_hour"];
    NSString * statusStr = [dic objectForKey:@"status"];
    
    [headImage setImageWithURL:[NSURL URLWithString:headStr]];
    nameLable.text=nameStr;
    mobileLable.text =[NSString stringWithFormat:@"手机号码:%@",cityStr];
    typeLable.text = [NSString stringWithFormat:@"预约类型:%@",typeStr];
    timeLable.text =[NSString stringWithFormat:@"%@",timeStr];
    if ([statusStr isEqualToString:@"0"]) {
        statusLable.text = @"用户取消";
        
    }
    else if ([statusStr isEqualToString:@"1"]) {
        statusLable.text = @"进行中";
        
    }
    else if ([statusStr isEqualToString:@"2"]) {
        statusLable.text = @"已完成，未评价";
        
    }
    else if ([statusStr isEqualToString:@"3"]) {
        statusLable.text = @"发型师取消";
        
    }
    else if ([statusStr isEqualToString:@"4"]) {
        statusLable.text = @"已完成，已评价";
        
    }
    
    //    firstView.frame = self.frame;
    headImage.frame = CGRectMake(10, 10, 60, 60);
    nameLable.frame = CGRectMake(80, 25, 200, 15);
    mobileLable.frame = CGRectMake(80, 35, 200, 15);
    typeLable.frame = CGRectMake(80, 50, 200, 15);
    timeLable.frame = CGRectMake(10, 75, 200, 20);
    statusLable.textAlignment =NSTextAlignmentCenter;
    statusLable.frame = CGRectMake(220,75, 100, 20);
    
    
    
    nameLable1.frame = CGRectMake(0, 0, 0, 0);
    mobileLable1.frame = CGRectMake(0, 0, 0, 0);
    nameLable1.frame = CGRectMake(0, 0, 0, 0);
    storeNameLabel1.frame= CGRectMake(0, 0, 0, 0);

    storeAddressLable1.frame= CGRectMake(0, 0, 0, 0);

    typeLable1.frame = CGRectMake(0, 0, 0, 0);

    timeLable1.frame = CGRectMake(0, 0, 0, 0);

    priceLable.frame = CGRectMake(0, 0, 0, 0);

    lookButton1.frame= CGRectMake(0, 0, 0, 0);

    changeButton1.frame= CGRectMake(0, 0, 0, 0);

    typeLable1.frame = CGRectMake(0, 0, 0, 0);
    timeLable1.frame = CGRectMake(0, 0, 0, 0);
    priceLable.frame = CGRectMake(0,0, 0, 0);
    statusLable1.frame = CGRectMake(0,0, 0, 0);
    statusView1.frame = CGRectMake(0,0, 0, 0);
    picImage.frame = CGRectMake(0,0, 0, 0);

    //    secondView.frame=CGRectMake(0, 0, 0, 0);
}

-(void)setCell1:(NSDictionary *)dic andIndex:(NSInteger)index//当前预约
{
    orderId = [dic objectForKey:@"id"];
    uid=[dic objectForKey:@"to_uid"];
    NSString * nameStr = [dic objectForKey:@"to_name"];
    NSString * storeStr = [dic objectForKey:@"store_name"];
    NSString * storeAddress = [dic objectForKey:@"store_address"];
    NSString *stateString=[dic objectForKey:@"status"];
    
//    NSString * cityStr = [dic objectForKey:@"to_tel"];
    NSString * orderStr = [dic objectForKey:@"order_type"];
    NSString * typeStr = [dic objectForKey:@"reserve_type"];
    NSString * imageStr= [dic objectForKey:@"image_path"];
    NSString * timeStr = [dic objectForKey:@"reserve_time"];
//    NSString * hourStr = [dic objectForKey:@"reserve_hour"];
    NSString * priceStr = [dic objectForKey:@"reserve_price"];
    
    
    
    nameLable1.text=[NSString stringWithFormat:@"发型师名称:  %@",nameStr];
    storeNameLabel1.text=[NSString stringWithFormat:@"沙龙名称:  %@",storeStr];
    storeAddressLable1.text=[NSString stringWithFormat:@"沙龙地址:  %@",storeAddress];
//    mobileLable1.text =[NSString stringWithFormat:@"手机号码:  %@",cityStr];
    
    
    [lookButton1 addTarget:self action:@selector(lookButton1Click) forControlEvents:UIControlEventTouchUpInside];
    [changeButton1 addTarget:self action:@selector(changeButton1Click:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([orderStr isEqualToString:@"1"])
    {
        typeLable1.text = [NSString stringWithFormat:@"预约项目: %@",typeStr];
        timeLable1.text =[NSString stringWithFormat:@"预约时间:  %@",timeStr];
        priceLable.text =[NSString stringWithFormat:@"价格： ￥%@元",priceStr];
        
        nameLable1.frame = CGRectMake(10, 15, 200, 15);
        storeNameLabel1.frame= CGRectMake(10, 55, 200, 15);
        storeAddressLable1.frame= CGRectMake(10, 95, 200, 15);
//        storeNameLabel1.frame= CGRectMake(10, 55, 200, 15);
//        mobileLable1.frame = CGRectMake(10, 45, 200, 15);
        
        typeLable1.frame = CGRectMake(10, 135, 200, 15);
        timeLable1.frame = CGRectMake(10, 215, 200, 20);
//        priceLable.textAlignment =NSTextAlignmentCenter;
        priceLable.frame = CGRectMake(10,175, 100, 20);
        picImage.frame = CGRectMake(0,0, 0, 0);
        
        
        [lookButton1 setTitle:@"查看TA" forState:UIControlStateNormal];
        lookButton1.frame= CGRectMake(250, 10, 60, 30);
        if ([stateString isEqualToString:@"0"])
        {
//            [changeButton1 setTitle:@"取消预约" forState:UIControlStateNormal];
            changeButton1.frame= CGRectMake(0, 0, 0, 0);
        }
        else if ([stateString isEqualToString:@"1"])
        {
            [changeButton1 setTitle:@"取消预约" forState:UIControlStateNormal];
            changeButton1.frame= CGRectMake(20, 290, 280, 40);
            changeButton1.tag=1;
            [statusView1 setImage:[UIImage imageNamed:@"xuxiankuang1.png"]];
            statusView1.frame= CGRectMake(230, 130, 80, 40);
            statusLable1.text=@"进行中";
            statusLable1.frame =CGRectMake(230, 130, 80, 40);
            statusLable1.textColor=[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0];
        }
        else if ([stateString isEqualToString:@"2"])
        {
            changeButton1.frame= CGRectMake(0, 0, 0, 0);
        }
        else if ([stateString isEqualToString:@"3"])
        {
            changeButton1.frame= CGRectMake(0, 0, 0, 0);
        }
        else if ([stateString isEqualToString:@"4"])
        {
            changeButton1.frame= CGRectMake(0, 0, 0, 0);
        }
        else if ([stateString isEqualToString:@"5"])
        {
            [changeButton1 setTitle:@"已完成，去评价" forState:UIControlStateNormal];
            changeButton1.frame= CGRectMake(20, 290, 280, 40);
            changeButton1.tag=5;
            [statusView1 setImage:[UIImage imageNamed:@"xuxiankuang1.png"]];
            statusView1.frame= CGRectMake(230, 130, 80, 40);
            statusLable1.text=@"发型师已接受";
            statusLable1.frame =CGRectMake(230, 130, 80, 40);
            statusLable1.textColor=[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0];
        }
        
        
    }
    else if([orderStr isEqualToString:@"2"])
    {
        typeLable1.text = [NSString stringWithFormat:@"预约类型: %@",typeStr];
        timeLable1.text =[NSString stringWithFormat:@"预约时间:  %@",timeStr];
        priceLable.text =[NSString stringWithFormat:@"价格： ￥%@元",priceStr];
        
        nameLable1.frame = CGRectMake(10, 15, 200, 15);
        storeNameLabel1.frame= CGRectMake(10, 55, 200, 15);
        storeAddressLable1.frame= CGRectMake(10, 95, 200, 15);
        //        storeNameLabel1.frame= CGRectMake(10, 55, 200, 15);
        //        mobileLable1.frame = CGRectMake(10, 45, 200, 15);
        
        typeLable1.frame = CGRectMake(10, 135, 200, 15);
        timeLable1.frame = CGRectMake(10, 215, 200, 20);
        //        priceLable.textAlignment =NSTextAlignmentCenter;
        priceLable.frame = CGRectMake(10,175, 150, 20);
        picImage.frame = CGRectMake(75,270, 150, 200);
        UIImage *placeholder = [UIImage imageNamed:@"timeline_image_loading.png"];

         [picImage setImageURLStr:imageStr placeholder:placeholder];
        
        [lookButton1 setTitle:@"查看TA" forState:UIControlStateNormal];
        lookButton1.frame= CGRectMake(250, 10, 60, 30);
        if ([stateString isEqualToString:@"0"])
        {
            //            [changeButton1 setTitle:@"取消预约" forState:UIControlStateNormal];
            changeButton1.frame= CGRectMake(0, 0, 0, 0);
        }
        else if ([stateString isEqualToString:@"1"])
        {
            [changeButton1 setTitle:@"取消预约" forState:UIControlStateNormal];
            changeButton1.frame= CGRectMake(20, 510, 280, 40);
            changeButton1.tag=1;
            [statusView1 setImage:[UIImage imageNamed:@"xuxiankuang1.png"]];
            statusView1.frame= CGRectMake(230, 130, 80, 40);
            statusLable1.text=@"进行中";
            statusLable1.frame =CGRectMake(230, 130, 80, 40);
            statusLable1.textColor=[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0];
        }
        else if ([stateString isEqualToString:@"2"])
        {
            changeButton1.frame= CGRectMake(0, 0, 0, 0);
        }
        else if ([stateString isEqualToString:@"3"])
        {
            changeButton1.frame= CGRectMake(0, 0, 0, 0);
        }
        else if ([stateString isEqualToString:@"4"])
        {
            changeButton1.frame= CGRectMake(0, 0, 0, 0);
        }
        else if ([stateString isEqualToString:@"5"])
        {
            [changeButton1 setTitle:@"取消" forState:UIControlStateNormal];
            changeButton1.frame= CGRectMake(20, 510, 280, 40);
            changeButton1.tag=5;
            [statusView1 setImage:[UIImage imageNamed:@"xuxiankuang1.png"]];
            statusView1.frame= CGRectMake(230, 130, 80, 40);
            statusLable1.text=@"已接受";
            statusLable1.frame =CGRectMake(230, 130, 80, 40);
            statusLable1.textColor=[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0];
        }
        

 
    }
    else
    {
        
    }
    
    headImage.frame = CGRectMake(0, 0, 0, 0);
    nameLable.frame = CGRectMake(0, 0, 0, 0);
    mobileLable.frame = CGRectMake(0, 0, 0, 0);
    typeLable.frame = CGRectMake(0, 0, 0, 0);
    timeLable.frame = CGRectMake(0, 0, 0, 0);
    statusLable.textAlignment =NSTextAlignmentCenter;
    statusLable.frame = CGRectMake(0,0, 0, 0);
    
}

-(void)lookButton1Click
{
    NSLog(@"uiduid:%@",uid);
    [fatherView pushDresserView:uid];
    
}
-(void)changeButton1Click:(UIButton*)btn
{
    NSInteger index = btn.tag;
    if (index==1)
    {
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=reserve&a=orderStatus"]];
    request.delegate=self;
    request.tag=1;
    [request setPostValue:appDele.uid forKey:@"uid"];
   
        [request setPostValue:orderId forKey:@"order_id"];
    [request setPostValue:appDele.secret forKey:@"secret"];
    
    
   
         [request setPostValue:@"0" forKey:@"status"];
        [request startAsynchronous];
    }
    
    if (index==5)
    {
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request;
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=reserve&a=orderStatus"]];
        request.delegate=self;
        request.tag=1;
        [request setPostValue:appDele.uid forKey:@"uid"];
        
        [request setPostValue:orderId forKey:@"order_id"];
        [request setPostValue:appDele.secret forKey:@"secret"];
        
        
        
        [request setPostValue:@"0" forKey:@"status"];
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
        NSLog(@"修改状态dic:%@",dic);
        
        if ([[dic objectForKey:@"code"] isEqualToString:@"101"])
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"更新预约状态成功" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
            
            statusLable1.text=@"已取消";
            [changeButton1 setTitle:@"已取消" forState:UIControlStateNormal];
            changeButton1.tag=100;
        }
        else
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"更新预约状态失败" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

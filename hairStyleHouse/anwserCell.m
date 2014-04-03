//
//  anwserCell.m
//  hairStyleHouse
//
//  Created by jeason on 14-4-1.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import "anwserCell.h"
#import "anwserCenterViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
@implementation anwserCell
@synthesize fatherView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        headImage = [[UIImageView alloc] init];
//        [headImage setBackgroundColor:[UIColor clearColor]];
        headImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
        headImage.layer.borderWidth =0;//设置边框的宽度，当然可以不要
//        headImage.layer.borderColor = [[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        anwserButton.layer.masksToBounds = YES;//设为NO去试试
        nameLable = [[UILabel alloc] init];
        nameLable.font=[UIFont systemFontOfSize:12];
        contentLable = [[UILabel alloc] init];
        contentLable.font=[UIFont systemFontOfSize:12];
        timeLable = [[UILabel alloc] init];
        timeLable.font=[UIFont systemFontOfSize:12];
        distanceLable = [[UILabel alloc] init];
        distanceLable.font=[UIFont systemFontOfSize:12];
        anwserNumLable = [[UILabel alloc] init];
        anwserNumLable.font=[UIFont systemFontOfSize:12];
        
        anwserButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [anwserButton addTarget:self action:@selector(anwserButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [anwserButton setTitle:@"我来回答" forState:UIControlStateNormal];
        anwserButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [anwserButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
        [anwserButton setBackgroundColor:[UIColor clearColor]];
        anwserButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
        anwserButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        anwserButton.layer.borderColor = [[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        anwserButton.layer.masksToBounds = YES;//设为NO去试试
        
        [self addSubview:headImage];
        [self addSubview:nameLable];
        [self addSubview:contentLable];
        [self addSubview:timeLable];
        [self addSubview:anwserButton];
        [self addSubview:anwserNumLable];
        

    }
    return self;
}
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index
{
    NSString * headStr= [dic objectForKey:@"head_photo"];
    NSString * nameStr = [dic objectForKey:@"username"];
    NSString * contentStr = [dic objectForKey:@"content"];
    NSString * timeStr = [dic objectForKey:@"add_time"];
    NSString * anwserNumStr = [dic objectForKey:@"answer"];
    [headImage setImageWithURL:[NSURL URLWithString:headStr]];
    nameLable.text=nameStr;
    contentLable.text =contentStr;
    timeLable.text = timeStr;
    anwserNumLable.text = [NSString stringWithFormat:@"回答数：%@",anwserNumStr];
    headImage.frame = CGRectMake(10, 10, 80, 80);
    nameLable.frame = CGRectMake(100, 15, 100, 15);
    contentLable.frame = CGRectMake(100, 30, 150, 35);
    contentLable.numberOfLines=0;
    timeLable.frame = CGRectMake(250, 15, 80, 15);
    anwserNumLable.frame=CGRectMake(100, 70, 100, 20);
    
    anwserButton.frame = CGRectMake(250, 60, 60, 30);
    anwserButton.tag=index;

}

-(void)setCell1:(NSDictionary *)dic andIndex:(NSInteger)index
{
    NSString * headStr= [dic objectForKey:@"head_photo"];
    NSString * nameStr = [dic objectForKey:@"ta_name"];
    NSString * contentStr = [dic objectForKey:@"content"];
    NSString * timeStr = [dic objectForKey:@"add_time"];
    [headImage setImageWithURL:[NSURL URLWithString:headStr]];
    nameLable.text=nameStr;
    contentLable.text =contentStr;
    timeLable.text = timeStr;
    headImage.frame = CGRectMake(10, 10, 80, 80);
    nameLable.frame = CGRectMake(100, 15, 100, 15);
    contentLable.frame = CGRectMake(100, 30, 150, 35);
    contentLable.numberOfLines=0;
    timeLable.frame = CGRectMake(250, 15, 80, 15);
    anwserNumLable.frame=CGRectMake(100, 70, 100, 20);

    anwserButton.frame = CGRectMake(250, 60, 60, 30);
    anwserButton.tag=index;
}

-(void)setCell2:(NSDictionary *)dic andIndex:(NSInteger)index
{
    NSString * headStr= [dic objectForKey:@"head_photo"];
    NSString * nameStr = [dic objectForKey:@"ta_name"];
    NSString * contentStr = [dic objectForKey:@"content"];
    NSString * timeStr = [dic objectForKey:@"add_time"];
    NSString * anwserNumStr = [dic objectForKey:@"answer"];
    [headImage setImageWithURL:[NSURL URLWithString:headStr]];
    nameLable.text=nameStr;
    contentLable.text =contentStr;
    timeLable.text = timeStr;
    headImage.frame = CGRectMake(0, 0, 0, 0);
    nameLable.frame = CGRectMake(0, 0, 0, 0);
    contentLable.frame = CGRectMake(30, 10, 180, 40);
    contentLable.numberOfLines=0;
    timeLable.frame = CGRectMake(220, 55, 80, 20);
    anwserNumLable.frame=CGRectMake(30, 55, 100, 20);
    anwserNumLable.text = [NSString stringWithFormat:@"回答数：%@",anwserNumStr];
    anwserButton.frame = CGRectMake(0, 0, 0, 0);
    anwserButton.tag=index;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)anwserButtonClick:(UIButton *)_btn
{
    [fatherView anwserQ:_btn.tag];
}
@end

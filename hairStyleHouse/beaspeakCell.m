//
//  beaspeakCell.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "beaspeakCell.h"
#import "UIImageView+WebCache.h"
@implementation beaspeakCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        headImage = [[UIImageView alloc] init];
        
        
        nameLable = [[UILabel alloc] init];
        nameLable.font=[UIFont systemFontOfSize:12];
        
        
        mobileLable = [[UILabel alloc] init];
        mobileLable.font=[UIFont systemFontOfSize:12];
        
        typeLable = [[UILabel alloc] init];
        typeLable.font=[UIFont systemFontOfSize:12];
        
        timeLable = [[UILabel alloc] init];
        timeLable.font=[UIFont systemFontOfSize:12];
        
        statusLable = [[UILabel alloc] init];
        statusLable.font=[UIFont systemFontOfSize:12];
        
        [self addSubview:headImage];
        [self addSubview:nameLable];
        [self addSubview:typeLable];
        [self addSubview:mobileLable];
        [self addSubview:timeLable];
        [self addSubview:statusLable];
        // Initialization code
    }
    return self;
}
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index
{
    NSString * headStr= [dic objectForKey:@"head_photo"];
    NSString * nameStr = [dic objectForKey:@"my_name"];
    NSString * cityStr = [dic objectForKey:@"my_tel"];
    NSString * typeStr = [dic objectForKey:@"reserve_type"];
    NSString * timeStr = [dic objectForKey:@"reserve_time"];
     NSString * hourStr = [dic objectForKey:@"reserve_hour"];
    NSString * statusStr = [dic objectForKey:@"status"];
    
    [headImage setImageWithURL:[NSURL URLWithString:headStr]];
    nameLable.text=nameStr;
    mobileLable.text =[NSString stringWithFormat:@"手机号码:%@",cityStr];
    typeLable.text = [NSString stringWithFormat:@"预约类型:%@",typeStr];
    timeLable.text =[NSString stringWithFormat:@"%@%@",timeStr,hourStr];
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
    
    
    headImage.frame = CGRectMake(10, 10, 60, 60);
    nameLable.frame = CGRectMake(80, 15, 200, 15);
    mobileLable.frame = CGRectMake(80, 35, 200, 15);
    typeLable.frame = CGRectMake(80, 55, 200, 15);
    timeLable.frame = CGRectMake(10, 75, 200, 20);
    statusLable.textAlignment =NSTextAlignmentCenter;
    statusLable.frame = CGRectMake(220,75, 100, 20);

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

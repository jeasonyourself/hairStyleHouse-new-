//
//  fansAndfoceAndMassegeCell.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "fansAndfoceAndMassegeCell.h"
#import "UIImageView+WebCache.h"
@implementation fansAndfoceAndMassegeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        headImage = [[UIImageView alloc] init];
        
        
        nameLable = [[UILabel alloc] init];
        nameLable.font=[UIFont systemFontOfSize:12];
        
        
        cityLable = [[UILabel alloc] init];
        cityLable.font=[UIFont systemFontOfSize:12];
       

        timeLable = [[UILabel alloc] init];
        timeLable.font=[UIFont systemFontOfSize:12];
        
        [self addSubview:headImage];
        [self addSubview:nameLable];
        [self addSubview:cityLable];
        [self addSubview:timeLable];
        // Initialization code
    }
    return self;
}

-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index
{
    NSString * headStr= [dic objectForKey:@"head_photo"];
    NSString * nameStr = [dic objectForKey:@"username"];
    NSString * cityStr = [dic objectForKey:@"address"];
    
    [headImage setImageWithURL:[NSURL URLWithString:headStr]];
    nameLable.text=nameStr;
    cityLable.text =cityStr;
    
    headImage.frame = CGRectMake(10, 10, 60, 60);
    nameLable.frame = CGRectMake(80, 15, 200, 20);
    cityLable.frame = CGRectMake(80, 45, 200, 20);
}
-(void)setCell2:(NSDictionary *)dic andIndex:(NSInteger)index
{
    NSString * headStr= [dic objectForKey:@"head_photo"];
    NSString * nameStr = [dic objectForKey:@"ta_name"];
    NSString * cityStr = [dic objectForKey:@"content"];
    NSString * timeStr = [dic objectForKey:@"add_time"];

    [headImage setImageWithURL:[NSURL URLWithString:headStr]];
    nameLable.text=nameStr;
    cityLable.text =cityStr;
    timeLable.text = timeStr;
    
    headImage.frame = CGRectMake(10, 10, 60, 60);
    nameLable.frame = CGRectMake(80, 15, 200, 20);
    cityLable.frame = CGRectMake(80, 45, 200, 20);
    timeLable.frame = CGRectMake(200, 15, 120, 30);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  talkCell.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "talkCell.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
@implementation talkCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         backImage = [[UIImageView alloc] init];
        headImage = [[UIImageView alloc] init];

         picImage = [[UIImageView alloc] init];
        contentLable = [[UILabel alloc] init];
        contentLable.textColor = [UIColor blackColor];
        contentLable.font = [UIFont systemFontOfSize:12.0];
        
        timeLable = [[UILabel alloc] init];
        timeLable.textColor = [UIColor blackColor];
        timeLable.font = [UIFont systemFontOfSize:12.0];
        
        [self addSubview:headImage];
        [self addSubview:backImage];
        [backImage addSubview:contentLable];
        [backImage addSubview:picImage];
        [self addSubview:timeLable];
        // Initialization code
    }
    return self;
}
- (void)bindMessage:(NSDictionary *)_dic and: (NSDictionary *)lastDic
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    if ([[_dic objectForKey:@"from_id"] isEqualToString:appDele.uid])
    {
        [headImage setImageWithURL:[NSURL URLWithString:[lastDic objectForKey:@"my_head_photo"]]];
        headImage.frame=CGRectMake(270, 10, 40, 40);
        
        backImage.image = [UIImage imageNamed:@"other_normal"];
        
        
        // 测试字串
        NSString *_content =[_dic objectForKey:@"content"];
        contentLable.numberOfLines = 0;
        contentLable.text = _content;
        
        NSString *picStr =[_dic objectForKey:@"pic"];
        [picImage setImageWithURL:[NSURL URLWithString:picStr]];
        UIFont *font = [UIFont systemFontOfSize:12.0];
        
        NSString *time =[_dic objectForKey:@"add_time"];
        timeLable.numberOfLines = 0;
        timeLable.text = time;
        //设置一个行高上限
        CGSize size = CGSizeMake(150,2000);
        //计算实际frame大小，并将label的frame变成实际大小
        CGSize labelsize = [_content sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        
        contentLable.frame = CGRectMake(22, 18, labelsize.width, labelsize.height);
        picImage.frame =CGRectMake(20, labelsize.height+28, 150, 200);
        if ([picStr isEqualToString:@""])
        {
            backImage.frame = CGRectMake(self.frame.size.width-60-labelsize.width-50, 10, labelsize.width+50, labelsize.height+40);
        }
        else
        {
            backImage.frame = CGRectMake(self.frame.size.width-60-200, 10, 200, labelsize.height+50+200);
        }
        timeLable.frame = CGRectMake(100,backImage.frame.size.height+10 , 120, 20);
        
        backImage.image = [backImage.image stretchableImageWithLeftCapWidth:backImage.image.size.width*0.5 topCapHeight:backImage.image.size.height*0.6];
        
        
            }
    else
    {
        [headImage setImageWithURL:[NSURL URLWithString:[lastDic objectForKey:@"ta_head_photo"]]];
        headImage.frame=CGRectMake(10, 10, 40, 40);
        
        backImage.image = [UIImage imageNamed:@"mychat_normal"];
        
        // 测试字串
        NSString *_content =[_dic objectForKey:@"content"];
        contentLable.numberOfLines = 0;
        contentLable.text = _content;
        
        NSString *picStr =[_dic objectForKey:@"pic"];
        [picImage setImageWithURL:[NSURL URLWithString:picStr]];
        UIFont *font = [UIFont systemFontOfSize:12.0];
        
        NSString *time =[_dic objectForKey:@"add_time"];
        timeLable.numberOfLines = 0;
        timeLable.text = time;
        //设置一个行高上限
        CGSize size = CGSizeMake(150,2000);
        //计算实际frame大小，并将label的frame变成实际大小
        CGSize labelsize = [_content sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        
        contentLable.frame = CGRectMake(28, 18, labelsize.width, labelsize.height);
        picImage.frame =CGRectMake(30, labelsize.height+28, 150, 200);
        if ([picStr isEqualToString:@""])
        {
            backImage.frame = CGRectMake(60, 10, labelsize.width+50, labelsize.height+40);
        }
        else
        {
            backImage.frame = CGRectMake(60, 10, 200, labelsize.height+50+200);
        }
        timeLable.frame = CGRectMake(100,backImage.frame.size.height+10 , 120, 20);
        backImage.image = [backImage.image stretchableImageWithLeftCapWidth:backImage.image.size.width*0.5 topCapHeight:backImage.image.size.height*0.6];
        

    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  commentCell.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-2.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "commentCell.h"
#import "commentViewController.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
@implementation commentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        picImage  = [[UIImageView alloc] init];
        headBack = [[UIView alloc] init];
        headImage = [[UIImageView alloc] init];
        headButton = [[UIButton alloc] init];
        nameLable= [[UILabel alloc] init];
        contentLable= [[UILabel alloc] init];
        likeScroll= [[UIScrollView alloc] init];
        howMuchLable= [[UILabel alloc] init];
        timeLable= [[UILabel alloc] init];
        
        
        
        [self addSubview:picImage];
        [self addSubview:headBack];
        [self addSubview:headImage];
        [self addSubview:headButton];
        [self addSubview:nameLable];
        [self addSubview:contentLable];
        [self addSubview:likeScroll];
        [self addSubview:howMuchLable];
        [self addSubview:timeLable];

        // Initialization code
    }
    return self;
}
-(void)setFirstCell:(NSDictionary * )_dic andArr:(NSMutableArray *)_arr
{
    NSString* picStr = [[[_dic objectForKey:@"works_info"] objectForKey:@"works_pic"] objectAtIndex:0];
    [picImage setImageWithURL:[NSURL URLWithString:picStr]];
    picImage.frame = CGRectMake(60, 10, 200, 220);

    NSString* headStr = [[_dic objectForKey:@"works_info"] objectForKey:@"head_photo"];
    [headImage setImageWithURL:[NSURL URLWithString:headStr]];
    headImage.frame = CGRectMake(10, 240, 50, 50);
    headButton=[UIButton buttonWithType:UIButtonTypeCustom];
    headButton.backgroundColor=[UIColor clearColor];
    headButton.frame=headImage.frame;
    [headButton addTarget:self  action:@selector(selectHeadImage) forControlEvents:UIControlEventTouchUpInside];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if ([[[_dic objectForKey:@"works_info"] objectForKey:@"uid"] isEqualToString:appDele.uid])
    {
        headButton.userInteractionEnabled=NO;
    }
    else
    {
        headButton.userInteractionEnabled=YES;
    }
    
    NSString* nameStr = [[_dic objectForKey:@"works_info"] objectForKey:@"username"];
    nameLable.text=nameStr;
    nameLable.font = [UIFont systemFontOfSize:12];
    nameLable.frame = CGRectMake(70, 250, 200, 20);
    
    
    
    NSString* contentStr = [[_dic objectForKey:@"works_info"] objectForKey:@"content"];
    contentLable.text=contentStr;
    contentLable.font = [UIFont systemFontOfSize:12];
    contentLable.frame = CGRectMake(70, 270, 200, 20);
    
    for (UIView* _sub in likeScroll.subviews)
    {
        //        if ([_sub isKindOfClass:[AllAroundPullView class]]) {
        //            continue;
        //        }
        [_sub removeFromSuperview];
    }
    
    NSMutableArray * likeArr;
    if ([[_dic objectForKey:@"like_list"] isKindOfClass:[NSString class]])
    {
        
    }
    else if ([[_dic objectForKey:@"like_list"] isKindOfClass:[NSArray class]])
    {
       likeArr = [_dic objectForKey:@"like_list"];
        
    }
    NSLog(@"likeArr:%@",likeArr);

    if (likeArr.count>0)
    {
        [likeScroll setContentSize:CGSizeMake(likeArr.count*(30+10), 30)];
        if (likeScroll.contentSize.width<likeScroll.frame.size.width)
        {
            [likeScroll setContentSize:CGSizeMake(likeScroll.frame.size.width+1, likeScroll.frame.size.height)];
        }
        CGRect rect=CGRectZero;
        for (int i=0; i<likeArr.count; i++)
        {
            rect=CGRectMake(30*i+10*(i+1), 0,30, 30);
            UIImageView * workImage = [[UIImageView alloc] initWithFrame:rect];
            [workImage setImageWithURL:[[likeArr objectAtIndex:i] objectForKey:@"head_photo"]];
            UIButton *newvideobutton=[UIButton buttonWithType:UIButtonTypeCustom];
            newvideobutton.backgroundColor=[UIColor clearColor];
            newvideobutton.tag=i;
            [newvideobutton addTarget:self  action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
            [newvideobutton setFrame:rect];
            [likeScroll addSubview:workImage];
            [likeScroll addSubview:newvideobutton];
        }
    }
    likeScroll.frame = CGRectMake(0, 295, 320, 30);

    if (_arr.count==0)
    {
        howMuchLable.text=@"暂无评论，快给一些评论吧！";
        howMuchLable.font = [UIFont systemFontOfSize:12];
    }
    else
    {
        howMuchLable.text=[NSString stringWithFormat:@"共有%d条评论",_arr.count];
        howMuchLable.font = [UIFont systemFontOfSize:12];
    }
    
    howMuchLable.frame = CGRectMake(10, 330, 200, 20);
    timeLable.frame = CGRectMake(0, 0, 0, 0);


}
-(void)setOtherCell:(NSMutableArray *)_arr and:(NSInteger)_index
{
    picImage.frame = CGRectMake(0, 0, 0, 0);
    NSString* headStr = [[_arr objectAtIndex:_index-1]  objectForKey:@"head_photo"];
    [headImage setImageWithURL:[NSURL URLWithString:headStr]];
    headImage.frame = CGRectMake(5, 5, 50, 50);
    headButton=[UIButton buttonWithType:UIButtonTypeCustom];
    headButton.backgroundColor=[UIColor clearColor];
    headButton.frame=headImage.frame;
    [headButton addTarget:self  action:@selector(selectHeadImage1:) forControlEvents:UIControlEventTouchUpInside];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if ([[[_arr objectAtIndex:_index-1]objectForKey:@"uid"] isEqualToString:appDele.uid])
    {
        headButton.userInteractionEnabled=NO;
    }
    else
    {
        headButton.userInteractionEnabled=YES;
    }
    NSString* nameStr = [[_arr objectAtIndex:_index-1] objectForKey:@"from_name"];
    nameLable.text=nameStr;
    nameLable.font = [UIFont systemFontOfSize:12];
    nameLable.frame = CGRectMake(65, 10, 200, 15);
    
    NSString* timeStr = [[_arr objectAtIndex:_index-1] objectForKey:@"add_time"];
    timeLable.text=timeStr;
    timeLable.font = [UIFont systemFontOfSize:12];
    timeLable.frame = CGRectMake(240, 15, 120, 20);
    
    NSString* contentStr = [[_arr objectAtIndex:_index-1]  objectForKey:@"content"];
    contentLable.text=contentStr;
    contentLable.font = [UIFont systemFontOfSize:12];
    contentLable.numberOfLines = 0;
   
    UIFont *font = [UIFont systemFontOfSize:12.0];
    //设置一个行高上限
    CGSize size = CGSizeMake(200,200);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [contentStr sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    contentLable.frame = CGRectMake(65, 35, 200, labelsize.height);
}
-(void)selectHeadImage
{

}
-(void)selectImage:(UIButton *)_btn
{

}
-(void)selectHeadImage1:(UIButton *)_btn
{

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

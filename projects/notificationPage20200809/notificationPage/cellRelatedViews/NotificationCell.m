//
//  NotificationCell.m
//  notificationPage
//
//  Created by 丁东 on 2020/8/7.
//  Copyright © 2020 zxc. All rights reserved.
//

#import "NotificationCell.h"

@interface NotificationCell ()

@property(nonatomic, strong) TimeTagView *timeTag;

@property(nonatomic, strong) UIView *contentForAll;
@property(nonatomic, strong) MsgSummaryView *messageSummary;
@property(nonatomic, strong) TipListView *tipList;
@property(nonatomic, strong) DetailFooterView *detailFooter;

@end


@implementation NotificationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        [self addSubview:self.timeTag];
        
        [self.contentForAll addSubview:self.detailFooter];
        [self.contentForAll addSubview:self.messageSummary];
        [self.contentForAll addSubview:self.tipList];
        [self addSubview:self.contentForAll];

        [self setConstraintsForNotificationCell];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        self.backgroundColor = [UIColor systemGray6Color];
        
//        NSLog(@"%f",self.frame.size.width);
        
    }
    return self;
}

// MARK: Set values
-(void)setCellWithNoticeModel:(NoticeList *)notice{

//    /// 时间格式化
//    /// @param time 时间戳
//    /// @param formatterStr 格式化formatter
//    + (NSString *)formatterWithTime:(long)time Formatter:(NSString *)formatterStr
//    {
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970: notice.postTime/1000];
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat: @"YYYY-MM-dd HH:mm:ss"];
////
//        return [formatter stringFromDate: date];
//    }
    
    [self.timeTag setWithTime:notice.postTime];
//    [self.timeTag setWithTime:[formatter stringFromDate: date]];
    [self.messageSummary setWithTitle:notice.title andContnetTip:notice.contentTip andContent:notice.content];
    [self.tipList setWithArray:notice.tipList];
    
}

// MARK: Lazy Load for properties
-(TimeTagView *)timeTag{
    if(!_timeTag){
        _timeTag = [[TimeTagView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
    }
    return _timeTag;
}
-(UIView *)contentForAll{
    if(!_contentForAll){
        _contentForAll = [[UIView alloc] initWithFrame:CGRectMake(0, 40, self.bounds.size.width, self.bounds.size.height-40)];
        _contentForAll.backgroundColor = [UIColor whiteColor];
        _contentForAll.layer.cornerRadius = 5;
        _contentForAll.clipsToBounds = YES;
    }
    return _contentForAll;
}
-(MsgSummaryView *)messageSummary{
    if(!_messageSummary){
        _messageSummary = [[MsgSummaryView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width-10, 100)];
    }
    return _messageSummary;
}
-(TipListView *)tipList{
    if(!_tipList){
        _tipList = [[TipListView alloc] initWithFrame:CGRectMake(0, 100, self.bounds.size.width-10, 100)];
    }
    return _tipList;
}
-(DetailFooterView *)detailFooter{
    if(!_detailFooter){
        _detailFooter = [[DetailFooterView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 20)];
    }
    return _detailFooter;
}

// MARK: Set Constraints
-(void)setConstraintsForNotificationCell{
    [self.timeTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.width, 50));
    }];
    
    [self.contentForAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeTag.mas_bottom);
        make.left.mas_equalTo(self.mas_left).offset(5);
        make.right.mas_equalTo(self.mas_right).offset(-5);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    [self.messageSummary mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentForAll.mas_top);
        make.left.mas_equalTo(self.contentForAll.mas_left);
        make.right.mas_equalTo(self.contentForAll.mas_right);
        make.height.mas_equalTo(@100);
    }];
    [self.tipList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageSummary.mas_bottom);
        make.left.mas_equalTo(self.contentForAll.mas_left);
        make.right.mas_equalTo(self.contentForAll.mas_right);
        make.height.mas_equalTo(@100);
    }];
    [self.detailFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentForAll.mas_bottom);
        make.left.mas_equalTo(self.contentForAll.mas_left);
        make.right.mas_equalTo(self.contentForAll.mas_right);
        make.height.mas_equalTo(@40.0);
    }];

}


// MARK: Override the setFrane method.
// Since some of the subViews need cell's frame for initialization. The width of cell needs to be reset to prevent problems caused by the default 320 val
-(void)setFrame:(CGRect)frame{
    frame.size.width = UIScreen.mainScreen.bounds.size.width;
    [super setFrame:frame];
}


@end

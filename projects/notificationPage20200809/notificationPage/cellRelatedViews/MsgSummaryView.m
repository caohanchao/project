//
//  MsgSummaryView.m
//  notificationPage
//
//  Created by 丁东 on 2020/8/7.
//  Copyright © 2020 zxc. All rights reserved.
//

#import "MsgSummaryView.h"

@interface MsgSummaryView ()

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *contentTipLabel;
@property(nonatomic, strong) UILabel *contentLabel;

@end

@implementation MsgSummaryView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentTipLabel];
        [self addSubview:self.contentLabel];
        
        [self setConstraintsForMsgSummaryView];
    }
    return self;
}

// MARK: Set properties
-(void)setWithTitle:(NSString *)title andContnetTip:(NSString *)contentTip andContent:(NSString *)content{
    self.titleLabel.text = title;
    self.contentTipLabel.text = contentTip;
    self.contentLabel.text = content;
}

// MARK: Lazy Load for properties
-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 20)];
        _titleLabel.text = @"购买成功通知";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}
-(UILabel *)contentTipLabel{
    if(!_contentTipLabel){
        _contentTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 40, 100, 20)];
        _contentTipLabel.text = @"价格";
        _contentTipLabel.textAlignment = NSTextAlignmentCenter;
        _contentTipLabel.font = [UIFont systemFontOfSize:12];
        _contentTipLabel.textColor = [UIColor systemGray2Color];
    }
    return _contentTipLabel;
}
-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 60, 300, 20)];
        _contentLabel.text = @"0.04T币";
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:20];
        _contentLabel.textColor = [UIColor blackColor];
    }
    return _contentLabel;
}
-(void)setConstraintsForMsgSummaryView{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);//.offset(5);
        make.left.mas_equalTo(self.mas_left).offset(5);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(@30);
    }];
    [self.contentTipLabel sizeToFit];
    [self.contentTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.mas_centerY);//.offset(-20);
    }];
    [self.contentLabel sizeToFit];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_centerY).offset(5);
    }];
    
}

@end

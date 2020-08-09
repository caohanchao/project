//
//  DetailFooterView.m
//  notificationPage
//
//  Created by 丁东 on 2020/8/7.
//  Copyright © 2020 zxc. All rights reserved.
//

#import "DetailFooterView.h"

@interface DetailFooterView ()

@property(nonatomic, strong) UILabel *showDetailLabel;
@property(nonatomic, strong) UIButton *fakeButton;

@end

@implementation DetailFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        CALayer *seperator = [CALayer layer];
        [seperator setFrame:CGRectMake(0, 0, self.bounds.size.width, 0.5)];
        [seperator setBackgroundColor:[UIColor systemGray6Color].CGColor];
        [self.layer addSublayer:seperator];
        
        [self addSubview:self.showDetailLabel];
        [self addSubview:self.fakeButton];
        
        [self setConstraintsForDetailFooterView];
    }
    return self;
}

// MARK: Lazy load for properties
-(UILabel *)showDetailLabel{
    if(!_showDetailLabel){
        _showDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];;
        _showDetailLabel.text = @"查看详情";
        _showDetailLabel.textColor = [UIColor blackColor];
        _showDetailLabel.font = [UIFont systemFontOfSize:15];
    }
    return _showDetailLabel;
}
-(UIButton *)fakeButton{
    if(!_fakeButton){
        _fakeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width-50, 0, self.bounds.size.height, 50)];
        [_fakeButton setImage:[UIImage systemImageNamed:@"chevron.right"] forState:UIControlStateNormal];
        [_fakeButton setTintColor:[UIColor systemGray3Color]];
//        [_fakeButton setTintColor:[UIColor blackColor]];
    }
    return _fakeButton;
}

// MARK: Add constraints for properties
-(void)setConstraintsForDetailFooterView{
    [self.showDetailLabel sizeToFit];
    [self.showDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(5);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.fakeButton sizeToFit];
    [self.fakeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

@end

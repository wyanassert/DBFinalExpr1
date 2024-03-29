//
//  ShoppingCartCollectionViewCell.m
//  DBFinalExpr1
//
//  Created by 万延 on 16/6/7.
//  Copyright © 2016年 万延. All rights reserved.
//

#import "ShoppingCartCollectionViewCell.h"
#import "ParseHeader.h"
#import <Parse.h>
#import "GoodModel.h"
#import "ShoppingCartModel.h"
#import "ShoppingCartDataController.h"
#import "Masonry.h"
#import "CCommon.h"
#import "UIView+Toast.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ShoppingCartCollectionViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *avatarImage;
@property (nonatomic, strong) UILabel *amountlabel;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UILabel *storageLabel;

@property (nonatomic, strong) GoodModel *good;
@property (nonatomic, strong) ShoppingCartModel *shoppingCart;

@end

@implementation ShoppingCartCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        
    }
    return self;
}

- (void)configureView
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.avatarImage];
    [self.avatarImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.width.equalTo(self.avatarImage.mas_height);
    }];
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImage.mas_top);
        make.height.mas_equalTo(35);
        make.left.equalTo(self.avatarImage.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-8);
    }];
    self.nameLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:30];
    
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(30);
        make.left.equalTo(self.nameLabel.mas_left);
        make.width.mas_equalTo(100);
    }];
    self.priceLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:15];
    
    [self.contentView addSubview:self.selectButton];
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
        make.right.equalTo(self.contentView).offset(-8);
        make.bottom.equalTo(self.contentView).offset(-8);
    }];
    
    [self.contentView addSubview:self.amountlabel];
    [self.amountlabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(40);
        make.right.equalTo(self.selectButton.mas_left).offset(-8);
        make.bottom.equalTo(self.contentView).offset(-8);
    }];
    
    [self.avatarImage addSubview:self.storageLabel];
    [self.storageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImage);
        make.right.equalTo(self.avatarImage);
        make.bottom.equalTo(self.avatarImage);
        make.height.mas_equalTo(21);
    }];
}

- (void)loadData:(ShoppingCartModel *)shoppingCart
{
    [self configureView];
    self.shoppingCart = shoppingCart;
    [self.selectButton setSelected:shoppingCart.selected];
    self.amountlabel.text = [NSString stringWithFormat:@"数量：%@", shoppingCart.amount];
    
    [ShoppingCartDataController createGoodFromShopCart:shoppingCart withBlock:^(GoodModel *good, NSError *error) {
        if(error)
        {
            NSString *message = @"加载购物信息失败！请检查网络";
            [[CCommon getTopmostViewController].view makeToast:message duration:1.5 position:CSToastPositionCenter];
        }
        else
        {
            self.nameLabel.text = good.name;
            self.priceLabel.text = good.price.stringValue;
            if(good.images.count)
                [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:(NSString *)good.images[0]] placeholderImage:[[UIImage imageNamed:@"Image_goods_default"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            else
            {
                [self.avatarImage setImage:[[UIImage imageNamed:@"Image_goods_default"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            }
            if(shoppingCart.amount <= good.amount)
                self.storageLabel.hidden = YES;
            else
            {
                self.storageLabel.text = @"库存不足";
                self.storageLabel.hidden = NO;
            }
        }
    }];
}

- (void)selectButtonDidClicked:(UIButton *)sender
{
    [sender setSelected:!sender.isSelected];
    self.shoppingCart.selected = sender.isSelected;
}

#pragma mark - getter

- (UILabel *)nameLabel
{
    if(!_nameLabel)
    {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:30];
        _nameLabel.textColor = [UIColor blueColor];
    }
    return _nameLabel;
}

- (UILabel *)priceLabel
{
    if(!_priceLabel)
    {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:21];
        _priceLabel.textColor = [UIColor blackColor];
    }
    return _priceLabel;
}

- (UIImageView *)avatarImage
{
    if(!_avatarImage)
    {
        _avatarImage = [[UIImageView alloc] init];
        _avatarImage.tintColor = [UIColor grayColor];
    }
    return _avatarImage;
}

- (UILabel *)amountlabel
{
    if(!_amountlabel)
    {
        _amountlabel = [[UILabel alloc] init];
    }
    return _amountlabel;
}

- (UIButton *)selectButton
{
    if(!_selectButton)
    {
        _selectButton = [[UIButton alloc] init];
        [_selectButton setImage:[UIImage imageNamed:@"image_login_showpassword_off"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"image_login_showpassword_on"] forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(selectButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

- (UILabel *)storageLabel
{
    if(!_storageLabel)
    {
        _storageLabel = [UILabel new];
        _storageLabel.backgroundColor = [UIColor colorWithRed:0.964 green:1.000 blue:0.950 alpha:0.8000];
        _storageLabel.opaque = NO;
        _storageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _storageLabel;
}

@end

//
//  TeamMemberCell.m
//  Decoration
//
//  Created by Qinting on 2016/10/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TeamMemberCell.h"
#import "UIImageView+WebCache.h"
@interface TeamMemberCell()

@property (weak, nonatomic) IBOutlet UIImageView *menberIconIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;

@end

@implementation TeamMemberCell

-(void)setTeam:(DetailTeam *)team{

    self.nameLabel.text = team.name;
    self.positionLabel.text = team.position;
    self.menberIconIV.image = [UIImage imageNamed:team.icon];
}

@end

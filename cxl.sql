-- 用户表
drop table if exists `tp_user`;
create table if not exists `tp_user` (
  id int unsigned not null auto_increment ,
  user_id int unsigned default 0 comment '远程用户id，请使用这个 id 作为 用户 id' ,
  `type` tinyint default 1 comment '用户类型：1-用户 2-商家' ,
  username varchar(255) default '' comment '用户名' ,
  password varchar(255) default '' comment '密码' ,
  sex tinyint default 0 comment '性别: 0-未知 1-男人 2-女人 3-两性' ,
  phone varchar(20) default '' comment '手机号码' ,
  country_code varchar(20) default '' comment '国家代码' ,
   avatar varchar(500) default '' comment '头像' ,
  birthday date default null comment '生日' ,
  status tinyint default 1 comment '账号状态：1-正常 2-锁定' ,
  update_time datetime default current_timestamp on update current_timestamp ,
  create_time datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '用户表' ;

drop table if exists `tp_user_balance`;
create table if not exists `tp_user_balance` (
  id int unsigned not null auto_increment ,
  user_id int unsigned default 0 comment '远程用户id，请使用这个 id 作为 用户 id' ,
  balance decimal(13,2) default 0 comment '用户余额' ,
  update_time datetime default current_timestamp on update current_timestamp ,
  create_time datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '用户余额表';

drop table if exists `tp_merchant`;
create table if not exists `tp_merchant` (
  id int unsigned not null auto_increment ,
  name varchar(255) default '' comment '店铺名称' ,
  user_id int unsigned default 0 comment 'tp_user.id' ,
  image varchar(500) default '' comment '店铺封面图' ,
  is_ok tinyint default 0 comment '商家审核是否通过：1-审核不通过 2-审核通过' ,
  status tinyint default 1 comment '商家状态：1-正常 2-锁定' ,
  type tinyint default 3 comment '1-自营店铺 2-合作店铺（同 店家 与 天猫的关系） 3-普通店铺' ,
  `desc` text default null comment '店铺介绍' ,
  update_time datetime default current_timestamp on update current_timestamp ,
  create_time datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '商家表' ;

drop table if exists `tp_merchant_image`;
create table if not exists `tp_merchant_image` (
  id int unsigned not null auto_increment ,
  merchant_id int unsigned default 0 comment 'tp_merchant.id' ,
  path varchar(500) default '' comment '店铺详情图片' ,
  create_time datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '商家图片表' ;

drop table if exists `tp_merchant_application`;
create table if not exists `tp_merchant_application` (
  id int unsigned not null auto_increment ,
  user_id int unsigned default 0 comment 'tp_user.id' ,
  merchant_id int unsigned default 0 comment 'tp_merchant.id' ,
  status tinyint default 1 comment '1-审核中 2-审核通过 3-审核不通过' ,
  reason varchar(500) default '' comment '审核结果说明，每次用户修改申请后，该字段值都需要清空' ,
  update_time datetime default current_timestamp on update current_timestamp ,
  create_time datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '商家申请表' ;

drop table if exists `tp_category`;
create table if not exists `tp_category` (
  id int unsigned not null auto_increment ,
  name varchar(255) default '' comment '分类名称' ,
  `desc` varchar(500) default '' comment '分类描述' ,
  image varchar(500) default '' comment '分类图片' ,
  p_id int unsigned default 0 comment 'tp_category.id,上级分类id' ,
  update_time datetime default current_timestamp on update current_timestamp ,
  create_time datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '分类表' ;

drop table if exists `tp_specification_group`;
create table if not exists `tp_specification_group` (
  id int unsigned not null auto_increment ,
  name varchar(255) default '' comment '分组名称' ,
  create_time datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '规格分组表' ;

drop table if exists `tp_specification`;
create table if not exists `tp_specification` (
  id int unsigned not null auto_increment ,
  name varchar(255) default '' comment '规格名称' ,
  merchant_id int unsigned default 0 comment 'tp_merchant.id' ,
  thumb varchar(500) default '' comment '商品封面图' ,
  `detail` mediumtext comment '商品详情' ,
  update_time datetime default current_timestamp on update current_timestamp ,
  create_time datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '规格表' ;

drop table if exists `tp_goods`;
create table if not exists `tp_goods` (
  id int unsigned not null auto_increment ,
  name varchar(500) default '' comment '商品名称' ,
  merchant_id int unsigned default 0 comment 'tp_merchant.id' ,
  thumb varchar(500) default '' comment '商品封面图' ,
  `detail` mediumtext comment '商品详情' ,
  package_list varchar(1000) default '' comment '包装清单' ,
  price decimal(13,2) default 0 comment '价格' ,
  stock int unsigned default 0 comment '库存' ,
  `min_price` decimal(13,2) default 0 comment '最小金额' ,
  `max_price` decimal(13,2) default 0 comment '最高金额' ,
  has_option tinyint default 0 comment '是否有选项：0-否 1-是' ,
  update_time datetime default current_timestamp on update current_timestamp ,
  create_time datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '商品表' ;

drop table if exists `tp_goods_specification`;
create table if not exists `tp_goods_specification` (
  id int unsigned not null auto_increment ,
  goods_id int unsigned default 0 comment 'tp_goods.id' ,
  specification_id int unsigned default 0 comment 'tp_specification.id' ,
  create_time datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '商品-规格-关联表' ;

drop table if exists `tp_goods_option_group`;
create table if not exists `tp_goods_option_group` (
  id int unsigned not null auto_increment ,
  name varchar(255) default '' comment '分组名称' ,
  create_time datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '商品选项分组表' ;

drop table if exists `tp_goods_option`;
create table if not exists `tp_goods_option` (
  id int unsigned not null auto_increment ,
  goods_id int unsigned default 0 comment 'tp_goods.id' ,
  goods_option_group_id int unsigned default 0 comment 'tp_goods_option_group.id' ,
  name varchar(255) default '' comment '选项名称' ,
  `desc` varchar(500) default '' comment '描述' ,
  image varchar(500) default '' comment '图片' ,
  enable_preview tinyint default 0 comment '是否开启选项图片预览：0-否 1-是' ,
  enable tinyint default 1 comment '是否启用：0-不启用 1-启用' ,
  create_time datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '商品-选项-关联表' ;

drop table if exists `tp_goods_option_list`;
create table if not exists `tp_goods_option_list` (
  id int unsigned not null auto_increment ,
  goods_id int unsigned default 0 comment 'tp_goods.id，缓存字段' ,
  price decimal(13,2) default 0 comment '价格' ,
  stock int unsigned default 0 comment '库存' ,
  create_time datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '商品不同选项对应的价格|库存等表';

drop table if exists `tp_goods_option_list_option`;
create table if not exists `tp_goods_option_list_option` (
  id int unsigned not null auto_increment ,
  goods_id int unsigned default 0 comment 'tp_goods.id，缓存字段' ,
  goods_option_list_id int unsigned default 0 comment 'tp_goods_option_list.id' ,
  goods_option_id int unsigned default 0 comment 'tp_goods_option.id' ,
  create_time datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '固定选项商品具备的选项表';

-- 订单表
drop table if exists `tp_goods_order`;
create table if not exists `tp_goods_order` (
  id int unsigned not null auto_increment ,
  user_id int unsigned default 0 comment 'tp_user.id' ,
  order_no varchar(255) default '' comment '订单号' ,
  price decimal(13,2) default 0 comment '价格' ,
  p_id int unsigned default 0 comment 'tp_goods_order.id，上级订单id' ,
  update_time datetime default current_timestamp on update current_timestamp ,
  create_time datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '商品订单表' ;


-- 订单详情表
drop table if exists `tp_goods_order_detail`;
drop table if exists `tp_goods_order_goods`;
create table if not exists `tp_goods_order_goods` (
  id int unsigned not null auto_increment ,
  user_id int unsigned default 0 comment 'tp_user.id，缓存字段' ,
  shop_id int unsigned default 0 comment 'tp_shop.id，缓存字段' ,
  goods_id int unsigned default 0 comment 'tp_goods.id' ,
  name varchar(500) default '' comment '商品名称-缓存字段' ,
  `thumb`int unsigned default 0 comment '商品封面图-缓存字段' ,
  price decimal(13,2) default 0 comment '商品价格-缓存字段' ,
  `number`int unsigned default 0 comment '购买数量' ,
  has_option tinyint default 0 comment '是否有选项：0-没有 1-有 ，缓存字段' ,
  goods_option varchar(1000) comment '商品选项，字符串描述；用以展示用' ,
  goods_option_id varchar(500) default '' comment 'json 字符串，按照从小到大顺序保存，tp_goods_option.id ' ,
  update_time datetime default current_timestamp on update current_timestamp ,
  create_time datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '商品订单表' ;


-- 后台-操作日志
drop table if exists `tp_operation_log`;
create table if not exists `tp_operation_log` (
  id int unsigned not null auto_increment ,
  user_id int unsigned default 0 comment 'tp_admin_user.id，操作者用户id' ,
  type varchar(500) default '' comment '日志类型: common-普通日志 order-订单日志' ,
  log text comment '操作日志，请具体说明操作内容' ,
  create_time datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '操作日志';

-- 退/换货
drop table if exists `tp_return_goods`;
create table if not exists `tp_return_goods` (
  id int unsigned not null auto_increment ,
  user_id int unsigned default 0 comment 'tp_user.id' ,
  service_no varchar(255) default '' comment '服务单号' ,
  goods_id int unsigned default 0 comment 'tp_goods.id，缓存字段' ,
  shop_id int unsigned default 0 comment 'tp_shop.id，缓存字段' ,
  goods_order_goods_id int unsigned default 0 comment 'tp_goods_order_goods.id 订单商品id' ,
  type tinyint default 1 comment '类型：1-退货 2-换货 3-维修' ,
  reason varchar(1000) default '' comment '退换货原因' ,
  status tinyint default 1 comment '状态：1-审核中 2-同意售后 3-拒绝售后 4-关闭 5-已完成 6-已评价' ,
  remark varchar(1000) default '' comment '审核意见，仅允许商家填写' ,
--   return_method tinyint default 1 comment '寄送方式：1-快递至商家 2-上门取件' ,
--   get_address varchar(1000) default '' comment '取件地址，return_method = 2 时，有效 ' ,
  return_address varchar(1000) default '' comment '返寄地址' ,
  create_time datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '退换货';



drop table if exists `tp_timer_log`;
create table if not exists `tp_timer_log` (
  id int unsigned not null auto_increment ,
  type varchar(500) default 'none' comment '类型：none-无类型' ,
  log text comment '操作日志' ,
  create_time datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '定时器操作日志';

drop table if exists `tp_administrator`;
create table if not exists `tp_administrator` (
  `id` int unsigned not null auto_increment,
  username varchar(255) default '' comment '角色名称',
  password varchar(255) default '' comment '密码' ,
  avatar varchar(500) default '' comment '头像' ,
  role_id int unsigned default 0 comment 'tp_role.id' ,
  is_root tinyint default 0 comment '是否超级管理员：0-否 1-是' ,
  last_ip varchar(255) default '' comment '最后一次登录 ip' ,
  last_time datetime default null comment '最近一次登录时间' ,
  `number` int unsigned default 0 comment '登录次数' ,
  status tinyint default 1 comment '账号状态：1-正常 2-锁定 3-禁用' ,
  update_time datetime default current_timestamp on update current_timestamp ,
  `create_time` datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '管理员表';

drop table if exists `tp_role`;
create table if not exists `tp_role` (
  `id` int unsigned not null auto_increment,
  `name` varchar(255) default '' comment '角色名称',
  `weight` smallint default '0' comment '权重',
  `create_time` datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '角色表';

drop table if exists `tp_route`;
create table if not exists `tp_route` (
  `id` int unsigned not null auto_increment,
  `cn` varchar(50) default '' comment '中文名称',
  `en` varchar(50) default '' comment '英文名称',
  `route` varchar(255) default '' comment '路由，例如：/admin/Login/loginView',
  `s_ico` varchar(500)  default '' comment '小图标',
  `b_ico` varchar(500)  default '' comment '大图标',
  `type` varchar(255) default 'api' comment '路由类型：api-接口;view-视图',
  `menu` tinyint  default 0 comment '是否菜单 0-否；1-是',
  `p_id` int(11) default '0' comment '上级id，tp_route.id',
  enable tinyint default 1 comment '是否启用：0-不启用 1-启用' ,
  `weight` smallint default '0' comment '权重',
  `create_time` datetime default current_timestamp comment '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '路由表';

drop table if exists `tp_role_route`;
create table if not exists `tp_role_route` (
  `id` int unsigned not null auto_increment,
  `role_id` int unsigned default 0 comment 'tp_role.id',
  `route_id` int unsigned default 0 comment 'route_id.id',
  `create_time` datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '角色-路由-关联表';

drop table if exists `tp_system_param`;
create table if not exists `tp_system_param` (
  id int unsigned not null auto_increment,
  name varchar(500) default '' comment '名称' ,
  `desc` varchar(500) default '' comment '描述' ,
  `key` varchar(255) default '' comment 'key' ,
  `value` varchar(500) default '' comment 'value' ,
  update_time datetime default current_timestamp on update current_timestamp ,
  create_time datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '系统参数表';

drop table if exists `tp_user_token`;
create table if not exists `tp_user_token` (
  id int unsigned not null auto_increment,
  user_id int unsigned default 0 comment 'tp_user.id' ,
  token varchar(500) default '' comment 'token 字符串' ,
  expire datetime default null comment '过期时间' ,
  create_time datetime default current_timestamp ,
  primary key `id` (`id`)
) engine=innodb character set = utf8mb4 collate = utf8mb4_bin comment '用户 token 表';

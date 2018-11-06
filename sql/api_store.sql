/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : api_store

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-11-06 20:06:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for apis
-- ----------------------------
DROP TABLE IF EXISTS `apis`;
CREATE TABLE `apis` (
  `Id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT 'API的id',
  `Title` varchar(255) NOT NULL DEFAULT '' COMMENT '接口中文名',
  `ApiTitle` varchar(255) NOT NULL DEFAULT '' COMMENT '接口英文',
  `CateId` smallint(6) DEFAULT NULL COMMENT '所属分组',
  `Methods` char(10) NOT NULL DEFAULT '' COMMENT 'GET或POST',
  `Description` varchar(255) DEFAULT '' COMMENT '接口描述',
  `ProductId` int(10) unsigned zerofill NOT NULL COMMENT '该api所属产品',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of apis
-- ----------------------------
INSERT INTO `apis` VALUES ('0000000005', '/user/login', '用户登录', '15', 'POST', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000006', '/user/userList', '获取用户列表', '15', 'GET', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000007', '/user/reg', '用户注册', '15', 'POST', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000008', '/user/activeUserList', '获取今日登录用户(后台用)', '15', 'GET', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000009', '/user/validOldPwd', '验证用户旧密码', '15', 'POST', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000010', '/user/updatePwd', '修改或重置用户密码', '15', 'POST', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000011', '/arcticle/arcticleList', '用户的文章列表', '16', 'GET', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000012', '/banner/bannerList', 'banner图列表', '17', 'GET', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000013', '/mood/moodList', '心情列表', '18', 'GET', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000014', '/tag/tagList', '标签列表', '19', 'GET', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000015', '/user/lockUser', '锁定/解锁用户', '15', 'POST', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000016', '/user/delete', '删除用户', '15', 'POST', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000017', '/user/detail', '获取用户详情', '15', 'GET', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000018', '/arcticle/createOrUpdate', '新增或修改文章', '16', 'POST', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000019', '/arcticle/detail', '文章详情', '16', 'GET', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000020', '/arcticle/delete', '删除文章', '16', 'POST', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000021', '/banner/createOrUpdate', '新增或修改banner', '17', 'POST', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000022', '/banner/publish', '上架/下架banner图', '17', 'POST', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000023', '/banner/delete', '删除一个banner', '17', 'POST', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000024', '/mood/createOrUpdate', '新增或修改心情', '18', 'POST', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000025', '/mood/detail', '获取心情详情', '18', 'GET', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000026', '/mood/delete', '删除一条心情', '18', 'POST', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000027', '/tag/delete', '删除标签', '19', 'POST', '', '0000000003');
INSERT INTO `apis` VALUES ('0000000028', '/other/timeLine', '获取用户时间轴', '20', 'GET', '', '0000000003');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `Id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT 'api分类的id',
  `Title` varchar(255) NOT NULL DEFAULT '' COMMENT '分类名',
  `ProductId` smallint(6) NOT NULL COMMENT '所属产品',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('0000000015', '用户', '3');
INSERT INTO `category` VALUES ('0000000016', '文章', '3');
INSERT INTO `category` VALUES ('0000000017', 'Banner', '3');
INSERT INTO `category` VALUES ('0000000018', '心情', '3');
INSERT INTO `category` VALUES ('0000000019', '标签', '3');
INSERT INTO `category` VALUES ('0000000020', '其他', '3');

-- ----------------------------
-- Table structure for input_params
-- ----------------------------
DROP TABLE IF EXISTS `input_params`;
CREATE TABLE `input_params` (
  `Id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '输入参数的id',
  `Title` varchar(255) NOT NULL DEFAULT '' COMMENT '参数名称',
  `Description` varchar(255) NOT NULL COMMENT '参数描述',
  `Type` char(10) DEFAULT NULL COMMENT '参数类型  number  string  date  boolean  null',
  `Default` varchar(255) DEFAULT '' COMMENT '参数默认值',
  `Test` varchar(255) DEFAULT '' COMMENT '测试值',
  `IsNecessary` tinyint(1) DEFAULT '1' COMMENT '1 - 是  2 - 否',
  `ApiId` int(10) unsigned zerofill NOT NULL COMMENT '这个参数所属api',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of input_params
-- ----------------------------
INSERT INTO `input_params` VALUES ('0000000006', 'Account', '账号', 'string', '', 'user', '1', '0000000005');
INSERT INTO `input_params` VALUES ('0000000007', 'Password', '密码(sha1加密)', 'string', '', '', '1', '0000000005');
INSERT INTO `input_params` VALUES ('0000000008', 'keywords', '搜索关键词，支持账号和昵称', 'string', '', 'noven', '0', '0000000006');
INSERT INTO `input_params` VALUES ('0000000009', 'cp', '当前页', 'number', '1', '1', '0', '0000000006');
INSERT INTO `input_params` VALUES ('0000000010', 'ps', '每页条数', 'number', '20', '20', '0', '0000000006');
INSERT INTO `input_params` VALUES ('0000000011', 'Account', '账号', 'string', '', '', '1', '0000000007');
INSERT INTO `input_params` VALUES ('0000000012', 'Password', '密码（sha1加密）', 'string', '', '', '1', '0000000007');
INSERT INTO `input_params` VALUES ('0000000013', 'NickName', '昵称', 'string', '', '', '0', '0000000007');
INSERT INTO `input_params` VALUES ('0000000014', 'keywords', '搜索关键字', 'string', '', '', '0', '0000000008');
INSERT INTO `input_params` VALUES ('0000000015', 'cp', '当前页', 'number', '', '1', '0', '0000000008');
INSERT INTO `input_params` VALUES ('0000000016', 'ps', '每页条数', 'number', '', '20', '0', '0000000008');
INSERT INTO `input_params` VALUES ('0000000017', 'userId', '要验证的用户Id', '', '', '', '1', '0000000009');
INSERT INTO `input_params` VALUES ('0000000018', 'oldPwd', '旧密码', '', '', '', '1', '0000000009');
INSERT INTO `input_params` VALUES ('0000000019', 'Id', '用户Id', '', '', '', '1', '0000000010');
INSERT INTO `input_params` VALUES ('0000000020', 'Password', '新密码（sha1加密）', '', '', '', '1', '0000000010');
INSERT INTO `input_params` VALUES ('0000000021', 'keywords', '搜索关键词，支持标题、作者查询', 'string', '', '', '0', '0000000011');
INSERT INTO `input_params` VALUES ('0000000022', 'ps', '每页条数', 'number', '20', '20', '0', '0000000011');
INSERT INTO `input_params` VALUES ('0000000023', 'cp', '当前是第几页', 'number', '1', '1', '0', '0000000011');
INSERT INTO `input_params` VALUES ('0000000024', 'authorId', '作者Id，获取该作者文章列表', 'number', '', '1', '0', '0000000011');
INSERT INTO `input_params` VALUES ('0000000025', 'keywords', '搜索关键词，支持标题查询', 'string', '', '', '0', '0000000012');
INSERT INTO `input_params` VALUES ('0000000026', 'ps', '每页条数', 'number', '20', '20', '0', '0000000012');
INSERT INTO `input_params` VALUES ('0000000027', 'cp', '当前是第几页', 'number', '1', '1', '0', '0000000012');
INSERT INTO `input_params` VALUES ('0000000028', 'type', 'banner图分类 0 - 所有  1 - 首页展示的  2 - 用户首页展示的', 'number', '0', '0', '0', '0000000012');
INSERT INTO `input_params` VALUES ('0000000029', 'userId', '用户Id,用于查询用户的banner图', 'number', '', '1', '0', '0000000012');
INSERT INTO `input_params` VALUES ('0000000030', 'keywords', '搜索关键词，支持作者查询', 'string', '', '', '0', '0000000013');
INSERT INTO `input_params` VALUES ('0000000031', 'cp', '当前是第几页', 'number', '1', '1', '0', '0000000013');
INSERT INTO `input_params` VALUES ('0000000032', 'ps', '每页条数', 'number', '20', '20', '0', '0000000013');
INSERT INTO `input_params` VALUES ('0000000033', 'keywords', '搜索关键词，支持标签标题查询', 'string', '', '', '0', '0000000014');
INSERT INTO `input_params` VALUES ('0000000034', 'cp', '当前页数', 'number', '1', '1', '0', '0000000014');
INSERT INTO `input_params` VALUES ('0000000035', 'ps', '每页多少条', 'number', '20', '20', '0', '0000000014');
INSERT INTO `input_params` VALUES ('0000000036', 'Id', '用户编号', 'number', '', '', '1', '0000000015');
INSERT INTO `input_params` VALUES ('0000000037', 'Status', '将用户状态修改为 1 - 修改为正常  2 - 修改为锁定', 'number', '', '', '1', '0000000015');
INSERT INTO `input_params` VALUES ('0000000038', 'Id', '用户编号', 'number', '', '', '1', '0000000016');
INSERT INTO `input_params` VALUES ('0000000039', 'Id', '用户编号(大写)', 'number', '', '1', '1', '0000000017');
INSERT INTO `input_params` VALUES ('0000000040', 'startTime', '根据时间范围筛选文章，开始时间', 'date', '', '', '0', '0000000011');
INSERT INTO `input_params` VALUES ('0000000041', 'endTime', '结束时间', 'date', '', '', '0', '0000000011');
INSERT INTO `input_params` VALUES ('0000000042', 'Id', '文章ID，如果有则为修改', 'number', '', '', '0', '0000000018');
INSERT INTO `input_params` VALUES ('0000000043', 'Title', '文章标题', 'string', '', '', '1', '0000000018');
INSERT INTO `input_params` VALUES ('0000000044', 'Author', '作者名', 'string', '', '', '1', '0000000018');
INSERT INTO `input_params` VALUES ('0000000045', 'Brief', '文章简介', 'string', '', '', '0', '0000000018');
INSERT INTO `input_params` VALUES ('0000000046', 'Content', '文章内容', 'string', '', '', '1', '0000000018');
INSERT INTO `input_params` VALUES ('0000000047', 'AuthorId', '所属用户ID', 'number', '', '', '1', '0000000018');
INSERT INTO `input_params` VALUES ('0000000048', 'Id', '文章编号（大写）', 'number', '', '1', '1', '0000000019');
INSERT INTO `input_params` VALUES ('0000000049', 'Id', '文章编号（大写）', 'number', '', '', '1', '0000000020');
INSERT INTO `input_params` VALUES ('0000000050', 'order', '排序规则，目前支持ReadCount,Id倒叙输出', 'string', 'Id', 'ReadCount', '0', '0000000011');
INSERT INTO `input_params` VALUES ('0000000051', 'isShow', '查询上架/下架图片 0 已下架  1 已上架', 'number', '', '', '0', '0000000012');
INSERT INTO `input_params` VALUES ('0000000052', 'Id', 'banner图的ID', 'number', '', '', '0', '0000000021');
INSERT INTO `input_params` VALUES ('0000000053', 'Title', 'banner的标题', 'string', '', '', '1', '0000000021');
INSERT INTO `input_params` VALUES ('0000000054', 'Type', 'banner图类型，1 - 首页展示  2 - 用户展示', 'number', '', '', '1', '0000000021');
INSERT INTO `input_params` VALUES ('0000000055', 'Url', 'banner地址', 'string', '', '', '0', '0000000021');
INSERT INTO `input_params` VALUES ('0000000056', 'Link', 'banner对应的超链接', 'string', '', '', '0', '0000000021');
INSERT INTO `input_params` VALUES ('0000000057', 'CreateTime', '创建时间', 'date', '', '', '0', '0000000021');
INSERT INTO `input_params` VALUES ('0000000058', 'IsShow', ' 0 - 前台不展示     1 - 前台展示', 'number', '0', '', '1', '0000000021');
INSERT INTO `input_params` VALUES ('0000000059', 'UserId', '所属用户id，如果有该数据，则是用户的banner', 'number', '', '', '0', '0000000021');
INSERT INTO `input_params` VALUES ('0000000080', 'Id', 'banner编号', 'number', '', '', '1', '0000000022');
INSERT INTO `input_params` VALUES ('0000000081', 'isShow', '要修改成的上下架状态 0 - 下架 1 - 上架', 'number', '', '', '1', '0000000022');
INSERT INTO `input_params` VALUES ('0000000063', 'Id', '要删除的banner编号', 'string', '', '', '1', '0000000023');
INSERT INTO `input_params` VALUES ('0000000064', 'authorId', '作者Id', 'number', '', '', '0', '0000000013');
INSERT INTO `input_params` VALUES ('0000000065', 'startTime', '发表心情时间范围的开始时间', 'date', '', '', '0', '0000000013');
INSERT INTO `input_params` VALUES ('0000000066', 'endTime', '结束时间', 'date', '', '', '0', '0000000013');
INSERT INTO `input_params` VALUES ('0000000067', 'order', '排序，暂支持传入 ReadCount和Id', 'string', 'Id', 'ReadCount', '0', '0000000013');
INSERT INTO `input_params` VALUES ('0000000068', 'Id', '心情id，如果修改则必填', 'number', '', '', '0', '0000000024');
INSERT INTO `input_params` VALUES ('0000000069', 'Content', '心情内容', 'string', '', '', '1', '0000000024');
INSERT INTO `input_params` VALUES ('0000000070', 'Author', '作者名称', 'string', '', '', '1', '0000000024');
INSERT INTO `input_params` VALUES ('0000000071', 'AuthorId', '作者ID', 'number', '', '', '1', '0000000024');
INSERT INTO `input_params` VALUES ('0000000072', 'Url', '心情配图原图', 'string', '', '', '0', '0000000024');
INSERT INTO `input_params` VALUES ('0000000073', 'Id', '心情编号', 'number', '', '1', '1', '0000000025');
INSERT INTO `input_params` VALUES ('0000000074', 'Id', '心情编号', 'string', '', '1', '1', '0000000026');
INSERT INTO `input_params` VALUES ('0000000075', 'userId', '用户编号，如果传入则获取用户相关标签', 'number', '', '', '0', '0000000014');
INSERT INTO `input_params` VALUES ('0000000076', 'type', '查询所有用户/文章标签', 'number', '', '', '0', '0000000014');
INSERT INTO `input_params` VALUES ('0000000077', 'arcTicleId', '查询某篇文章的标签', 'number', '', '', '0', '0000000014');
INSERT INTO `input_params` VALUES ('0000000078', 'Id', '要删除的api编号', 'string', '', '', '1', '0000000027');
INSERT INTO `input_params` VALUES ('0000000079', 'Id', '用户Id', 'number', '', '1', '1', '0000000028');

-- ----------------------------
-- Table structure for output_params
-- ----------------------------
DROP TABLE IF EXISTS `output_params`;
CREATE TABLE `output_params` (
  `Id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '输出参数的id',
  `Title` varchar(255) NOT NULL DEFAULT '' COMMENT '参数名称',
  `Description` varchar(255) NOT NULL COMMENT '参数描述',
  `Type` char(10) DEFAULT NULL COMMENT '参数类型  number  string  date  boolean  null',
  `ApiId` int(10) unsigned zerofill NOT NULL COMMENT '该参数所属api',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=127 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of output_params
-- ----------------------------
INSERT INTO `output_params` VALUES ('0000000006', 'Id', '用户Id', 'number', '0000000005');
INSERT INTO `output_params` VALUES ('0000000007', 'NickName', '用户昵称', 'string', '0000000005');
INSERT INTO `output_params` VALUES ('0000000008', 'Account', '账号', 'string', '0000000005');
INSERT INTO `output_params` VALUES ('0000000009', 'CreateTime', '创建时间', 'date', '0000000005');
INSERT INTO `output_params` VALUES ('0000000010', 'Status', '用户状态 1 - 正常 2 -锁定', 'number', '0000000005');
INSERT INTO `output_params` VALUES ('0000000011', 'UserType', '用户类型 1 - 普通用户  2 - 管理员  3 - 超管', 'number', '0000000005');
INSERT INTO `output_params` VALUES ('0000000012', 'LastTime', '上次登录时间', 'date', '0000000005');
INSERT INTO `output_params` VALUES ('0000000013', 'LastIp', '上次登录IP', 'string', '0000000005');
INSERT INTO `output_params` VALUES ('0000000014', 'ThisTime', '这次登录时间', 'date', '0000000005');
INSERT INTO `output_params` VALUES ('0000000015', 'ThisIp', '这次登录IP', 'string', '0000000005');
INSERT INTO `output_params` VALUES ('0000000016', 'Id', '用户id', 'number', '0000000006');
INSERT INTO `output_params` VALUES ('0000000017', 'NickName', '用户昵称', 'string', '0000000006');
INSERT INTO `output_params` VALUES ('0000000018', 'Account', '账号', 'string', '0000000006');
INSERT INTO `output_params` VALUES ('0000000019', 'CreateTime', '创建时间', 'date', '0000000006');
INSERT INTO `output_params` VALUES ('0000000020', 'Status', '用户状态 1 - 正常 2 -锁定', 'number', '0000000006');
INSERT INTO `output_params` VALUES ('0000000021', 'UserType', '用户类型 1 - 普通用户 2-管理员  3-超级管理员', 'number', '0000000006');
INSERT INTO `output_params` VALUES ('0000000022', 'Password', '密码', 'string', '0000000006');
INSERT INTO `output_params` VALUES ('0000000023', 'LastTime', '上次登录时间', 'date', '0000000006');
INSERT INTO `output_params` VALUES ('0000000024', 'LastIp', '上次登录IP', 'string', '0000000006');
INSERT INTO `output_params` VALUES ('0000000025', 'ThisTime', '本次登录时间', 'date', '0000000006');
INSERT INTO `output_params` VALUES ('0000000026', 'ThisIp', '本次登录IP', 'string', '0000000006');
INSERT INTO `output_params` VALUES ('0000000027', 'data', '新增成功的用户id', 'number', '0000000007');
INSERT INTO `output_params` VALUES ('0000000028', 'Id', '用户Id', 'number', '0000000008');
INSERT INTO `output_params` VALUES ('0000000029', 'NickName', '用户昵称', 'string', '0000000008');
INSERT INTO `output_params` VALUES ('0000000030', 'Account', '用户账号', 'string', '0000000008');
INSERT INTO `output_params` VALUES ('0000000031', 'CreateTime', '创建时间', 'date', '0000000008');
INSERT INTO `output_params` VALUES ('0000000032', 'Status', '用户状态 1 - 正常  2-锁定', 'number', '0000000008');
INSERT INTO `output_params` VALUES ('0000000033', 'UserType', '用户类型  1 - 普通用户  2 - 管理员  3- 超级管理员', 'number', '0000000008');
INSERT INTO `output_params` VALUES ('0000000034', 'Password', '用户密码', 'string', '0000000008');
INSERT INTO `output_params` VALUES ('0000000035', 'LastTime', '上次登录时间', 'date', '0000000008');
INSERT INTO `output_params` VALUES ('0000000036', 'LastIp', '上次登录Ip', 'string', '0000000008');
INSERT INTO `output_params` VALUES ('0000000037', 'ThisTime', '这次登录时间', 'date', '0000000008');
INSERT INTO `output_params` VALUES ('0000000038', 'ThisIp', '这次登录ip', 'string', '0000000008');
INSERT INTO `output_params` VALUES ('0000000039', 'Id', '文章ID', 'number', '0000000011');
INSERT INTO `output_params` VALUES ('0000000040', 'Title', '文章标题', 'string', '0000000011');
INSERT INTO `output_params` VALUES ('0000000041', 'Author', '作者名', 'string', '0000000011');
INSERT INTO `output_params` VALUES ('0000000044', 'CreateTime', '创建时间', 'date', '0000000011');
INSERT INTO `output_params` VALUES ('0000000045', 'ReadCount', '点击率', 'number', '0000000011');
INSERT INTO `output_params` VALUES ('0000000046', 'ThumbUrl', '文章缩略图', 'string', '0000000011');
INSERT INTO `output_params` VALUES ('0000000047', 'Url', '文章原图', 'string', '0000000011');
INSERT INTO `output_params` VALUES ('0000000048', 'AuthorId', '所属用户ID', 'number', '0000000011');
INSERT INTO `output_params` VALUES ('0000000120', 'Content', '心情内容', 'string', '0000000024');
INSERT INTO `output_params` VALUES ('0000000119', 'Id', '心情id', 'number', '0000000024');
INSERT INTO `output_params` VALUES ('0000000049', 'Id', 'banner图的ID', 'number', '0000000012');
INSERT INTO `output_params` VALUES ('0000000050', 'Title', 'banner的标题', 'string', '0000000012');
INSERT INTO `output_params` VALUES ('0000000051', 'Type', '1 - 首页  2 - 用户', 'number', '0000000012');
INSERT INTO `output_params` VALUES ('0000000052', 'Url', 'banner地址', 'string', '0000000012');
INSERT INTO `output_params` VALUES ('0000000053', 'Link', 'banner对应的超链接', 'string', '0000000012');
INSERT INTO `output_params` VALUES ('0000000054', 'CreateTime', '创建时间', 'number', '0000000012');
INSERT INTO `output_params` VALUES ('0000000055', 'IsShow', '0 - 前台不展示     1 - 前台展示', 'number', '0000000012');
INSERT INTO `output_params` VALUES ('0000000056', 'UserId', '所属用户id，如果有该数据，则是用户的banner', 'number', '0000000012');
INSERT INTO `output_params` VALUES ('0000000057', 'Id', '心情id', 'number', '0000000013');
INSERT INTO `output_params` VALUES ('0000000058', 'Content', '心情内容', 'string', '0000000013');
INSERT INTO `output_params` VALUES ('0000000059', 'Author', '作者名称', 'string', '0000000013');
INSERT INTO `output_params` VALUES ('0000000060', 'AuthorId', '作者ID', 'number', '0000000013');
INSERT INTO `output_params` VALUES ('0000000061', 'CreateTime', '创建时间', 'date', '0000000013');
INSERT INTO `output_params` VALUES ('0000000062', 'ReadCount', '点击率', 'number', '0000000013');
INSERT INTO `output_params` VALUES ('0000000063', 'Url', '原图', 'string', '0000000013');
INSERT INTO `output_params` VALUES ('0000000064', 'ThumbUrl', '缩略图', 'string', '0000000013');
INSERT INTO `output_params` VALUES ('0000000065', 'Id', '标签ID', 'number', '0000000014');
INSERT INTO `output_params` VALUES ('0000000066', 'Title', '标签题目', 'string', '0000000014');
INSERT INTO `output_params` VALUES ('0000000067', 'CreateTime', '创建日期', 'date', '0000000014');
INSERT INTO `output_params` VALUES ('0000000068', 'UserId', '用户ID，如果有该数据，则表示是用户的标签，没有则是文章的标签', 'number', '0000000014');
INSERT INTO `output_params` VALUES ('0000000069', 'ArcTicleId', '所属文章id', 'number', '0000000014');
INSERT INTO `output_params` VALUES ('0000000070', 'Id', '用户Id', 'number', '0000000017');
INSERT INTO `output_params` VALUES ('0000000071', 'NickName', '用户昵称', 'string', '0000000017');
INSERT INTO `output_params` VALUES ('0000000072', 'Account', '用户的账号，可以是手机号、邮箱、个性化账号', 'string', '0000000017');
INSERT INTO `output_params` VALUES ('0000000073', 'CreateTime', '创建时间', 'date', '0000000017');
INSERT INTO `output_params` VALUES ('0000000074', 'Status', '1 - 正常 2 - 锁定', 'number', '0000000017');
INSERT INTO `output_params` VALUES ('0000000075', 'UserType', '1 - 普通用户  2 - 管理员  3 - 超级管理员', 'number', '0000000017');
INSERT INTO `output_params` VALUES ('0000000076', 'Password', '用户密码', 'string', '0000000017');
INSERT INTO `output_params` VALUES ('0000000077', 'LastTime', '上次登录时间', 'date', '0000000017');
INSERT INTO `output_params` VALUES ('0000000078', 'LastIp', '上次登录IP', 'string', '0000000017');
INSERT INTO `output_params` VALUES ('0000000079', 'ThisTime', '本次登录时间', 'date', '0000000017');
INSERT INTO `output_params` VALUES ('0000000080', 'ThisIp', '本次登录IP', 'string', '0000000017');
INSERT INTO `output_params` VALUES ('0000000081', 'Sex', '值有 男-女-不详', 'string', '0000000017');
INSERT INTO `output_params` VALUES ('0000000082', 'Age', '年龄，限制3位数以内', 'number', '0000000017');
INSERT INTO `output_params` VALUES ('0000000083', 'Introduction', '个人简介', 'string', '0000000017');
INSERT INTO `output_params` VALUES ('0000000084', 'CoverUrl', '用户头像', 'string', '0000000017');
INSERT INTO `output_params` VALUES ('0000000085', 'TagList', '用户标签列表', 'array', '0000000017');
INSERT INTO `output_params` VALUES ('0000000086', 'TagList-Id', '标签id', 'number', '0000000017');
INSERT INTO `output_params` VALUES ('0000000087', 'TagList-Title', '标签标题', 'string', '0000000017');
INSERT INTO `output_params` VALUES ('0000000088', 'TagList-CreateTime', '标签创建时间', 'date', '0000000017');
INSERT INTO `output_params` VALUES ('0000000089', 'TagList-UserId', '标签所属用户', 'number', '0000000017');
INSERT INTO `output_params` VALUES ('0000000090', 'TagList-ArcTicleId', '标签所属文章', 'number', '0000000017');
INSERT INTO `output_params` VALUES ('0000000091', 'TagList-Type', '标签类型 1 - 用户标签   2 - 文章标签', 'number', '0000000017');
INSERT INTO `output_params` VALUES ('0000000092', 'Id', '新增成功的数据Id', 'string', '0000000018');
INSERT INTO `output_params` VALUES ('0000000093', 'Id', '文章ID', 'number', '0000000019');
INSERT INTO `output_params` VALUES ('0000000094', 'Title', '文章标题', 'string', '0000000019');
INSERT INTO `output_params` VALUES ('0000000095', 'Author', '作者名', 'string', '0000000019');
INSERT INTO `output_params` VALUES ('0000000096', 'Brief', '文章简介', 'string', '0000000019');
INSERT INTO `output_params` VALUES ('0000000097', 'Content', '文章内容', 'string', '0000000019');
INSERT INTO `output_params` VALUES ('0000000098', 'CreateTime', '创建时间', 'date', '0000000019');
INSERT INTO `output_params` VALUES ('0000000099', 'ReadCount', '点击率', 'number', '0000000019');
INSERT INTO `output_params` VALUES ('0000000100', 'ThumbUrl', '文章缩略图', 'string', '0000000019');
INSERT INTO `output_params` VALUES ('0000000101', 'Url', '文章原图', 'string', '0000000019');
INSERT INTO `output_params` VALUES ('0000000102', 'AuthorId', '所属用户ID', 'number', '0000000019');
INSERT INTO `output_params` VALUES ('0000000103', 'TagList', '文章标签列表', 'array', '0000000019');
INSERT INTO `output_params` VALUES ('0000000104', 'TagList-Id', '标签ID', 'number', '0000000019');
INSERT INTO `output_params` VALUES ('0000000105', 'TagList-Title', '标签题目', 'string', '0000000019');
INSERT INTO `output_params` VALUES ('0000000106', 'TagList-CreateTime', '创建日期', 'date', '0000000019');
INSERT INTO `output_params` VALUES ('0000000107', 'TagList-UserId', '用户ID，如果有该数据，则表示是用户的标签，没有则是文章的标签', 'number', '0000000019');
INSERT INTO `output_params` VALUES ('0000000108', 'TagList-ArcTicleId', '所属文章id', 'number', '0000000019');
INSERT INTO `output_params` VALUES ('0000000109', 'TagList-Type', '1 - 用户标签   2 - 文章标签', 'number', '0000000019');
INSERT INTO `output_params` VALUES ('0000000110', 'Id', '新增成功的数据Id', 'number', '0000000021');
INSERT INTO `output_params` VALUES ('0000000111', 'Id', 'banner图的ID', 'number', '0000000022');
INSERT INTO `output_params` VALUES ('0000000112', 'Title', 'banner的标题', 'string', '0000000022');
INSERT INTO `output_params` VALUES ('0000000113', 'Type', '1 - 首页  2 - 用户', 'number', '0000000022');
INSERT INTO `output_params` VALUES ('0000000114', 'Url', 'banner地址', 'string', '0000000022');
INSERT INTO `output_params` VALUES ('0000000115', 'Link', 'banner对应的超链接', 'string', '0000000022');
INSERT INTO `output_params` VALUES ('0000000116', 'CreateTime', '创建时间', 'date', '0000000022');
INSERT INTO `output_params` VALUES ('0000000117', 'IsShow', '0 - 前台不展示     1 - 前台展示', 'number', '0000000022');
INSERT INTO `output_params` VALUES ('0000000118', 'UserId', '所属用户id，如果有该数据，则是用户的banner', 'number', '0000000022');
INSERT INTO `output_params` VALUES ('0000000121', 'Author', '作者名称', 'string', '0000000024');
INSERT INTO `output_params` VALUES ('0000000122', 'AuthorId', '作者ID', 'number', '0000000024');
INSERT INTO `output_params` VALUES ('0000000123', 'CreateTime', '创建时间', 'date', '0000000024');
INSERT INTO `output_params` VALUES ('0000000124', 'ReadCount', '点击率', 'number', '0000000024');
INSERT INTO `output_params` VALUES ('0000000125', 'Url', '原图', 'string', '0000000024');
INSERT INTO `output_params` VALUES ('0000000126', 'ThumbUrl', '缩略图', 'string', '0000000024');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `Id` smallint(6) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '产品表的主键id',
  `Title` varchar(100) NOT NULL DEFAULT '' COMMENT '产品的名称',
  `Url` varchar(255) NOT NULL DEFAULT '' COMMENT '产品对应的链接',
  `Description` varchar(255) DEFAULT '' COMMENT '产品描述',
  `CreateTime` datetime DEFAULT NULL COMMENT '生产产品的时间',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES ('000003', 'noven博客系统', 'noven_blog.com:3000', 'noven博客是一套个人的博客系统，一共适配PC网页端，PC客户端，Web网页端，ReactNative等四个端', '2018-04-26 20:29:10');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `Id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `NickName` char(20) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `Account` char(20) NOT NULL DEFAULT '' COMMENT '用户的账号，可以是手机号、邮箱、个性化账号',
  `CreateTime` datetime DEFAULT NULL COMMENT '创建时间',
  `Status` tinyint(10) NOT NULL DEFAULT '1' COMMENT '1 - 正常 2 - 锁定',
  `UserType` tinyint(10) DEFAULT '2' COMMENT '1 - 普通用户  2 - 管理员  3 - 超级管理员',
  `Password` char(64) NOT NULL DEFAULT '' COMMENT '用户密码',
  `LastTime` datetime DEFAULT NULL COMMENT '上次登录时间',
  `LastIp` varchar(255) DEFAULT NULL COMMENT '上次登录IP',
  `ThisTime` datetime DEFAULT NULL COMMENT '本次登录时间',
  `ThisIp` varchar(255) DEFAULT NULL COMMENT '本次登录IP',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('0000000001', '站长noven', 'admin', '2018-04-09 22:48:33', '1', '3', '7C4A8D09CA3762AF61E59520943DC26494F8941B', '2018-05-06 14:40:31', '127.0.0.1', '2018-05-30 22:37:27', '127.0.0.1');
INSERT INTO `users` VALUES ('0000000002', '雨之辰', '15181617073', '2018-04-10 21:24:58', '1', '2', '7C4A8D09CA3762AF61E59520943DC26494F8941B', '2018-04-17 21:27:55', '127.0.0.1', '2018-04-17 21:29:49', '127.0.0.1');
INSERT INTO `users` VALUES ('0000000003', '用户1', 'user', '2018-04-09 21:26:09', '1', '1', '7C4A8D09CA3762AF61E59520943DC26494F8941B', '2018-04-08 21:26:18', '127.0.0.1', '2018-04-09 21:25:38', '127.0.0.1');

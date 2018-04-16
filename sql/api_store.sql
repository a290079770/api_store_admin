/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : api_store

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-04-16 23:00:33
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
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of apis
-- ----------------------------
INSERT INTO `apis` VALUES ('0000000001', '测试api1', '测试api1', '6', 'POST', '', '0000000002');
INSERT INTO `apis` VALUES ('0000000002', '测试api2', '测试api2', '6', 'POST', '', '0000000002');
INSERT INTO `apis` VALUES ('0000000003', '测试api3', '测试api3', '7', 'GET', '', '0000000002');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `Id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT 'api分类的id',
  `Title` varchar(255) NOT NULL DEFAULT '' COMMENT '分类名',
  `ProductId` smallint(6) NOT NULL COMMENT '所属产品',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('0000000001', '测试分类1', '1');
INSERT INTO `category` VALUES ('0000000002', '测试分类2', '1');
INSERT INTO `category` VALUES ('0000000003', '测试分类3', '1');
INSERT INTO `category` VALUES ('0000000004', '测试分类4', '1');
INSERT INTO `category` VALUES ('0000000005', '测试分类5', '1');
INSERT INTO `category` VALUES ('0000000006', '按时大大大是', '2');
INSERT INTO `category` VALUES ('0000000007', '资源', '2');

-- ----------------------------
-- Table structure for input_params
-- ----------------------------
DROP TABLE IF EXISTS `input_params`;
CREATE TABLE `input_params` (
  `Id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '输入参数的id',
  `Title` varchar(255) NOT NULL DEFAULT '' COMMENT '参数名称',
  `Description` varchar(255) NOT NULL COMMENT '参数描述',
  `Type` tinyint(10) DEFAULT '1' COMMENT '参数类型 1 - number  2 - string  3-date 4 - boolean 5 - null',
  `Default` varchar(255) DEFAULT '' COMMENT '参数默认值',
  `Test` varchar(255) DEFAULT '' COMMENT '测试值',
  `IsNecessary` tinyint(1) DEFAULT '1' COMMENT '1 - 是  2 - 否',
  `ApiId` int(10) unsigned zerofill NOT NULL COMMENT '这个参数所属api',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of input_params
-- ----------------------------
INSERT INTO `input_params` VALUES ('0000000004', '3', '3', '3', '3', '3', '0', '0000000002');
INSERT INTO `input_params` VALUES ('0000000003', '1', '1', '1', '1', '1', '0', '0000000001');
INSERT INTO `input_params` VALUES ('0000000005', '5', '5', '5', '5', '5', '0', '0000000003');

-- ----------------------------
-- Table structure for output_params
-- ----------------------------
DROP TABLE IF EXISTS `output_params`;
CREATE TABLE `output_params` (
  `Id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '输出参数的id',
  `Title` varchar(255) NOT NULL DEFAULT '' COMMENT '参数名称',
  `Description` varchar(255) NOT NULL COMMENT '参数描述',
  `Type` tinyint(10) DEFAULT '1' COMMENT '参数类型 1 - number  2 - string  3-date 4 - boolean 5 - null',
  `Default` varchar(255) DEFAULT '' COMMENT '参数默认值',
  `Test` varchar(255) DEFAULT '' COMMENT '测试值',
  `IsNecessary` tinyint(1) DEFAULT '1' COMMENT '1 - 是  2 - 否',
  `ApiId` int(10) unsigned zerofill NOT NULL COMMENT '该参数所属api',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of output_params
-- ----------------------------
INSERT INTO `output_params` VALUES ('0000000004', '4', '4', '4', '4', '4', '0', '0000000002');
INSERT INTO `output_params` VALUES ('0000000003', '2', '2', '2', '2', '2', '0', '0000000001');
INSERT INTO `output_params` VALUES ('0000000005', '6', '6', '6', '6', '6', '0', '0000000003');

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
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES ('000001', '测试产品1', 'http://api.com/admin', '这是测试产品1', '2018-04-10 23:03:08');
INSERT INTO `products` VALUES ('000002', '测试产品2', 'localhost:8060/#/admin/products', '测试产品2', '2018-04-11 21:43:26');

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
  `UserType` tinyint(10) DEFAULT '1' COMMENT '1 - 普通用户  2 - 管理员  3 - 超级管理员',
  `Password` char(64) NOT NULL DEFAULT '' COMMENT '用户密码',
  `LastTime` datetime DEFAULT NULL COMMENT '上次登录时间',
  `LastIp` varchar(255) DEFAULT NULL COMMENT '上次登录IP',
  `ThisTime` datetime DEFAULT NULL COMMENT '本次登录时间',
  `ThisIp` varchar(255) DEFAULT NULL COMMENT '本次登录IP',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('0000000001', '站长noven', 'admin', '2018-04-09 22:48:33', '1', '3', '7C4A8D09CA3762AF61E59520943DC26494F8941B', '2018-04-16 21:56:34', '192.168.1.10', '2018-04-16 21:58:24', '192.168.1.10');
INSERT INTO `users` VALUES ('0000000002', '雨之辰', '15181617073', '2018-04-10 21:24:58', '1', '2', '7C4A8D09CA3762AF61E59520943DC26494F8941B', '2018-04-10 21:25:38', '127.0.0.1', '2018-04-10 21:29:08', '127.0.0.1');
INSERT INTO `users` VALUES ('0000000003', '用户1', 'user', '2018-04-09 21:26:09', '1', '1', '7C4A8D09CA3762AF61E59520943DC26494F8941B', '2018-04-08 21:26:18', '127.0.0.1', '2018-04-09 21:25:38', '127.0.0.1');

/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : zhenguan

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2017-10-28 23:26:59
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for zhenguan_category
-- ----------------------------
DROP TABLE IF EXISTS `zhenguan_category`;
CREATE TABLE `zhenguan_category` (
  `id` varchar(255) DEFAULT NULL,
  `cate_name` varchar(255) DEFAULT NULL,
  `cate_english_name` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zhenguan_category
-- ----------------------------
INSERT INTO `zhenguan_category` VALUES ('1', '品牌', 'BRAND');
INSERT INTO `zhenguan_category` VALUES ('2', '包装', 'PACKAGE');
INSERT INTO `zhenguan_category` VALUES ('3', '导视', 'GUIDES');
INSERT INTO `zhenguan_category` VALUES ('4', '空间', 'SPACE');
INSERT INTO `zhenguan_category` VALUES ('5', '新媒体', 'INTERFACE');

-- ----------------------------
-- Table structure for zhenguan_images
-- ----------------------------
DROP TABLE IF EXISTS `zhenguan_images`;
CREATE TABLE `zhenguan_images` (
  `id` varchar(255) DEFAULT NULL,
  `imgName` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `pid` varchar(255) DEFAULT NULL,
  `cate_id` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zhenguan_images
-- ----------------------------
INSERT INTO `zhenguan_images` VALUES ('1', '精致黄金效果图-01.jpg', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e7.jpg', '1', '1');
INSERT INTO `zhenguan_images` VALUES ('2', '精致黄金效果图-02.jpg', '1', '/images/product/4c95e6683b9c48098a9f440411873054.jpg', '1', '1');
INSERT INTO `zhenguan_images` VALUES ('3', '精致黄金效果图-03.jpg', '1', '/images/product/9d9d692e318541aa960bccef4952e86f.jpg', '1', '1');
INSERT INTO `zhenguan_images` VALUES ('4', '精致黄金效果图-04.jpg', '1', '/images/product/a9e81aa22c2c4c2683603f8ea4c31220.jpg', '1', '1');
INSERT INTO `zhenguan_images` VALUES ('5', '天津瀚石公寓-01.jpg', '1', '/images/product/9b60539c4b824add9f24d36f1319acbf.jpg', '2', '1');
INSERT INTO `zhenguan_images` VALUES ('6', '天津瀚石公寓-02.jpg', '1', '/images/product/2b371e9dbce843099d14151fdb9eff7a.jpg', '2', '1');
INSERT INTO `zhenguan_images` VALUES ('7', '天津瀚石公寓-03.jpg', '1', '/images/product/d745df11759c42358a8b7dc57e44277e.jpg', '2', '1');
INSERT INTO `zhenguan_images` VALUES ('8', '天津瀚石公寓-04.jpg', '1', '/images/product/71c8df3100bf4e9490a4431f3f22faa4.jpg', '2', '1');
INSERT INTO `zhenguan_images` VALUES ('9', '天津瀚石公寓-05.jpg', '1', '/images/product/b7fbc554c05646d2bad9c76a93f87e09.jpg', '2', '1');
INSERT INTO `zhenguan_images` VALUES ('10', '天津瀚石公寓-06.jpg', '1', '/images/product/caae7f4ffd6b4aecb5cb7654d462cec5.jpg', '2', '1');
INSERT INTO `zhenguan_images` VALUES ('11', '天津瀚石公寓-07.jpg', '1', '/images/product/c5fd479ba9a144d9a80a2c132efb7f5a.jpg', '2', '1');
INSERT INTO `zhenguan_images` VALUES ('12', '中国青年主题创意大赛-01.jpg', '1', '/images/product/338085d4831942a3b7d689d867e02243.jpg', '3', '1');
INSERT INTO `zhenguan_images` VALUES ('13', '中国青年主题创意大赛-02.jpg', '1', '/images/product/7c2aa3e6e7ee4ecf8c85eaf5127752da.jpg', '3', '1');
INSERT INTO `zhenguan_images` VALUES ('14', '中国青年主题创意大赛-03.jpg', '1', '/images/product/1d1e826cb6e6496490a83ef36faf9397.jpg', '3', '1');
INSERT INTO `zhenguan_images` VALUES ('15', '中国青年主题创意大赛-04.jpg', '1', '/images/product/6e0f148d0190486696ad176eec882e5d.jpg', '3', '1');
INSERT INTO `zhenguan_images` VALUES ('16', '中国青年主题创意大赛-05.jpg', '1', '/images/product/ac0fa30669194c458fde7af9754272ee.jpg', '3', '1');
INSERT INTO `zhenguan_images` VALUES ('17', '金丰元投资-01.jpg', '1', '/images/product/06e7d1a384c34aa786fdb2d35e073360.jpg', '4', '1');
INSERT INTO `zhenguan_images` VALUES ('18', '金丰元投资-02.jpg', '1', '/images/product/05c20755505341d7a27542f82133590d.jpg', '4', '1');
INSERT INTO `zhenguan_images` VALUES ('19', 'Panda！-01.jpg', '1', '/images/product/1fed812e1489443689cf0cef8dd670ec.jpg', '5', '1');
INSERT INTO `zhenguan_images` VALUES ('20', 'Panda！-02.jpg', '1', '/images/product/2dcfccc328f94dbda37cd462345e1724.jpg', '5', '1');
INSERT INTO `zhenguan_images` VALUES ('21', '大白熊商务航空-01.jpg', '1', '/images/product/2eb6cf320fba4e2faf16daeac41901e4.jpg', '6', '1');
INSERT INTO `zhenguan_images` VALUES ('22', '大白熊商务航空-02.jpg', '1', '/images/product/c428cca62a3e4a6593ee6ea13db6c89c.jpg', '6', '1');
INSERT INTO `zhenguan_images` VALUES ('23', '大白熊商务航空-03.jpg', '1', '/images/product/5d2e535907db4597b230cde69ea05082.jpg', '6', '1');
INSERT INTO `zhenguan_images` VALUES ('24', '大白熊商务航空-04.jpg', '1', '/images/product/b79bad450b934b8086de47429bc0a847.jpg', '6', '1');
INSERT INTO `zhenguan_images` VALUES ('25', '北京财富会所-01.jpg', '1', '/images/product/ead7bb68fe604370b0c12996db12fc75.jpg', '7', '1');
INSERT INTO `zhenguan_images` VALUES ('26', '北京财富会所-02.jpg', '1', '/images/product/bf6ad2d634504dac9e1791b421aa0643.jpg', '7', '1');
INSERT INTO `zhenguan_images` VALUES ('27', '北京财富会所-03.jpg', '1', '/images/product/29a366978e4744cf9df977ad82af6894.jpg', '7', '1');
INSERT INTO `zhenguan_images` VALUES ('28', '北京财富会所-04.jpg', '1', '/images/product/fff84eae72934ff38c9f6ba3ac85a72a.jpg', '7', '1');
INSERT INTO `zhenguan_images` VALUES ('29', '画皮II-01.jpg', '1', '/images/product/1d0b419c87414490868c5e32d0b36442.jpg', '8', '1');
INSERT INTO `zhenguan_images` VALUES ('30', '画皮II-02.jpg', '1', '/images/product/ae128eb59b424943b9794c1764808e82.jpg', '8', '1');
INSERT INTO `zhenguan_images` VALUES ('31', '画皮II-03.jpg', '1', '/images/product/5c0b7d330788476280a16f4f5642eb02.jpg', '8', '1');
INSERT INTO `zhenguan_images` VALUES ('32', '画皮II-04.jpg', '1', '/images/product/680a2fa9beae4d5fb9c6087e2900cfa1.jpg', '8', '1');
INSERT INTO `zhenguan_images` VALUES ('33', '画皮II-05.jpg', '1', '/images/product/2906da11a7f54adda37f68d9a332d17d.jpg', '8', '1');
INSERT INTO `zhenguan_images` VALUES ('34', '画皮II-06.jpg', '1', '/images/product/4c2d36b842e04ae38f26e355cb2a9b68.jpg', '8', '1');
INSERT INTO `zhenguan_images` VALUES ('35', '画皮II-07.jpg', '1', '/images/product/1fe3f1d7d7564e03b800d1d1b52765ae.jpg', '8', '1');
INSERT INTO `zhenguan_images` VALUES ('36', '画皮II-08.jpg', '1', '/images/product/aa0ade567b604de5bc420317686b7503.jpg', '8', '1');
INSERT INTO `zhenguan_images` VALUES ('37', '京城畅航-01.jpg', '1', '/images/product/f331f3b02ffa4e639b4544b59ef1d06a.jpg', '9', '1');
INSERT INTO `zhenguan_images` VALUES ('38', '京城畅航-02.jpg', '1', '/images/product/f579936992144e08a1c4719d738633d2.jpg', '9', '1');
INSERT INTO `zhenguan_images` VALUES ('39', '京城畅航-03.jpg', '1', '/images/product/001fa1abefd04d9db3c0647d70ea7118.jpg', '9', '1');
INSERT INTO `zhenguan_images` VALUES ('40', '京城畅航-04.jpg', '1', '/images/product/60db7847a23949558e3c01914bd55cad.jpg', '9', '1');
INSERT INTO `zhenguan_images` VALUES ('41', '安至选-01.jpg', '1', '/images/product/80b2e165c9c7447faac8658306c7496a.jpg', '10', '1');
INSERT INTO `zhenguan_images` VALUES ('42', '安至选-02.jpg', '1', '/images/product/b6b09696bab8496ab363a20ef7c2b9b9.jpg', '10', '1');
INSERT INTO `zhenguan_images` VALUES ('43', '安至选-03.jpg', '1', '/images/product/354cc4c7cdac4f43979e4958e269f193.jpg', '10', '1');
INSERT INTO `zhenguan_images` VALUES ('44', '安至选-04.jpg', '1', '/images/product/df527093f31e4b38b8b442bd678fecae.jpg', '10', '1');
INSERT INTO `zhenguan_images` VALUES ('45', '中国油画院-04.jpg', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e51.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('46', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e52.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('47', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e53.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('48', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e54.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('49', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e55.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('50', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e56.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('51', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e57.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('52', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e58.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('53', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e59.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('54', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e60.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('55', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e61.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('56', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e62.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('57', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e63.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('58', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e64.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('59', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e65.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('60', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e66.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('61', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e67.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('62', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e68.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('63', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e69.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('64', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e70.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('65', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e71.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('66', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e72.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('67', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e73.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('68', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e74.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('69', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e75.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('70', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e76.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('71', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e77.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('72', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e78.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('73', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e79.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('74', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e80.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('75', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e81.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('76', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e82.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('77', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e83.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('78', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e84.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('79', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e85.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('80', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e86.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('81', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e87.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('82', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e88.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('83', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e89.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('84', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e90.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('85', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e91.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('86', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e92.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('87', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e93.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('88', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e94.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('89', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e95.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('90', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e96.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('91', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e97.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('92', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e98.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('93', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e99.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('94', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e100.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('95', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e101.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('96', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e102.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('97', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e103.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('98', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e104.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('99', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e105.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('100', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e106.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('101', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e107.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('102', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e108.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('103', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e109.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('104', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e110.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('105', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e111.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('106', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e112.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('107', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e113.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('108', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e114.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('109', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e115.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('110', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e116.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('111', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e117.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('112', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e118.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('113', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e119.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('114', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e120.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('115', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e121.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('116', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e122.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('117', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e123.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('118', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e124.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('119', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e125.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('120', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e126.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('121', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e127.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('122', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e128.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('123', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e129.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('124', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e130.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('125', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e131.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('126', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e132.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('127', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e133.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('128', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e134.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('129', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e135.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('130', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e136.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('131', '', '1', '/images/product/469253d987e44c30ad6ebabcaef9f5e137.jpg', '', '1');
INSERT INTO `zhenguan_images` VALUES ('132', '', '', '', '', '1');
INSERT INTO `zhenguan_images` VALUES ('133', '', '', '', '', '1');
INSERT INTO `zhenguan_images` VALUES ('134', '', '', '', '', '1');
INSERT INTO `zhenguan_images` VALUES ('135', '', '', '', '', '1');
INSERT INTO `zhenguan_images` VALUES ('136', '', '', '', '', '1');
INSERT INTO `zhenguan_images` VALUES ('137', '', '', '', '', '1');
INSERT INTO `zhenguan_images` VALUES ('138', '', '', '', '', '1');
INSERT INTO `zhenguan_images` VALUES ('139', '', '', '', '', '1');
INSERT INTO `zhenguan_images` VALUES ('140', '', '', '', '', '1');
INSERT INTO `zhenguan_images` VALUES ('141', '', '', '', '', '1');
INSERT INTO `zhenguan_images` VALUES ('142', '', '', '', '', '1');
INSERT INTO `zhenguan_images` VALUES ('143', '', '', '', '', '1');
INSERT INTO `zhenguan_images` VALUES ('144', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('145', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('146', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('147', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('148', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('149', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('150', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('151', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('152', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('153', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('154', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('155', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('156', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('157', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('158', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('159', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('160', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('161', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('162', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('163', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('164', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('165', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('166', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('167', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('168', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('169', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('170', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('171', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('172', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('173', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('174', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('175', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('176', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('177', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('178', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('179', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('180', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('181', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('182', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('183', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('184', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('185', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('186', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('187', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('188', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('189', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('190', '', '', '', '', '');
INSERT INTO `zhenguan_images` VALUES ('191', '', '', '', '', '');

-- ----------------------------
-- Table structure for zhenguan_product
-- ----------------------------
DROP TABLE IF EXISTS `zhenguan_product`;
CREATE TABLE `zhenguan_product` (
  `id` varchar(255) DEFAULT NULL,
  `project_name` varchar(255) DEFAULT NULL,
  `cate_id` varchar(255) DEFAULT NULL,
  `server` varchar(255) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `client` varchar(255) DEFAULT NULL,
  `isPublic` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zhenguan_product
-- ----------------------------
INSERT INTO `zhenguan_product` VALUES ('1', '精致黄金', '1', 'logo／品牌视觉／产品手册', '2015.03', '周大福', '1');
INSERT INTO `zhenguan_product` VALUES ('2', '天津瀚石公寓', '1', 'logo/VI/品牌视觉', '2015.03', '北京唯度控股', '1');
INSERT INTO `zhenguan_product` VALUES ('3', '中国青年主题创意大赛', '1', '品牌视觉／网站', '2015.03', '中国青年主题创意大赛', '1');
INSERT INTO `zhenguan_product` VALUES ('4', '金丰元投资', '1', 'logo／VI／网站', '2015.03', '金丰元投资', '1');
INSERT INTO `zhenguan_product` VALUES ('5', 'Panda！', '1', 'logo／主视觉', '2015.03', '美国环球熊猫娱乐', '1');
INSERT INTO `zhenguan_product` VALUES ('6', '大白熊商务航空', '1', 'logo／VI', '2015.03', '北京大白熊商务航空', '1');
INSERT INTO `zhenguan_product` VALUES ('7', '北京财富会所', '1', 'logo／VI／品牌视觉／产品手册', '2015.03', '财富联合集团', '1');
INSERT INTO `zhenguan_product` VALUES ('8', '画皮II', '1', 'logo／海报／画册', '2015.03', '麒麟影业', '1');
INSERT INTO `zhenguan_product` VALUES ('9', '京城畅航', '1', 'logo/VI/品牌视觉', '2015.03', '京城畅航文化发展有限公司', '1');
INSERT INTO `zhenguan_product` VALUES ('10', '安至选', '1', 'logo／VI／品牌视觉／产品包装', '2015.03', '中粮集团', '1');
INSERT INTO `zhenguan_product` VALUES ('11', '中国油画院', '1', 'logo／VI', '2015.03', '中国油画院', '1');
INSERT INTO `zhenguan_product` VALUES ('12', '财富海湾大酒店', '1', 'logo／VI／导视', '2015.03', '财富联合集团', '1');
INSERT INTO `zhenguan_product` VALUES ('13', '撞衫', '1', 'logo／主视觉', '2015.03', '撞衫', '1');
INSERT INTO `zhenguan_product` VALUES ('14', 'hello kitty & 周大福', '1', '主视觉／产品手册', '2015.03', '周大福', '1');
INSERT INTO `zhenguan_product` VALUES ('15', '中投万通', '1', 'logo／VI', '2015.03', '中投万通', '1');
INSERT INTO `zhenguan_product` VALUES ('16', '拉面道场', '1', 'logo／主视觉', '2015.03', '拉面道场', '1');
INSERT INTO `zhenguan_product` VALUES ('17', '梓楠', '1', 'logo／主视觉', '2015.03', '梓楠', '1');
INSERT INTO `zhenguan_product` VALUES ('18', '颐园', '1', 'logo／主视觉', '2015.03', '颐园', '1');
INSERT INTO `zhenguan_product` VALUES ('19', '智雍商学院', '1', 'logo／主视觉', '2015.03', '智雍商学院', '1');
INSERT INTO `zhenguan_product` VALUES ('20', '春光乍现', '1', '画册／主视觉', '2015.03', '春光乍现', '1');
INSERT INTO `zhenguan_product` VALUES ('21', 'AKCWH', '1', 'logo', '2015.03', 'AKCWH', '1');
INSERT INTO `zhenguan_product` VALUES ('22', '京港物流园', '1', 'logo／VI', '2015.03', '唯度控股', '0');
INSERT INTO `zhenguan_product` VALUES ('23', '增减', '1', 'logo／VI／品牌视觉／产品手册', '2015.03', '增减', '1');
INSERT INTO `zhenguan_product` VALUES ('24', '新天域资本', '1', '品牌视觉', '2015.03', '新天域资本', '0');
INSERT INTO `zhenguan_product` VALUES ('25', '云居别院', '1', 'logo／VI／品牌视觉', '2015.03', '云居别院', '1');
INSERT INTO `zhenguan_product` VALUES ('26', 'WINPOUND', '1', 'logo', '2015.03', 'WINPOUND', '1');
INSERT INTO `zhenguan_product` VALUES ('27', 'SEESEE!', '1', 'logo／VI／品牌视觉／微站', '2015.03', '稼轩投资', '0');
INSERT INTO `zhenguan_product` VALUES ('28', '中国城市文产联盟', '1', 'logo／VI／品牌视觉／产品手册', '2015.03', '中国城市文产联盟', '0');
INSERT INTO `zhenguan_product` VALUES ('29', '中国三匚创意集团', '1', 'logo／VI／品牌视觉／年度合作', '2015.03', '中国三匚创意集团', '0');
INSERT INTO `zhenguan_product` VALUES ('30', '嘉华国际影城', '1', 'logo／VI／品牌视觉／网站', '2015.03', '嘉华国际影城', '1');
INSERT INTO `zhenguan_product` VALUES ('31', '吉天利', '1', '品牌视觉', '2015.03', '吉天利集团', '0');
INSERT INTO `zhenguan_product` VALUES ('32', '国能中电', '1', '画册形象', '2015.03', '国能中电', '1');
INSERT INTO `zhenguan_product` VALUES ('33', '璀璨之旅', '1', '周大福', '2015.03', '周大福', '1');
INSERT INTO `zhenguan_product` VALUES ('34', '北世投资集团', '1', 'logo／VI', '2015.03', '北世投资集团', '0');
INSERT INTO `zhenguan_product` VALUES ('35', '时怡坚果大礼盒', '2', '包装设计 快消食品', '2015.03', '中粮集团', '1');
INSERT INTO `zhenguan_product` VALUES ('36', 'tenone 腾欢儿童奶酪', '2', '包装／快消', '2015.03', '中粮集团', '1');
INSERT INTO `zhenguan_product` VALUES ('37', '凯捷茶庄', '2', '包装快消', '2015.03', '凯捷茶庄', '0');
INSERT INTO `zhenguan_product` VALUES ('38', '露露', '2', '包装／快消', '2015.03', '中粮集团', '0');
INSERT INTO `zhenguan_product` VALUES ('39', '金帝巧克力', '2', '包装／快消', '2015.03', '金帝巧克力', '1');
INSERT INTO `zhenguan_product` VALUES ('40', '安至选生鲜', '2', '包装设计 快消食品', '2015.03', '中粮集团', '1');
INSERT INTO `zhenguan_product` VALUES ('41', '三亚财富海湾大酒店', '3', '空间导视', '2015.03', '财富联合集团', '0');
INSERT INTO `zhenguan_product` VALUES ('42', '三匚创意汇', '3', '空间导视', '2015.03', '三匚集团', '1');
INSERT INTO `zhenguan_product` VALUES ('43', '唯度控股', '3', '空间导视', '2015.03', '唯度控股', '1');
INSERT INTO `zhenguan_product` VALUES ('44', '北京财富会所', '3', '导视', '2015.03', '财富联合集团', '0');
INSERT INTO `zhenguan_product` VALUES ('45', '万达展厅', '4', '空间／装饰', '2015.03', '万达展厅', '0');
INSERT INTO `zhenguan_product` VALUES ('46', '万通餐厅', '4', '空间／装饰', '2015.03', '万通餐厅', '0');
INSERT INTO `zhenguan_product` VALUES ('47', '亦庄', '4', '空间／装饰', '2015.03', '亦庄', '1');
INSERT INTO `zhenguan_product` VALUES ('48', '李宁展厅', '4', '空间／装饰', '2015.03', '李宁展厅', '1');
INSERT INTO `zhenguan_product` VALUES ('49', '李宁博物馆', '4', '空间／装饰', '2015.03', '李宁展厅', '0');
INSERT INTO `zhenguan_product` VALUES ('50', '国家剧院', '4', '空间／装饰', '2015.03', '国家剧院', '0');
INSERT INTO `zhenguan_product` VALUES ('51', '太阳城', '4', '空间／装饰', '2015.03', '太阳城', '1');
INSERT INTO `zhenguan_product` VALUES ('52', '蒋府庄园', '4', '空间／装饰', '2015.03', '蒋府庄园', '1');
INSERT INTO `zhenguan_product` VALUES ('53', '平房', '4', '空间／装饰', '2015.03', '平房', '0');
INSERT INTO `zhenguan_product` VALUES ('54', '儿童城', '4', '空间／装饰', '2015.03', '儿童城', '0');
INSERT INTO `zhenguan_product` VALUES ('55', '房山政府', '4', '空间／装饰', '2015.03', '房山政府', '0');
INSERT INTO `zhenguan_product` VALUES ('56', '通州玉桥', '4', '空间／装饰', '2015.03', '通州玉桥', '0');
INSERT INTO `zhenguan_product` VALUES ('57', '老城堡', '4', '空间／装饰', '2015.03', '老城堡', '1');
INSERT INTO `zhenguan_product` VALUES ('58', '远洋办公楼', '4', '空间／装饰', '2015.03', '远洋办公', '0');
INSERT INTO `zhenguan_product` VALUES ('59', '中研国际', '4', '空间／装饰', '2015.03', '中研国际', '1');
INSERT INTO `zhenguan_product` VALUES ('60', '远洋放样板间', '4', '空间／装饰', '2015.03', '远洋放样板间', '0');
INSERT INTO `zhenguan_product` VALUES ('61', '远洋国际中心', '4', '空间／装饰', '2015.03', '远洋国际中心', '0');
INSERT INTO `zhenguan_product` VALUES ('62', '远洋自然', '4', '空间／装饰', '2015.03', '远洋自然', '0');
INSERT INTO `zhenguan_product` VALUES ('63', '金丰元', '5', '多媒体／网页', '2015.03', '金丰元投资', '0');
INSERT INTO `zhenguan_product` VALUES ('64', '嘉华国际影城', '5', '多媒体，界面', '2015.03', '嘉华国际', '0');
INSERT INTO `zhenguan_product` VALUES ('65', '北京财富会所', '5', '网页设计', '2015.03', '财富联合集团', '0');
INSERT INTO `zhenguan_product` VALUES ('66', '中国城市文产联盟', '5', '网页设计', '2015.03', '校购网', '0');
INSERT INTO `zhenguan_product` VALUES ('67', '金钟国演唱会', '5', '多媒体／界面', '2015.03', '稼轩投资', '1');
INSERT INTO `zhenguan_product` VALUES ('68', '柚子茶', '5', '多媒体／网页', '2015.03', '柚子茶', '0');

-- ----------------------------
-- Table structure for zhenguan_users
-- ----------------------------
DROP TABLE IF EXISTS `zhenguan_users`;
CREATE TABLE `zhenguan_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `account` varchar(18) NOT NULL COMMENT '登录账号',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `nickName` varchar(18) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `age` int(3) unsigned NOT NULL DEFAULT '0' COMMENT '用户年龄',
  `sex` varchar(2) NOT NULL DEFAULT '男' COMMENT '性别 男 女 保密',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zhenguan_users
-- ----------------------------
INSERT INTO `zhenguan_users` VALUES ('1', '15181617073', '123456', 'zhangsan', '18', '男');
INSERT INTO `zhenguan_users` VALUES ('2', '15181617072', '123456', 'li4', '20', '女');

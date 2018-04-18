该项目是我的api文档仓库

前端界面是 Vue 开发

后台API是 PHP 开发

运行项目的方式

1、克隆项目到本地

2、首先跑起前台服务
  a、安装nodeJs
  
  b、在当前项目的根目录下
  
  ``` bash
    # 安装依赖
    npm install

    # 运行本地node服务 at localhost:8080
    npm run dev

    # 你也可以编译打包前台页面到你自己的服务器下
    npm run build
 ```
 
  注意：前台页面配置的api路径默认是 api.com/admin
  所以如果你需要上线到你自身的服务器下，就需要更改api路径
  目录：/src/http.js      
  修改：apiUrl = 'http://api.com/admin';  //到你自己的api路径
  

3、如果你想直接用本项目的后台，就需要跑起来后台服务

  a、本项目后台是PHP开发，所以最开始你需要安装PHP环境、apache服务器、mysql等等，这里推荐直接安装 phpstudy 或 其他应用，一键构建
  
  b、因为本项目api接口是虚拟主机，所以需要先配置虚拟主机相关
  
     ``` bash
        # 进入你的apache服务器目录
        如我的： E:\phpstudy\Apache\conf

        # 修改 httpd.conf 配置文件
        去掉：#Include conf/extra/httpd-vhosts.conf   之前的 # 号，目的是允许启用虚拟主机的配置文件
        重启服务器

        # 配置api.com的虚拟主机，进入目录 E:\phpstudy\Apache\conf\extra，注意这个目录是我的，你对应找自己的，修改httpd-vhosts.conf文件，
        任意位置，添加如下代码
        <VirtualHost *:80>
           DocumentRoot "E:\phpstudy\WWW\api\public"
           ServerName api.com
        </VirtualHost>
        
        注意：DocumentRoot是虚拟主机的目录，如果你是用phpstudy，可以将api接口放在www文件夹下，其他应用可以参考或百度谷歌：
        
        # 修改 hosts 文件
        进入目录 C:\Windows\System32\drivers\etc，这个应该是windows通用的
        修改hosts文件，最末尾添加一行 
        127.0.0.1       api.com 
        目的是将api.com的dns解析到 127.0.0.1这个ip下，也就是本地服务器
        
        注意：这里可以你在保存hosts文件的时候会给你提示不能在当前目录下修改文件，或权限不够，你可以将hosts拖出到桌面，修改完成后，拖回这个目录
        重启服务器
     ```
     
   c、完成虚拟主机配置后，只差最后一步
      将本项目根目录下的  /api 文件夹整个拖入到 E:\phpstudy\WWW\ 下 ,再次说明，这个目录是我电脑的
      
   e、导入数据库
      将本项目根目录下的 /sql 文件夹中的 sql 文件导入到你自己的mysql中，如果你不会，可以参照如下方式
       ``` bash
          ①、安装Navicat Premium 图形化界面
          ②、记得运行起phpstudy等php环境
          ③、运行Navicat Premium，点击连接 - 输入密码 root - 点击确定
          ④、左侧会出现localhost_3306,双击 出现information_schema、mysql、performance_schema、test等四个数据库
          ⑤、右击localhost_3306，新建数据库，
             数据库名：api_store
             字符集:utf8 最下面
             排序规则：utf8_general_ci
          ⑥、双击api_store，右键 api_store，导入sql，然后选择本项目的sql/sql文件，一路下一步点下去就好
       ```
      
   d、至此，完成后台的本机部署，可以运行尝试检验 
      浏览器打开   api.com/admin/user/userList    看能否获取到数据
      
 4、至此，前台就能访问到后台api了，整个系统在本机部署完成，有疑问可以Issues 或联系 QQ290079770

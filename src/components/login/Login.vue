<template>
  <div class="login" :style='winSize'>
    <div class="content-title login-content-title">
      <div class="content-title-right">
        <i class="el-icon-minus" @click="resizeMin"></i>
        <i class="el-icon-more" @click="resizeMax"></i>
        <i class="el-icon-close" @click="closeForm"></i>
      </div>
    </div>
    <el-row>
      <el-col :span='24'>
        <div class="content">
          <el-form 
          label-position='left' 
          label-width='0px' 
          class='card-box loginform' 
          :style='formOffset' 
          :model='userInfo' 
          :rules='rule_data' 
          ref='userInfo' 
          v-loading="loading" 
          element-loading-text="系统登录中,请稍后..."
          @keyup.enter.native="loginIn('userInfo')"
          >
            <div style='text-align: center;'>
              <span>KOI后台管理系统</span>
              <!-- <img src="../../../static/images/logo_bak.png" height="40px" width="200px" alt="logo"> -->
            </div>
            <h3 class="title">用户登录</h3>
            <input type="text" style="display:none">
            <input type="password" style="display:none">
            <el-form-item prop='username'>
              <el-input type="text" auto-complete="off" autocorrect="off" autocapitalize="off" spellcheck="false" placeholder="用户名/邮箱" v-model='userInfo.username' @change="isChange=true">
                <template slot="prepend"><i class="el-icon-mobile-phone"></i></template>
              </el-input>
            </el-form-item>
            <el-form-item prop='password'>
              <el-input type="password" auto-complete="off" placeholder="密码" autocorrect="off" autocapitalize="off" spellcheck="false" v-model='userInfo.password' @keyup.enter="loginIn('userInfo')" @change="isChange=true">
                <template slot="prepend"><i class="el-icon-time"></i></template>
              </el-input>
            </el-form-item>
            <el-col :span='5'>
              <el-form-item>
                <el-tooltip class="item" effect="dark" content="记住密码" placement="bottom">
                  <el-switch v-model="remumber" @change="switchChecked"></el-switch>
                </el-tooltip>
              </el-form-item>
            </el-col>
            <el-col :span='7'>
               &nbsp;
              <!-- <router-link to='/retrievePwd' class='retrieve-password'>忘记密码？</router-link> -->
            </el-col>
            <el-col :span='12' >
              <el-form-item>
                <el-button type="primary" @click="loginIn('userInfo')">登录</el-button>
                <el-button @click="reset('userInfo')">重置</el-button>
              </el-form-item>
            </el-col>
          </el-form>
        </div>
      </el-col>
    </el-row>
  </div>
</template>
<script>
import qs from 'qs';
export default {
  name: 'login',
  data() {
    const CheckLoginPsd = (rule, value, callback) => {
      let psdReg = /^\d{6,12}$/;
      if (value === '') {
        return callback(new Error('密码不能为空！'));
      }else {
        return callback()
      }
    };
    return {
      loading: false,
      userInfo: {
        username: '',
        password: '',
      },

      isChange:false,

      winSize: {
        width: '',
        height: ''
      },
      formOffset: {
        position: 'absolute',
        left: '',
        top: ''
      },
      remumber: eval(sessionStorage.getItem('remumber')) || eval(localStorage.getItem('remumber')),
      rule_data: {
        username: [{
          required: true,
          message: '用户名不能为空！',
          trigger: 'blur'
        }],
        password: [{
          validator:CheckLoginPsd,
          required: true,
          trigger: 'blur'
        }],
      }
    }
  },

  methods: {
    setLoginSize() {
      this.winSize.width = window.innerWidth + 'px';
      this.winSize.height = window.innerHeight + 'px';

      this.formOffset.left = (parseInt(this.winSize.width) / 2 - 175) + 'px';
      this.formOffset.top = (parseInt(this.winSize.height) / 2 - 178) + 'px';
    },

    //切换是否记住密码功能
    switchChecked() {
      localStorage.setItem('remumber', !this.remumber);
      sessionStorage.setItem('remumber', !this.remumber);
    },

    //登录系统
    loginIn(userInfo) {

      this.$refs[userInfo].validate((valid) => {
        if (valid) {

          var activePwd = sessionStorage.getItem('password') ? sessionStorage.getItem('password') : (localStorage.getItem('userInfo.password') ? localStorage.getItem('userInfo.password') : '');

          if (this.userInfo.password !== activePwd) {
            this.userInfo.password = hex_sha1(this.userInfo.password);
          }
          this.loading = true;
          this.$http.post('/passport/login?random=' + Math.random(), this.userInfo)
            .then((res) => {
              this.loading = false;
              switch (res.data.Code) {
                 case 200:

                 if(res.data.Data.UserType === 4) {
                       this.$message({
                          message: '您没有权限登录管理后台！',
                          type: 'error'
                        });

                       return;
                   }

                  if (this.remumber == true) {
                    localStorage.setItem('userInfo.password', this.userInfo.password);
                    sessionStorage.setItem('password', this.userInfo.password);
                  } else {
                    localStorage.removeItem('userInfo.password');
                    sessionStorage.removeItem('password');
                  }
                  localStorage.setItem('userInfo.username', this.userInfo.username);
//                localStorage.setItem('userInfo.nickname', res.data.Data.NickName);
                  localStorage.setItem('userInfo.nickname', "张三");
                  localStorage.setItem('userInfo.UserType', res.data.Data.UserType);
                  sessionStorage.setItem('userType',  res.data.Data.UserType);
                  sessionStorage.setItem('nickname',  res.data.Data.RealName);
                  sessionStorage.setItem('username', this.userInfo.username);
                  sessionStorage.setItem('remumber', this.remumber);
                  sessionStorage.setItem('userId', res.data.Data.Id);
                  this.$message({
                    message: '欢迎登录KOI后台管理系统',
                    type: 'success'
                  });
//                sessionStorage.setItem('userInfoIsA',!res.data.Data.IsSupperAdmin);
//                sessionStorage.setItem('userInfoIsS',res.data.Data.IsSupperAdmin);
//                console.log('Hello');
                  this.$router.push({path:'/admin',query:{}});
//                countRes = 0;
                  break;
                case 34:
                  return;
                  break;
                case 22:
                  if (res.data.Description.indexOf('手机') !== -1) {
                    this.$message({
                      message: res.data.Description,
                      type: 'error',
                      duration: 2000,
                      onClose: () => {
                        this.userInfo.username = ''
                      }
                    })
                  } else if (res.data.Description.indexOf('密码') !== -1) {
                    this.$message({
                      message: res.data.Description,
                      type: 'error',
                      duration: 2000,
                      onClose: () => {
                        this.userInfo.password = ''
                      }
                    })
                  } else if (res.data.Description.indexOf('权限') !== -1) {
                    this.$message({
                      message: res.data.Description,
                      type: 'error',
                      duration: 2000,
                      onClose: () => {
                        this.userInfo.password = ''
                      }
                    })
                  }else if (res.data.Description.indexOf('注册') !== -1) {
                    this.$message({
                      message: res.data.Description,
                      type: 'error',
                      duration: 2000,
                      onClose: () => {
                        this.userInfo.username = '',
                        this.userInfo.password = ''
                      }
                    })
                  }
                  break;
                case 32:
                  this.$confirm('该用户已被锁定，请联系管理员进行解锁！', '提示', {
                    confirmButtonText: '确定',
                    showCancelButton: false,
                    type: 'error'
                  })
                  break;
                case 16:
                  this.$confirm('账号或密码错误！', '提示', {
                    confirmButtonText: '确定',
                    showCancelButton: false,
                    type: 'error'
                  })
                  break;
                case 33:
                  this.$confirm('该用户还未激活，请先联系管理员进行激活！', '提示', {
                    confirmButtonText: '确定',
                    showCancelButton: false,
                    type: 'error'
                  })
                  break;
                default:
                  break;
              }
            })
            .catch((err) => {
              console.log(err)
            })
        } else {
          return false;
        }
      });
    },

    //重置用户名和密码
    reset(userInfo) {
      this.$refs[userInfo].resetFields();
    },
    /**
   * [resizeMin 下面是winform提供的窗口缩放方法]
   * @Author   罗文
   * @DateTime 2017-11-01
   * @return   {[type]}   [description]
   */
    resizeMin() {
      Minimize();
    },
    resizeMax() {
      Maximize();
    },
    closeForm() {
      this.$confirm('确认关闭?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
           Close();
        }).catch(() => {
      
        });
    },
  },
  mounted() {
    this.setLoginSize();
    //动态监测浏览器窗口变化
    window.onresize = () => {
      this.setLoginSize();
    };
    // hex_sha1(this.userInfo.password)
    //如果sessionStorage或localStorage中存在有值,就直接获取sessionStorage或localStorage中的值
    if (sessionStorage.getItem('username') && sessionStorage.getItem('username') != '') {
      this.userInfo.username = sessionStorage.getItem('username');
      this.userInfo.password = sessionStorage.getItem('password') ? sessionStorage.getItem('password') : (localStorage.getItem('userInfo.password') ? localStorage.getItem('userInfo.password') : '');
    } else {
      this.userInfo.username = localStorage.getItem('userInfo.username') ? localStorage.getItem('userInfo.username') : "";
      if (this.userInfo.username == '') {
        this.userInfo.password = '';
      } else {
        this.userInfo.password = localStorage.getItem('userInfo.password') ? localStorage.getItem('userInfo.password') : "";
      }
    }
  },
  watch: {
    'userInfo.username': function(newVal, oldVal) {
      if (!newVal || newVal.length == 1) {
        this.userInfo.password = '';
      }
    }
  }
}
</script>
<style lang="less" scoped>
.el-form-item__error {
  margin-left: 38px;
}

.login {
  background: #e9ecf3;
  .card-box {
    box-shadow: 0 0px 8px 0 rgba(0, 0, 0, 0.06), 0 1px 0px 0 rgba(0, 0, 0, 0.02);
    -webkit-border-radius: 5px;
    border-radius: 5px;
    -moz-border-radius: 5px;
    background-clip: padding-box;
    margin-bottom: 20px;
    background-color: #fff;
    border: 2px solid #e7ecf1;
  }
  .title {
    margin: 10px auto 20px auto;
    text-align: center;
    color: #505458;
    font-family: 'PingFang SC';
  }
  .loginform {
    width: 335px;
    padding: 35px 35px 20px 35px;
  }
  .retrieve-password {
    line-height: 46px;
    font-size: 12px;
    color: red;
  }
}

.login-content-title {
   border-bottom: none;
   box-shadow: 0px 0px 0px #e9ecf3;
   background: #e9ecf3;
   -webkit-app-region: drag;
}

.content-title-right {
   display: flex;
   justify-content: center;
   align-items: center;
   height: 40px;
   width: 140px;
   -webkit-app-region: no-drag;
   transition: all ease-in-out 0.3s;
}

.login-content-title:hover .content-title-right {
   background: #0393e8;
   color: white;
}


.content-title-right i:hover {
  background: #2b579a
}
</style>

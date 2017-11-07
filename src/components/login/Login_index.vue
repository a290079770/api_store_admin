<template>
  <div class="login" :style="{width:winWidth +'px',height:winHeight +'px'}">
     <h1 
     :style="{top:headTop +'px',opacity:headTop/100 * 2}"
     ref="headShake"
     @mouseenter="headShakeAnimate"
     @mouseleave="clearHeadShakeAnimate"
     >
       欢迎登陆NOVEN的专属API管理后台
     </h1>
     <img 
     src="../../assets/login-start.png"  
     :width="imgWidth"
     :style="{left:imgLeft + '%'}"
     class="login-start" 
     @mouseenter="imgWidth *= 1.1"
     @mouseleave="imgWidth /= 1.1"
     @click="openLoginForm"
     >

     <div class="content">
          <el-form 
          label-position='left' 
          label-width='0px' 
          class='card-box loginform' 
          :style='{left:formLeft + "%",opacity:formOpacity}' 
          :model='userInfo' 
          :rules='rule_data' 
          ref='userInfo' 
          @keyup.enter.native="loginIn('userInfo')"
          >

          <!-- v-loading="loading"  -->
          <!-- element-loading-text="系统登录中,请稍后..." -->
            <div style='text-align: center;'>
              <!-- <img src="../../../static/images/logo_bak.png" height="40px" width="200px" alt="logo"> -->
            </div>
            <h3 class="title">您好，管理员</h3>
            <input type="text" style="display:none">
            <input type="password" style="display:none">
            <el-form-item prop='username'>
              <el-input 
              type="text" 
              auto-complete="off" 
              autocorrect="off" 
              autocapitalize="off" 
              spellcheck="false" 
              placeholder="用户名/邮箱" 
              v-model='userInfo.username' 
              @change="isChange=true"
              @keydown.native="tabKey($event)">
                <template slot="prepend"><i class="el-icon-mobile-phone"></i></template>
              </el-input>
            </el-form-item>
            <el-form-item prop='password'>
              <el-input ref="pwdInput" type="password" auto-complete="off" placeholder="密码" autocorrect="off" autocapitalize="off" spellcheck="false" v-model='userInfo.password' @keyup.enter="loginIn('userInfo')" @change="isChange=true">
                <template slot="prepend"><i class="el-icon-time"></i></template>
              </el-input>
            </el-form-item>
            <el-col :span='loading?2:5'>
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
            <el-col :span='loading?15:12' >
              <el-form-item>
                <el-button 
                type="primary" 
                :icon="loading ? 'el-icon-loading' : ''" style="background:transparent" 
                @click="loginIn('userInfo')"
                :disabled="loading"
                >
                 {{!loading ? '登录':'登录中...'}}
               </el-button>
                <el-button style="background:transparent;color:white" @click="reset('userInfo')">重置</el-button>
              </el-form-item>
            </el-col>
          </el-form>
        </div>
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
      winWidth:window.innerWidth,
      winHeight:window.innerHeight,
      imgWidth:0,
      headTop:-50,
      headShakeTimer:null,
      // isFormShow:false,
      imgLeft:0,
      formOpacity:0,
      formLeft:75,

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
      this.winWidth = window.innerWidth;
      this.winHeight = window.innerHeight;
    },

    /**
     * [headTopAnimate 标题进入动画]
     * @Author   罗文
     * @DateTime 2017-11-07
     * @return   {[type]}   [description]
     */
    headTopAnimate() {
      let timer = setInterval(()=>{
         if(this.headTop >= 50) {
            clearInterval(timer);
            return;
         }
         this.headTop += 1;
      }, 10)
    },
     
    /**
     * [headShakeAnimate 标题抖动动画]
     * @Author   罗文
     * @DateTime 2017-11-07
     * @return   {[type]}   [description]
     */
    headShakeAnimate() {
       this.$refs.headShake.className = 'flip animated infinite';
    },
    
    /**
     * [clearHeadShakeAnimate 清除标题抖动动画]
     * @Author   罗文
     * @DateTime 2017-11-07
     * @return   {[type]}   [description]
     */
    clearHeadShakeAnimate() {
       this.$refs.headShake.className = '';
    },


    /**
     * [imgAnimation1 图片动画1，用作入场动画]
     * @Author   罗文
     * @DateTime 2017-11-06
     * @return   {[type]}   [description]
     */
    imgAnimation1() {
      let timer = setInterval(()=>{
         if(this.imgWidth >= this.winWidth/5) {
            clearInterval(timer);
            return;
         }
         this.imgWidth ++;
      }, 5)
    },

    /**
     * [openLoginForm 打开或隐藏登录窗口]
     * @Author   罗文
     * @DateTime 2017-11-07
     * @return   {[type]}   [description]
     */
    openLoginForm() {
        let timer = null;
        if(this.imgLeft == -30) {
           this.$refs['userInfo'].resetFields();
           this.imgWidth = this.winWidth/5;
           this.imgLeft = 0;
           

           timer = setInterval(()=>{
             if(this.formOpacity < 0) {
                this.formOpacity = 0;
                this.formLeft = 75;
                clearInterval(timer);
                return;
             }
             this.formOpacity -= 0.01;
             this.formLeft += 0.25;
           }, 3)
        }else {
           this.imgWidth = this.winWidth/10;
           this.imgLeft = -30;

           timer = setInterval(()=>{
             if(this.formOpacity > 1) {
                this.formOpacity = 1;
                this.formLeft = 50;
                clearInterval(timer);
                return;
             }
             this.formOpacity += 0.01;
             this.formLeft -= 0.25;
           }, 3)
        }
    },

    tabKey(e) { 
       if(e.keyCode == 9) {
          e.preventDefault();
          this.$refs.pwdInput.focus();
       }
    },

    /**
     * [imgAnimation1 图片动画2，用作登录动画]
     * @Author   罗文
     * @DateTime 2017-11-06
     * @return   {[type]}   [description]
     */
    imgAnimation2() {
       
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
  },
  mounted() {
    this.setLoginSize();
    //动态监测浏览器窗口变化
    window.onresize = () => {
      this.setLoginSize();
    };

    this.headTopAnimate();
    setTimeout(()=>{
      this.imgAnimation1();
    }, 800)
  },

  watch:{
    'winWidth':function(nv) {
       this.imgWidth = this.imgLeft == -30 ? nv/10 : nv/5;
    }
  }
}
</script>
<style lang="less">


</style>

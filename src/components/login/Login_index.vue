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
     src="../../assets/images/login-start.png"  
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
                  <el-switch v-model="remember" ></el-switch>
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
      remember: eval(sessionStorage.getItem('remember')) || eval(localStorage.getItem('remember')),
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
     * [setLoginFormData 回显时设置表单数据]
     * @Author   罗文
     * @DateTime 2017-11-12
     */
    setLoginFormData() {
       //设置是否记住密码
       let remember = localStorage.getItem('remember') || 'false';
       if(remember != 'true' && remember != 'false') remember = 'false';

       this.remember = eval(remember);

       //设置账号输入框
       this.userInfo.username  = localStorage.getItem('account') || '';

       //设置密码，根据上次用户的记录情况
       if(this.remember) {
          this.userInfo.password = localStorage.getItem('password') || '';
       }
       
    },


    //登录系统
    loginIn(userInfo) {

      this.$refs[userInfo].validate((valid) => {
        if (valid) {

          var activePwd = localStorage.getItem('password') ? localStorage.getItem('password') : '';

          if (this.userInfo.password !== activePwd) {
            this.userInfo.password = hex_sha1(this.userInfo.password);
          }
          this.loading = true;

          this.userInfo.random = Math.random();
          
          //登录
          this.apiTransfer('post','/passport/login',this.userInfo,(res)=>{
              this.loading = false;
              if(res.data.Code == 200) {

                  //永久存储用于记录密码
                  if (this.remember == true) {
                    localStorage.setItem('password', this.userInfo.password);
                  } else {
                    localStorage.removeItem('password');
                  }
                 
                  localStorage.setItem('account', this.userInfo.username);
                  localStorage.setItem('remember', this.remember);
                  
                  //临时存储用于保存用户信息
                  sessionStorage.setItem('userInfo', JSON.stringify(res.data.Data));
                  sessionStorage.setItem('userId', res.data.Data.Id);


                  this.$message({
                    message: '欢迎登录KOI后台管理系统',
                    type: 'success'
                  });

                  this.$router.push({path:'/admin',query:{}});
              }else {
                  this.$message({
                    message: res.data.Description,
                    type: 'error'
                  });
              }
          });
 
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
    }, 800);

    
    //回显，设置表单数据
    this.setLoginFormData();
  },

  watch:{
    'winWidth':function(nv) {
       this.imgWidth = this.imgLeft == -30 ? nv/10 : nv/5;
    },

    'remember':function(nv) {
        localStorage.setItem('remember', nv);
    }
  }
}
</script>
<style lang="less">


</style>

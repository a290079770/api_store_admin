<template>
  <div class="index-cont" :style="{minWidth:winWidth +'px',minHeight:winHeight +'px',position:'relative'}">
     <div class="place-holder" :style="{width:winWidth +'px'}">
       
     </div>
     <el-row :style="{minHeight:winHeight +'px',height:'auto'}">
        <el-col :span="5" style="height:100%;position:relative;z-index:9">
           <div class="side-bar-place" :style="{width: winWidth >= collapseSize ? '20.85%': 100 +'px'}">
             
           </div>
           <div class="side-bar" style="height:100%;background:transparent">

             <div class="cover-img" v-show="winWidth >= collapseSize">
                <h2 class="system-title">
                   API文档 <span style="font-size:14px">&nbsp;管理平台-Noven</span>
                </h2>
                <div>
                   <img src="../../assets/images/login-start.png" alt="">
                </div>
                <p></i>&nbsp;&nbsp;{{nickName}}</p>
                <!-- <p><i class="el-icon-setting"></i>&nbsp;&nbsp;{{userType == 1 ? '系统管理员':(userType == 2 ? '二审专员':(userType == 3 ? '一审专员':'普通用户'))}}</p> -->
              </div>

              <el-menu 
                default-active="0" 
                class="el-menu-vertical-demo" 
                :collapse="winWidth >= collapseSize ?false : true"
                text-color="#fff"
                background-color="#21b384"
                active-text-color="#fff"
              >

                <span 
                  @click="toPath(item.path,index+1)"
                  v-for="(item,index) in path"
                  >
                  <el-menu-item :index="index + ''">
                    <i :class="item.icon"></i>
                    <span slot="title">{{item.title}}</span>
                  </el-menu-item>
                </span>


              </el-menu>

           </div>
        </el-col>
        <el-col :span="19" :style="{minHeight:winHeight +'px',position:'relative'}">
           <div class="content-title">
              <el-dropdown trigger="click">
                <span class="el-dropdown-link" style="cursor:pointer">
                  <i class="icon-my-user"></i>罗文
                </span>
                <el-dropdown-menu slot="dropdown">
                  <el-dropdown-item>修改密码</el-dropdown-item>
                  <el-dropdown-item>修改个人资料</el-dropdown-item>
                </el-dropdown-menu>
              </el-dropdown>
              <i class="icon-my-tuichu1"  style="font-size:16px" @click="signOut"></i> <span class="sign-out">退出</span>
           </div>
           <el-row :style="{height:winHeight-45 +'px',marginTop:'40px'}">
                <img src="../../assets/images/背景图1.png" class="background-img left-top" :style="{top:'0'}" alt="">
                <img src="../../assets/images/背景图2.png" class="background-img right-bottom" alt="">
                <router-view></router-view>

                <div class="canvas-content" :style="{width:cWidth + 'px'}">
                   <canvas-time
                    :cWidth="cWidth" 
                    :cHeight="cHeight"
                    :radius="radius"
                    :marTop="5"
                    :marLeft="0"
                    :ballColor="ballColor"
                   ></canvas-time>
                </div>
           </el-row>
        </el-col>
     </el-row>

  </div>
</template>

<script>
   import {mapActions,mapGetters} from 'vuex';
   import canvasTime from '../../common/canvasTime';
   export default {
     data(){
      return {
           path:[
             {
               path:'/admin/index',
               icon:'icon-my-15',
               title:'首页'
             },
             {
               path:'/admin/products',
               icon:'icon-my-personal-center',
               title:'产品列表'
             },
             {
               path:'/admin/users',
               icon:'icon-my-users',
               title:'用户列表'
             },
             {
               path:'/admin/managers',
               icon:'icon-my-guanliyuan',
               title:'管理员列表'
             },
             {
               path:'/login',
               icon:'icon-my-tuichu1',
               title:'退出'
             },
           ],

            nickName:'',
            collapseSize: 500,

            cWidth : 240,   //画布宽
            cHeight : 80,
            radius : 1.2,
            marTop : 50,
            marLeft : 0,
            ballColor:"#fff"
        }
     },

     computed:mapGetters([
      'winWidth',
      'winHeight'
     ]),

     components:{
       'canvas-time':canvasTime
     },

     methods:{
       
       toPath(path,query) {
        if(query  ==  this.path.length) {
            this.$confirm('确定退出?', '提示', {
              confirmButtonText: '确定',
              cancelButtonText: '取消',
              type: 'warning'
            }).then(() => {
              this.$router.push(path);
            }).catch(() => {
          
            });
         }else {
            this.$router.push(path);
         }
       },

      
      /**
       * [signOut 退出系统]
       * @Author   罗文
       * @DateTime 2017-11-01
       * @return   {[type]}   [description]
       */
      signOut() {
        this.$confirm('确定退出?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            this.$router.push('/login');
          }).catch(() => {
        
          });
      }
     },
     mounted() {
        this.setWindow(window.innerWidth,window.innerHeight);
        window.onresize = ()=>{
           this.setWindow(window.innerWidth,window.innerHeight);
        }
     }
   }
</script>
<style lang="css">

</style>


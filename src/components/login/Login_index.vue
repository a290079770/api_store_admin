<template>
  <div class="login" :style="{width:winWidth +'px',height:winHeight +'px'}">
     <img src="../../assets/login-start.png"  :width="imgWidth" >
  </div>
</template>
<script>
import qs from 'qs';
export default {
  name: 'login',
  data() {
    return {
      winWidth:window.innerWidth,
      winHeight:window.innerHeight,
      imgWidth:0
    }
  },

  methods: {
    setLoginSize() {
      this.winWidth = window.innerWidth;
      this.winHeight = window.innerHeight;
    },

    /**
     * [imgAnimation1 图片动画1，用作入场动画]
     * @Author   罗文
     * @DateTime 2017-11-06
     * @return   {[type]}   [description]
     */
    imgAnimation1() {
      let timer = setInterval(()=>{
         if(this.imgWidth >= this.winWidth/4) {
            clearInterval(timer);
            return;
         }
         this.imgWidth += 2;
      }, 1)
    },

    /**
     * [imgAnimation1 图片动画2，用作登录动画]
     * @Author   罗文
     * @DateTime 2017-11-06
     * @return   {[type]}   [description]
     */
    imgAnimation2() {
       
    }
  },
  mounted() {
    this.setLoginSize();
    //动态监测浏览器窗口变化
    window.onresize = () => {
      this.setLoginSize();
    };

    this.imgAnimation1();
  },
}
</script>
<style lang="less">


</style>

<template>
  <div class="login" :style="{width:winWidth +'px',height:winHeight +'px'}">
     
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
    }
  },

  methods: {
    setLoginSize() {
      console.log(1)
      this.winWidth = window.innerWidth;
      this.winHeight = window.innerHeight;
    },
  },
  mounted() {
    this.setLoginSize();
    //动态监测浏览器窗口变化
    window.onresize = () => {
      this.setLoginSize();
    };
  },
  watch: {

  }
}
</script>
<style lang="less">


</style>

<template>
  <div class="index-content" :style="{width:winWidth +'px',height:winHeight +'px'}" >
     <div class="box" @click="toClient">
       客户端
     </div>
     <div class="box" @click="toAdmin">
       服务器端
     </div>

  </div>
</template>

<script>
   export default {
     data(){
      return {
           winWidth:window.innerWidth,
           winHeight:window.innerHeight,
           toolsShow:false
        }
     },
     methods:{
        setWindow() {
           this.winWidth = window.innerWidth;
           this.winHeight = window.innerHeight;
       },
       toClient() {
           this.$router.push('/wrap');
       },
       toAdmin() {
           this.$router.push('/admin');
       }
     },
     mounted() {
        this.setWindow();
        window.onresize = ()=>{
           this.setWindow();
        }
     }
   }
</script>
<style lang="css" scoped>
    .index-content {
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .box {
      display: flex;
      justify-content: center;
      align-items: center;
      width: 250px;
      height: 250px;
      border: 1px solid #ccc;
      margin-right: 40px;
      border-radius: 10px;
      box-shadow: 0px 0px 10px #aaa;
      font:normal 30px '微软雅黑';
      color:#666;
      cursor: pointer;
    }

    .box:active{
      box-shadow: 0px 0px 20px #666;
    }
</style>


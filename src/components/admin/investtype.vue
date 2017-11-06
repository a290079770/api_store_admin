<template>
  <div class="add-exp" :style="{height:winHeight + 'px'}">
     <div>
       <div class="box" @click="toClient(1)">
         审查知识元
       </div>
       <div class="box" @click="toClient(2)">
         审查知识簇
       </div>
     </div>

     <div>
       <div class="box" @click="toClient(3)">
         审查知识链
       </div>
       <div class="box" @click="toClient(4)">
         审查其他
       </div>
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
       toClient(query) {
           if(!query) {
             this.$router.push('/admin/investigate');
           }else {
             this.$router.push({
               path:'/admin/investigate',
               query:{
                  objectType:query
               }
             })
           }
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
    .add-exp {
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
    }

    .add-exp>div {
      display: flex;
      justify-content: center;
      align-items: center;
      margin-bottom: 40px
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


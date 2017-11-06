<template>
  <div class="add-exp" style="height:100%">

     <section class="content-nav-top">
         <h3>状态查询</h3>
         <p><span class="yellow-place"></span></p>
         <p>状态查询：查询个人申请、修改、注销的状态</p>
     </section>
     <div>
       <div class="box box-active" @click="toClient('create')">
         <el-row style="width:100%">
           <el-col :span="7" >
               <img src="../../assets/我的申请 选中.png" alt="">
           </el-col>
           <el-col :span="17" >
               <h3>我的申请</h3>
               <p>查看我的KOI申请记录</p>
           </el-col>
         </el-row>
       </div>
       <div class="box" @click="toClient('update')">
          <el-row style="width:100%">
             <el-col :span="7" >
                 <img src="../../assets/我的修改 未选中.png" alt="">
             </el-col>
             <el-col :span="17" >
                 <h3>我的修改</h3>
                 <p>查看我的KOI修改记录</p>
             </el-col>
          </el-row>
       </div>
     </div>

     <div>
       <div class="box" @click="toClient('addExpChainForm')">
          <el-row style="width:100%">
           <el-col :span="7" >
               <img src="../../assets/我的申请-未选中.png" alt="">
           </el-col>
           <el-col :span="17" >
               <h3>我的注销</h3>
               <p>查看我的KOI注销记录</p>

           </el-col>
         </el-row>
       </div>
       <!-- <div class="box" @click="toClient">
         <el-row style="width:100%">
           <el-col :span="7" >
               <img src="../../assets/我的申请-未选中.png" alt="">
           </el-col>
           <el-col :span="17" >
               <h3>我的申请</h3>
               <p>我的申请，前往查看我的个人申请</p>
           </el-col>
         </el-row>
       </div> -->
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
           this.$router.push({
            path:'/wrap/updateList',
            query:{
              listType:query
            }
           });
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

    .content-nav-top {
      position: absolute;
      left: 0;
      top:0;
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      height: 25%;
      width: 100%;
      /*background: red;*/
      text-align: center;
    }

    .content-nav-top h3 {
      font-size: 30px;
      font-weight: 400;
      margin-top: -60px;
      margin-bottom: 10px;
    }

    .yellow-place {
      display: inline-block;
      margin-bottom: 10px;
      height: 5px;
      width: 26px;
      background: #fec708;
    }

    .add-exp>div {
      display: flex;
      justify-content: center;
      align-items: center;
      margin-bottom: 40px
    }


    .box {
      display: flex;
      /*justify-content: center;*/
      align-items: center;
      width: 350px;
      height: 160px;
      border: 1px solid #ccc;
      background: #e9e9e9;
      margin-right: 40px;
      font:normal 24px '微软雅黑';
      color:#666;
      cursor: pointer;
    }

    .box img {
      padding-left: 20px;
    }

    .box h3 {
      font-size: 20px;
      font-weight: 400;

    }

    .box p {
      width: 80%;
      margin-top: 15px;
      font: normal 16px '';
      text-overflow: ellipsis;
      overflow: hidden;
      white-space: nowrap;
    }

    .box-active {
       color:white;
       background: #0393eb;
    }

    .box:active{
      box-shadow: 0px 0px 20px #666;
    }


    .background-img {
      position: absolute;
    }

    .left-top {
      left: 0;
      top:0;
    }

    .right-bottom {
      right: 0;
      bottom:0;
    }
</style>


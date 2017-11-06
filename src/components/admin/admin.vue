<template>
  <div class="index-cont" :style="{minWidth:winWidth +'px',minHeight:winHeight +'px',position:'relative'}">
     <div class="place-holder" :style="{width:winWidth +'px'}">
       
     </div>
     <el-row :style="{minHeight:winHeight +'px',height:'auto'}">
        <el-col :span="5" style="height:100%;position:relative;z-index:9">
           <div class="side-bar-place">
             
           </div>
           <div class="side-bar" style="height:100%">

             <div class="cover-img">
                <h2 class="system-title">
                   KOI管理终端
                </h2>
                <div>
                   <img src="../../assets/bg-big.jpg" alt="">
                </div>
                <p></i>&nbsp;&nbsp;{{nickName}}</p>
                <!-- <p><i class="el-icon-setting"></i>&nbsp;&nbsp;{{userType == 1 ? '系统管理员':(userType == 2 ? '二审专员':(userType == 3 ? '一审专员':'普通用户'))}}</p> -->
              </div>

              <el-menu 
              default-active="0" 
              class="el-menu-vertical-demo" 
              @open="handleOpen" 
              @close="handleOpen"
              text-color="#fff"
              background-color="#0393e8"
              active-text-color="#fff"
              >
                <span @click="toPath('/admin/investigate',1)"><el-menu-item index="0"><i class="el-icon-arrow-right"></i>一审</el-menu-item></span>
                <span @click="toPath('/admin/investigate',2)"><el-menu-item index="1"><i class="el-icon-d-arrow-right"></i>二审</el-menu-item></span>
                <span @click="toPath('/admin/review')"><el-menu-item index="2"><i class="el-icon-search"></i>查询</el-menu-item></span>
                <span @click="toPath('/admin/systemLog')"><el-menu-item index="3"><i class="el-icon-tickets"></i>系统日志</el-menu-item></span>
                <span @click="toPath('/admin/userAdmin')" v-show="userType == 1"><el-menu-item index="4"><i class="el-icon-edit"></i>用户管理</el-menu-item></span>
              </el-menu>
           </div>
        </el-col>
        <el-col :span="19" :style="{minHeight:winHeight +'px',position:'relative'}">
           <div class="content-title">
              <i class="el-icon-minus" @click="resizeMin"></i>
              <i class="el-icon-more" @click="resizeMax"></i>
              <i class="el-icon-close" @click="closeForm"></i>
           </div>
           <el-row :style="{height:winHeight-45 +'px',marginTop:'40px'}">
                <img src="../../assets/背景图1.png" class="background-img left-top" :style="{top:'0'}" alt="">
                <img src="../../assets/背景图2.png" class="background-img right-bottom" alt="">
                <router-view></router-view>
           </el-row>
        </el-col>
     </el-row>


     <el-dialog
        title="驳回理由"
        :visible.sync="dialogVisible"
        width="60%"
        :before-close="handleClose">
        <el-input v-model="aa" type="textarea" auto-complete="off" placeholder="请输入驳回理由"></el-input>
        <span slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="dialogVisible = false">确 定</el-button>
        </span>
      </el-dialog>
  </div>
</template>

<script>
   export default {
     data(){
      return {
           winWidth:window.innerWidth,
           winHeight:window.innerHeight,
           toolsShow:false,
            tableData: [],
            tableData1: [],
            tableData2: [],
            dialogVisible:false,
            aa:'',
            userType:4,
            nickName:''
        }
     },

     methods:{
       setWindow() {
           this.winWidth = window.innerWidth;
           this.winHeight = window.innerHeight;
       },
       /**
        * [getExplicitWordList 获取管理端列表数据]
        * @Author   罗文
        * @DateTime 2017-10-19
        * @param    {[Boolean]}   isshenhe [传入''，获取所有  true - 已审核  false - 未审核]
        * @return   {[type]}     [description]
        */
       getExplicitWordList(isshenhe) {
          this.$http.get('/ExplicitWord/List',{
            params:{
              isFormal:isshenhe
            }
          }).then((res) => {
            if (res.data.Code == 200) {
               switch (isshenhe) {
                 case '':
                   this.tableData = res.data.Data.ItemList;
                   break;
                 case false:
                   this.tableData1 = res.data.Data.ItemList;
                   break;
                 case true:
                   this.tableData2 = res.data.Data.ItemList;
                   break;  
                 default:
                   // statements_def
                   break;
               }
            }else {
               this.$message({
                  message: res.data.Description,
                  type: 'error'
               });
            }
          })
       },
       handleOpen(key, keyPath) {
        switch(key) {
           case '1':
             this.$router.push('/admin/investtype');
             break;
           case '2':
             this.$router.push('/admin/review');
             break;
           case '3':
             this.$router.push('/admin/reView');
             break;  
           default:
             break;
         }

       },
       toPath(path,query) {
         if(!query) {
            this.$router.push(path);
         }else {
            this.$router.push({
              path:path,
              query:{
                 investType:query
              }
            })
         }
       },
       handleClose(key, keyPath) {
        console.log(key, keyPath);
       },
       handleEdit(index, row) {
         this.$confirm('审核通过?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            this.$message({
              type: 'success',
              message: '审核通过(功能演示)！'
            });
          }).catch(() => {
        
          });
       },
       handleDelete(index, row) {
          this.$confirm('确认驳回?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            this.$message({
              type: 'success',
              message: '已驳回(功能演示)！'
            });
          }).catch(() => {
        
          });
       },
      handleClose(done) {
        this.$confirm('确认关闭？')
          .then(_ => {
            done();
          })
          .catch(_ => {});
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
        this.userType = sessionStorage.userType;
        this.nickName = sessionStorage.nickname;
        this.setWindow();
        // this.getExplicitWordList('');
        // this.getExplicitWordList(true);
        // this.getExplicitWordList(false);
        window.onresize = ()=>{
           this.setWindow();
        }
     }
   }
</script>
<style lang="css">
   .side-bar {
      background: #eef1f6;
   }

   .el-table__body-wrapper {
      overflow: hidden !important;
   }

   .cover-img {
      width:100%;
      height:200px;
      overflow: hidden;
   }

   .cover-img img {
      display: flex;
      justify-content: center;
      align-items: center;
      width: 100px;
      height: 100px;
      /*background: green;*/
      border-radius: 50%;
      margin: 20px 30px 0;
   }

/*   .cover-img div img {
      width: 100%;
      height: 100%;
   }
*/
   .cover-img p {
      margin: 10px 25px;
      color:#337ab7;
   }

   .place-holder {
      border:1px solid #eee;
      position:fixed;
      left:0;
      top:0;
      z-index: 999;
   }

   .side-bar {
      background: #0393e8;
   }

   .side-bar-place {
     position: fixed;
     height: 100%;
     width: 20.85%;
     background: #0393e8
   }

   .el-table__body-wrapper {
      overflow: hidden !important;
   }

   .el-menu {
      border-right: none !important;
   }


   .el-menu-item,.el-submenu__title {
      padding-left: 18% !important;
      font-size: 16px !important;

   }

/*   .el-menu-item li {
     padding-left:80px !important;
   }*/

   .place-span {
    display: inline-block;
    width: 28px;

   }



   .cover-img {
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      position: relative;
      z-index: 10;
      width:100%;
      height:200px;
      overflow: hidden;
   }

   .system-title {
      display: flex;
      justify-content: center;
      align-items: center;
      height: 60px;
      color:white;
      font: normal 20px '微软雅黑';
      align-self: flex-start;
      padding-left: 20px;
   }

   .cover-img img {
      display: flex;
      justify-content: center;
      align-items: center;
      width: 100px;
      height: 100px;
      /*background: green;*/
      border-radius: 50%;
      margin: 20px 30px 0;
   }

/*   .cover-img div img {
      width: 100%;
      height: 100%;
   }
*/
   .cover-img p {
      margin: 10px 25px;
      color:white;
      /*padding-left: 25px;*/
   }

   .place-holder {
      border:1px solid #eee;
      position:fixed;
      left:0;
      top:0;
      z-index: 999;
   }


   .el-menu-item i {
    color:white !important;
   }
</style>


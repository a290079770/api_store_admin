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
                <div>
                   <img src="../../assets/n1.png" alt="">
                </div>
                <p></i>&nbsp;&nbsp;{{nickName}}</p>
                <!-- <p><i class="el-icon-setting"></i>&nbsp;&nbsp;{{userType == 1 ? '系统管理员':(userType == 2 ? '二审专员':(userType == 3 ? '一审专员':'普通用户'))}}</p> -->
              </div>
              <el-menu 
              default-active="2" 
              class="el-menu-vertical-demo" 
              @open="handleOpen" 
              @close="handleOpen"
              text-color="#fff"
              background-color="#0393e8"
              active-text-color="#fff"
              style="border-right:none"
              >
                <span @click="toMessage"><el-menu-item index="5"><i class="el-icon-news"></i>消息列表</el-menu-item></span>
                <el-submenu index="1">
                  <template slot="title"><i class="el-icon-circle-plus-outline"></i>KOI申请</template>
                    <el-menu-item style="padding-left:40px" :index="'1-'+index" v-for="(item,index) in shenqing" @click="toPath(item.path)"><span class="place-span"></span>{{item.title}}</el-menu-item>
                </el-submenu>

               <el-submenu index="2">
                  <template slot="title"><i class="el-icon-edit-outline"></i>KOI修改申请</template>
                    <el-menu-item :index="'2-'+index" v-for="(item,index) in update" @click="toPath(item.path,item.reViewType)"><span class="place-span"></span>{{item.title}}</el-menu-item>
                </el-submenu>

                <el-submenu index="3">
                  <template slot="title"><i class="el-icon-search"></i>状态查询</template>
                    <el-menu-item index="3-0" @click="toPathWithQuery('/wrap/updateList','create')"><span class="place-span"></span>我的申请</el-menu-item>
                    <el-menu-item index="3-1" @click="toPathWithQuery('/wrap/updateList','update')"><span class="place-span"></span>我的修改</el-menu-item>
                    <el-menu-item index="3-2" @click="toPathWithQuery('/wrap/updateList','delete')"><span class="place-span"></span>我的注销</el-menu-item>
                </el-submenu>
                <span @click="toPerson"><el-menu-item index="4"><i class="el-icon-setting"></i>KOI解析</el-menu-item></span>
              </el-menu>
           </div>
        </el-col>
        <el-col :span="19" :style="{minHeight:winHeight +'px',position:'relative'}">
<!--            <div class="content-title">
              <i class="el-icon-minus"></i>
              <i class="el-icon-more"></i>
              <i class="el-icon-close"></i>
           </div> -->

           <el-row :style="{height:winHeight-45 +'px',marginTop:'40px'}">
                <img src="../../assets/背景图1.png" class="background-img left-top" :style="{top:'0px'}" alt="">
                <img src="../../assets/背景图2.png" class="background-img right-bottom" alt="">
                <router-view></router-view>
           </el-row>
        </el-col>
     </el-row>


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
           shenqing:[
             {
              title:'知识元申请',
              path:'/wrap/addExpForm'
             },{
              title:'知识簇申请',
              path:'/wrap/addExpSetForm'
             },{
              title:'知识链申请',
              path:'/wrap/addExpChainForm'
             },
           ],
           update:[
             {
              title:'修改知识元',
              path:'/wrap/reViewList',
              reViewType:1
             },{
              title:'修改知识簇',
              path:'/wrap/reViewList',
              reViewType:2
             },{
              title:'修改知识链',
              path:'/wrap/reViewList',
              reViewType:3
             },
           ],


           dialogFormVisible: false,
           updateDialogFormVisible:false,
           form: {
              Title: '',
              Category: '',
              Description: '',
              Reference:'',
           },
           updateForm: {
              Title: '',
              Category: '',
              Description: '',
              Reference:'',
           },
           formLabelWidth: '120px',
           userType:4,
            nickName:''
        }
     },
     methods:{
       setWindow() {
           this.winWidth = window.innerWidth;
           this.winHeight = window.innerHeight;
       },
       //获取知识元列表
       getExplicitWordList() {
          this.$http.get('/ExplicitWord/List',{
            params:{
              isFormal:''
            }
          }).then((res) => {
            if (res.data.Code == 200) {
               console.log(res.data)
               this.tableData = res.data.Data.ItemList;
            }else {
               this.$message({
                  message: res.data.Description,
                  type: 'error'
                });
            }
          })
       },
       //新增知识元
       addNewExplicit() {
          this.form.UserId = 100;

          this.$http.post('/ExplicitWord/Create',this.form).then((res) => {
            if (res.data.Code == 200) {
               this.$message({
                  message: '申请知识元成功！',
                  type: 'success'
                });
               this.dialogFormVisible = false;
               this.getExplicitWordList();
            }else {
               this.$message({
                  message: res.data.Description,
                  type: 'error'
                });
             }
          })

       },
       //修改知识元
       handleUpdateEdit(index,item) {
         this.updateDialogFormVisible = true;
         this.updateForm = {
              Title: item.Title,
              Category: item.Category,
              Description: item.Description,
              Reference:item.Reference
         }
       },
       //确认修改知识元
       updateExplicit() {
        this.updateDialogFormVisible = false;
          //  this.$http.post('/ExplicitWord/Create',this.form).then((res) => {
          //   if (res.data.Code == 200) {
          //      this.$message({
          //         message: '申请知识元成功！',
          //         type: 'success'
          //       });
          //      this.dialogFormVisible = false;
          //      this.getExplicitWordList();
          //   }else {
          //      this.$message({
          //         message: res.data.Description,
          //         type: 'error'
          //       });
          //   }
          // })
       },
       //提交审核
       handleSubmitEdit(index,item) {
         let data = {
            UserId:100,
            ObjectId:item.Id,
            ObjectType:1
         }

        this.$http.post('/ApplyLog/Create',data).then((res) => {
          if (res.data.Code == 200) {
             this.$message({
                message: '提交审核成功！',
                type: 'success'
              });

             this.getExplicitWordList();
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
             this.$router.push('/wrap/addExp');
             break;
           case '2':
             this.$router.push('/wrap/reView');
             break;
           case '3':
             this.$router.push('/wrap/parse');
             break;  
           default:
             break;
         }
       },
       //跳转对应的每个页面
       toPath(path,query) {
         if(!query) {
           this.$router.push(path)
         }else {
           this.$router.push({
            path:path,
            query:{
              reViewType:query
            }
           })
         }
       },
       toPerson() {
         this.$router.push('/wrap/parseKoi');
       },
       toMessage() {
         this.$router.push('/wrap/messageList');
       },
       //跳转到我的申请或我的修改
       toPathWithQuery(path,query) {
         this.$router.push({
             path:path,
             query:{
                listType:query
             }
         })
       },
       handleClose(key, keyPath) {
         console.log(key, keyPath);
       },
       handleEdit(index, row) {
         console.log(index, row);
       },
       //删除知识元
       handleDelete(index, row) {
          this.$confirm('确认删除知识元?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            this.$message({
              type: 'success',
              message: '删除成功(功能演示)！'
            });
          }).catch(() => {
        
          });
       },

       toAdmin() {
         this.$router.push('/admin')
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
        this.getExplicitWordList();
        window.onresize = ()=>{
           this.setWindow();
        }

     }
   }
</script>
<style lang="css">
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

   .content-title {
     position: fixed;
     z-index: 8;
     right: 0;
     top:0;
     display: flex;
     justify-content: flex-end;
     align-items: center;
     height: 40px;
     width: 100%;
     background: white;
     border-bottom: 1px solid #eee;
     box-shadow: 0px 0px 10px #999;
   }

   .content-title i {
     margin: 0 15px 0 0;
   }

   .content-title i:hover {
     color: #0393Eb;
     cursor: pointer;
   }

   .el-menu-item i,.el-submenu__title i {
    color:white !important;
   }


</style>


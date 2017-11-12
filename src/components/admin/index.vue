<template>
  <div style="margin:30px auto;width:92%;">
     <div class="table-page-title">
       <h3>
         首页
       </h3>
       <span class="yellow-place"></span>
     </div>
      <el-row>
          <el-col :span="14" >&nbsp;</el-col>
          <el-col :span="3" >
            &nbsp;
          </el-col>
          <el-col :span="7" >
              <el-input 
                placeholder="请输入搜索关键字，标题" 
                suffix-icon="el-icon-search" v-model="keyWord" 
                @keyup.enter.native="handleIconClick"
                >
              </el-input>
          </el-col>
      </el-row>  
      <el-table
        :data="tableData"
        :border="true"
        style="margin-top:30px">
          <el-table-column
            prop="Id"
            label="ID"
            width="180"
            >
          </el-table-column>
          <el-table-column
            prop="Title"
            label="名称"
            >
          </el-table-column>
          <el-table-column
            prop="Title"
            label="类型"
            >
            <template slot-scope="scope">
               {{scope.row.ObjectType == 1? '知识元' : (scope.row.ObjectType == 2? '知识簇':'知识链')}}
            </template>
          </el-table-column>
          <el-table-column
            label="申请类型"
            >
            <template slot-scope="scope">
               {{scope.row.ActionType == 1 ? '新增' : (scope.row.ActionType == 2? '修改':'注销')}}
            </template>
          </el-table-column>
          <el-table-column
            prop="address"
            label="审核状态">
            <template slot-scope="scope">
               {{investType == 1 ? '一审中' : '二审中'}}
            </template>
          </el-table-column>
          <el-table-column
            prop="address"
            label="操作"
            width="300px"
            >
            <template slot-scope="scope">

              <el-button
                size="small"
                type="primary"
                @click="handleKoiDetail(scope.$index, scope.row)">查看详情</el-button>
              <el-button
                size="small"
                type="success"
                :disabled="canBtnsUse()"
                @click="handleEdit(scope.$index, scope.row)">通过</el-button>
              <el-button
                size="small"
                type="danger"
                :disabled="canBtnsUse()"
                @click="dialogVisible = true;rejectRowData = scope.row">驳回</el-button>
            </template>
          </el-table-column>
      </el-table>

     <!-- 分页 -->
     <div class="block" style="text-align: right;margin-top:10px">
        <el-pagination 
          @size-change="handleSizeChange" 
          @current-change="handleCurrentChange" 
          :current-page="currentPage" 
          :page-sizes="[10, 20, 30, 40]" 
          :page-size="pageCount" 
          layout="total, sizes, prev, pager, next" 
          :total="totalCount">
       </el-pagination>
     </div>


     <el-dialog
        :title= 'rejectRowData.Title + " 的驳回理由"'
        :visible.sync="dialogVisible"
        width="60%"
        :before-close="handleClose"
        >
        <el-input v-model="rejectDesc" type="textarea" :rows="4" auto-complete="off" placeholder="请输入驳回理由"></el-input>
        <span slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="handleDelete">确 定</el-button>
        </span>
      </el-dialog>

      <el-dialog width="60%" :title="itemTitle" top="30px" :visible.sync="dialogFormVisible">
        <koi-detail :formData="formData" :description="description"></koi-detail>

        <div slot="footer" class="dialog-footer">
          <el-button @click="dialogFormVisible = false">关 闭</el-button>
        </div>
      </el-dialog>
  </div>
</template>

<script>
   import KoiDetail from './koiDetail.vue';
   export default {
     data(){
      return {
           toolsShow:false,
            tableData: [],
            tableData1: [],
            tableData2: [],
            dialogVisible:false,
            dialogFormVisible:false,
            keyWord:'',
            rejectDesc:'',
            rejectRowData:{Title:''},
            userId:100,
            investType:1,    // 1 - 一审   2- 二审
            pageCount: 10,
            currentPage: 1,
            totalCount: 0,
            formData:{},
            itemTitle:'',
            description:''
        }
     },
     components:{
        'koi-detail':KoiDetail,
       },
     methods:{
       setWindow() {
           this.$store.dispatch('setWindow',{
              winWidth:window.innerWidth,
              winHeight:window.innerHeight
            });
       },
       /**
        * [canBtnsUse 列表的操作按钮是否可用]
        * userType 1 - 超管 2 - 2审 3 - 1审  4- 普通
        * @Author   罗文
        * @DateTime 2017-10-31
        * @return   {[type]}   [description]
        */
       canBtnsUse() {
           if(sessionStorage.userType == 1 ) {
             //超级管理员
             return false;
           }
           
           if(this.investType == 1) {
              return sessionStorage.userType == 3 ? false : true;
           }

           if(this.investType == 2) {
              return sessionStorage.userType == 2 ? false : true;
           }
       },
       /**
        * [getExplicitWordList 获取管理端列表数据]
        * @Author   罗文
        * @DateTime 2017-10-19
        * @param    {[Number]}   investType [1 - 一审  2 - 二审]
        * @param    {[Number]}   state [0-待处理 1-通过 2-驳回]
        * @return   {[type]}     [description]
        */
       getExplicitWordList(investType) {
          
          let obj = {};
          
          switch (parseInt(investType)) {
            case 1:
              obj.FirstAuditState = 0;
              break;
            case 2:
              obj.FirstAuditState = 1;
              obj.SecondAuditState = 0;
              break;  
            default:
              // statements_def
              break;
          }

          obj.ps = this.pageCount,
          obj.cp = this.currentPage,
          obj.keyword = this.keyword,

          this.$http.get('/ApplyLog/List',{
            params:obj
          }).then((res) => {
            if (res.data.Code == 200) {
               this.tableData = res.data.Data.ItemList;
               console.log(this.tableData)
               this.totalCount = res.data.Data.RecordCount;
            }else {
               this.$message({
                  message: res.data.Description,
                  type: 'error'
               });
            }
          })
       },
              //搜索
       handleIconClick() {         
//        if(!this.keyWord) return;
         
          let obj = {};
          
          switch (parseInt(this.investType)) {
            case 1:
              obj.FirstAuditState = 0;
              break;
            case 2:
              obj.FirstAuditState = 1;
              obj.SecondAuditState = 0;
              break;  
            default: 
              // statements_def
              break;
          }

          obj.ps = this.pageCount,
          obj.cp = this.currentPage,
          obj.keyword = this.keyword,
          obj.Title = this.keyWord,
          
          this.$http.get('/ApplyLog/List',{
             params:obj
          }).then((res) => {
            if (res.data.Code == 200) {
               this.tableData = res.data.Data.ItemList;
            }else {
               this.$message({
                  message: res.data.Description,
                  type: 'error'
                });
             }
          })
       },
       handleOpen(key, keyPath) {
        console.log(typeof key);

       },
       handleClose(key, keyPath) {
        console.log(key, keyPath);
       },

       /**
        * [handleKoiDetail 查看KOI详情]
        * @Author   罗文
        * @DateTime 2017-10-31
        * @param    {[type]}   index [description]
        * @param    {[type]}   row   [description]
        * @return   {[type]}         [description]
        */
       handleKoiDetail(index,row) {
        this.dialogFormVisible = true;
        this.itemTitle = row.Title;

        let apiName = '/ExplicitWord/Detail';

        switch(row.ObjectType) {
          case 1:
            apiName = '/ExplicitWord/Detail';
            break;
          case 2:
            apiName = '/ExplicitWordSet/Detail';
            break;
          case 3:
            apiName = '/ExplicitWordChain/Detail';
            break;
          default:
            // statements_def
            break;
        }

        this.$http.get(apiName, {
          params: {
            Id:row.ObjectId
          }
        }).then((res) => {
          if(res.data.Code == 200) {
             this.formData = res.data.Data;
             this.description = row.Description;
          } else {
            this.$message({
              message: res.data.Description,
              type: 'error'
            });
          }
        })
      },
       /**
        * [handleEdit 审核知识元]
        * @Author   罗文
        * @DateTime 2017-10-26
        * @param    {[Number]}   index [该行索引]
        * @param    {[Object]}   row   [该行数据对象]
        * @return   {[type]}         [description]
        */
       handleEdit(index, row) {
       	 let title = row.Title;
         this.$confirm('通过 ' + title + ' 的审核？', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
              this.$http.post('/ApplyLog/Pass',{
                UserId:this.userId,
                ObjectId:row.ObjectId,
                ObjectType:row.ObjectType,
                Type:this.investType,
                ActionType:row.ActionType
              }).then((res) => {
                  if (res.data.Code == 200) {
                     this.$message({
                      type: 'success',
                      message: '审核通过！'
                     });
                     this.getExplicitWordList(this.investType);
                  }else {
                     this.$message({
                        message: res.data.Description,
                        type: 'error'
                     });
                  }
              })
          }).catch(() => {
        
          });
       },
       /**
        * [handleDelete 驳回操作]
        * @Author   罗文
        * @DateTime 2017-10-26
        * @return   {[type]}   [description]
        */
       handleDelete() {
           if(!this.rejectDesc) {
               this.$message({
                  message: '请输入驳回理由！',
                  type: 'error'
               });
              return;
           }

           this.dialogVisible = false;

           this.$http.post('/ApplyLog/Reject',{
              UserId:this.userId,
              ObjectId:this.rejectRowData.ObjectId,
              ObjectType:this.rejectRowData.ObjectType,
              Type:this.investType,
              Description:this.rejectDesc,
              ActionType:this.rejectRowData.ActionType
            }).then((res) => {
                if(res.data.Code == 200) {
                   this.$message({
                      type: 'success',
                      message: '已驳回！'
                   });
                   this.getExplicitWordList(this.investType);
                }else {
                   this.$message({
                      message: res.data.Description,
                      type: 'error'
                   });
                }
            })
       },
      handleClose(done) {
        this.$confirm('确认关闭？关闭后，输入框的内容将不会保存。')
          .then(_ => {
            done();
          })
          .catch(_ => {});
      },
      //切换每页的条数
      handleSizeChange(val) {
        this.pageCount = val;
        this.currentPage = 1;
        this.getExplicitWordList(this.investType);
      },
      //点击页数，请求第几页
      handleCurrentChange(val) {
        this.currentPage = val;
        this.getExplicitWordList(this.investType);
      },
     },
     mounted() {
        this.investType = this.$route.query.investType ? this.$route.query.investType : 1 ;
        this.setWindow();
        this.getExplicitWordList(this.investType);
        window.onresize = ()=>{
           this.setWindow();
        }
     },

    watch:{
      '$route':function(nv,ov) {
         this.investType = nv.query.investType;
         this.getExplicitWordList(this.investType);
      }
     }
   }
</script>
<style lang="css">
   .side-bar {
      background: rgb(238,241,236);
   }

   .el-table__body-wrapper {
      overflow: hidden !important;
   }

   .update-res {
     margin: 0 auto;
     width: 90%;
     background: red
   }
</style>


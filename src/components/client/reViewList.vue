<template>
  <div style="margin:30px auto;width:92%;">
     <div class="table-page-title">
       <h3>
         修改{{reViewType==1?'知识元':(listType==2?'知识簇':'知识链')}}
       </h3>
       <span class="yellow-place"></span>
     </div>
     <el-row>
          <el-col :span="18" >&nbsp;</el-col>

          <el-col :span="6" >
              <el-input 
                placeholder="名称关键字/KOI编码" 
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
            width="80">
          </el-table-column>
          <el-table-column
            prop="Title"
            label="名称"
            width="180">
          </el-table-column>
          <el-table-column
            prop="address"
            label="审核状态">
            <template scope="scope">
               {{scope.row.ApplyLog ? '正在审核...' : '待审核'}}
            </template>
          </el-table-column>
          <el-table-column
            prop="KoiNumber"
            label="KOI编码">
             <template scope="scope">
               {{scope.row.KoiNumber ? scope.row.KoiNumber : '未通过审核'}}
            </template>
          </el-table-column>
          <el-table-column
            prop="address"
            label="操作">
            <template scope="scope">
              <el-button
                size="small"
                @click="handleUpdateEdit(scope.$index, scope.row)">修改</el-button>  
              <el-button
                size="small"
                type="danger"
                @click="handleOpenDeleteDialog(scope.$index, scope.row)">注销</el-button>
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
        title="注销理由"
        :visible.sync="dialogVisible"
        size="tiny"
        >
        <el-input v-model="rejectDesc" type="textarea" auto-complete="off" placeholder="请输入注销理由"></el-input>
        <span slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="handleDelete">确 定</el-button>
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
           rejectDesc:'',
           dialogVisible:false,
           deletData:null,

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
           shenhe:'全部',
           keyWord:'',
           reViewType:1,   //1 - 知识元   2 - 知识簇   3 - 知识链
           pageCount: 10,
           currentPage: 1,
           totalCount: 0,

        }
     },
     methods:{
       //获取知识元列表
       getExplicitWordList() {
          let apiName = '';
          this.reViewType = parseInt(this.reViewType);

          switch (this.reViewType) {
            case 1:
              apiName = '/ExplicitWord/List';
              break;
            case 2:
              apiName = '/ExplicitWordSet/List';
              break;
            case 3:
              apiName = '/ExplicitWordChain/List';
              break;  
            default:
              // statements_def
              break;
          }

          this.$http.get(apiName,{
            params:{
              isFormal:true,
              ps:this.pageCount,
              cp:this.currentPage,
              keyword:this.keyword
            }
          }).then((res) => {
            if (res.data.Code == 200) {
               this.tableData = res.data.Data.ItemList;
               this.totalCount = res.data.Data.RecordCount;
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
         let path = '/wrap/addExpForm';
         this.reViewType = parseInt(this.reViewType);

          switch (this.reViewType) {
            case 1:
              path = '/wrap/addExpForm';
              break;
            case 2:
              path = '/wrap/addExpSetForm';
              break;
            case 3:
              path = '/wrap/addExpChainForm';
              break;  
            default:
              // statements_def
              break;
          }
         
         this.$router.push({
            path:path,
            query:{
             isUpdate:true,
             koiNumber:item.KoiNumber
           }
         });
        
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
       
       /**
        * [handleOpenDeleteDialog 注销知识元/簇/链]
        * @Author   罗文
        * @DateTime 2017-10-30
        * @return   {[type]}   [description]
        */
       handleOpenDeleteDialog(index,row) {
          this.rejectDesc = '';
          this.dialogVisible = true;
          this.deletData = row;
       },
       
       /**
        * [handleDelete 执行注销操作]
        * @Author   罗文
        * @DateTime 2017-10-30
        * @return   {[type]}   [description]
        */
       handleDelete() {
          if(this.rejectDesc ==='') {
             this.$message({
                  message: '请输入注销理由！',
                  type: 'error'
                });
             return;
          }

          let apiName = '';
          let objectType = 1;
          this.reViewType = parseInt(this.reViewType);

          switch (this.reViewType) {
            case 1:
              apiName = '/ExplicitWord/Delete';
              objectType = 1;
              break;
            case 2:
              apiName = '/ExplicitWordSet/Delete';
              objectType = 2;
              break;
            case 3:
              apiName = '/ExplicitWordChain/Delete';
              objectType = 3;
              break;  
            default:
              // statements_def
              break;
          }

          this.$http.post(apiName,{
            Id:this.deletData.Id,
            Description:this.rejectDesc
          }).then((res) => {
            if (res.data.Code == 200) {
               
               this.dialogVisible = false;
               this.submitApplyLog(this.deletData.Id,objectType,3);
               this.getExplicitWordList();

            }else {
               this.$message({
                  message: res.data.Description,
                  type: 'error'
                });
            }
          })
       },

       /**
        * [submitApplyLog 提交审核]
        * @Author   罗文
        * @DateTime 2017-10-26
        * @return   {[type]}   [description]
        */
       submitApplyLog(objectId,objectType,actionType) {
           this.$http.post('/ApplyLog/Create',{
              ObjectId:objectId,
              ObjectType:objectType,
              ActionType:actionType,
              UserId:100,
              Description:this.rejectDesc
           }).then((res) => {
            if (res.data.Code == 200) {
               this.$message({
                  message: '注销成功！',
                  type: 'success'
                });
            }else {
             this.$message({
                message: res.data.Description,
                type: 'error'
              });
            }
         })
       },
       
       /**
        * [handleClose 点击X关闭模态框]
        * @Author   罗文
        * @DateTime 2017-10-30
        * @param    {Function} done [description]
        * @return   {[type]}        [description]
        */
       //搜索
       handleIconClick() {         
          let apiName = '';
          this.reViewType = parseInt(this.reViewType);

          switch (this.reViewType) {
            case 1:
              apiName = '/ExplicitWord/List';
              break;
            case 2:
              apiName = '/ExplicitWordSet/List';
              break;
            case 3:
              apiName = '/ExplicitWordChain/List';
              break;  
            default:
              // statements_def
              break;
          }

          this.$http.get(apiName,{
            params:{
              isFormal:true,
              ps:this.pageCount,
              cp:this.currentPage,
              Title:this.keyWord
            }
          }).then((res) => {
            if (res.data.Code == 200) {
               this.tableData = res.data.Data.ItemList;
               this.totalCount = res.data.Data.RecordCount;
            }else {
               this.$message({
                  message: res.data.Description,
                  type: 'error'
                });
            }
          })
       },

       toAdmin() {
         this.$router.push('/admin')
       },

       //切换每页的条数
        handleSizeChange(val) {
          this.pageCount = val;
          this.currentPage = 1;
          this.getExplicitWordList()
        },
        //点击页数，请求第几页
        handleCurrentChange(val) {
          this.currentPage = val;
          console.log('in')
          this.getExplicitWordList()
        },
     },
     mounted() {
        this.reViewType = this.$route.query.reViewType;
        this.getExplicitWordList();
     },

     watch:{
      '$route':function(nv,ov) {
           this.reViewType  = nv.query.reViewType;
           this.getExplicitWordList();
        }
     }

   }
</script>
<style lang="css">

   .el-table__body-wrapper {
      overflow: hidden !important;
   }
</style>


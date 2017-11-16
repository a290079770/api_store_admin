<template>
  <div class="index-cont" :style="{width: '92%',margin:'30px auto'}">
    <div class="table-page-title">
       <h3>
         产品管理
       </h3>
       <span class="yellow-place"></span>
     </div>
    <el-row>
        <el-col :span="18" >
          <el-button
          size="success"
          @click="openAddProductDialog(1)" icon="el-icon-plus">新增产品</el-button>
        </el-col>
        <el-col :span="6" >
            <el-input 
              placeholder="请输入产品名称查找" 
              suffix-icon="el-icon-search"
              v-model="keyWord" 
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
          prop="Title"
          label="产品名称"
          width="150">
        </el-table-column>

        <el-table-column
          prop="KoiNumber"
          label="产品描述">
          <template slot-scope="scope">
              {{scope.row.KoiNumber ? scope.row.KoiNumber : '未通过审核'}}
          </template>
        </el-table-column>

        <el-table-column
          prop="address"
          label="操作"
          width="300"
          >
          <template slot-scope="scope">
            <el-button
              size="small"
              type="primary"
              @click="toApiList(scope.row.Id)">API列表</el-button>  
            <el-button
              size="small"
              type="success"
              @click="openAddProductDialog(2,scope.$index, scope.row)">修改</el-button>   
            <el-button
              size="small"
              type="danger"
              @click="handleDelete(scope.$index, scope.row)">删除</el-button>
            
          </template>
        </el-table-column>
    </el-table>


    <el-dialog
        title="新增用户"
        :visible.sync="dialogVisible"
        top="20vh"
        width="60%"
        >
        <el-form label-position="right" ref="addUsers" label-width="120px" :model="formLabelAlign">
          <el-form-item label="用户名" prop="username">
            <el-input v-model="formLabelAlign.RealName" placeholder="请输入用户名" class="input-width" ></el-input>
          </el-form-item>

          <el-form-item label="密码" prop="password">
            <el-input v-model="formLabelAlign.Password" type="password" placeholder="请输入用户密码" class="input-width"></el-input>
          </el-form-item>

          <el-form-item label="确认密码" prop="confirmPwd">
            <el-input v-model="formLabelAlign.Password" type="password" placeholder="请再次确认密码" class="input-width"></el-input>
          </el-form-item>

        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="handleAddProduct">确 定</el-button>
        </span>
      </el-dialog>


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
  </div>
</template>

<script>
   export default {
     data(){
      return {
            tableData: [],
            dialogVisible:false,
            keyWord:'',
            pageCount: 10,
            currentPage: 1,
            totalCount: 0,
            formLabelAlign: {
              UserId:100,
              RealName: '',
              Password: '',
              UserType: '专家'    //用户类别:2-专家,3-管理员,4-用户
            },
        }
     },

     methods:{
       /**
        * [getExplicitWordList 获取管理端列表数据]
        * @Author   罗文
        * @DateTime 2017-10-19
        * @return   {[type]}     [description]
        */
       getExplicitWordList() {
          this.apiTransfer('get','/KoiNumber/List',{
               ps:this.pageCount,
               cp:this.currentPage,
               keyword:this.keyword
            },(res)=>{
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

       /**
        * [openAddProductDialog 打开新增产品框]
        * @Author   罗文
        * @DateTime 2017-11-13
        * @param    {[Number]}   type  [操作类型 1 - 新增 2-修改]
        * @param    {[Number]}   index [修改时传入，修改行索引]
        * @param    {[Object]}   row   [修改时传入，修改行数据]
        * @return   {[type]}         [description]
        */
       openAddProductDialog(type,index,row) {
          this.dialogVisible = true;
       },
       
       /**
        * [handleAddProduct 确定新增产品]
        * @Author   罗文
        * @DateTime 2017-11-13
        * @return   {[type]}   [description]
        */
       handleAddProduct() {
         this.dialogVisible = false;
       },
       
       /**
        * [toApiList 跳转api列表]
        * @Author   罗文
        * @DateTime 2017-11-13
        * @return   {[type]}   [description]
        */
       toApiList(productId) {
          this.$router.push({
            path:'/admin/apiList',
            query:{
              proId:productId
            }
          })
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
          this.$confirm('该操作会删除该产品及其下所有的API，是否继续?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            this.$message({
              type: 'success',
              message: '删除成功！'
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
            //搜索
      handleIconClick() { 

//        if(!this.keyWord) return;
         
          let obj = {};
                    
          this.$http.get('/KoiNumber/List',{
             params:{
             	KeyWord:this.keyWord
             }
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
     },
     mounted() {
        this.setWindow(window.innerWidth,window.innerHeight);
        this.getExplicitWordList();
        window.onresize = ()=>{
           this.setWindow(window.innerWidth,window.innerHeight);
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
</style>


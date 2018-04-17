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
          v-if="isSuperAdmin"
          @click="openProductDialog(1)" icon="el-icon-plus">新增产品</el-button>
          <span v-else>&nbsp;</span>
        </el-col>
        <el-col :span="6" >
            <el-input 
              placeholder="请输入产品名称查找" 
              suffix-icon="el-icon-search"
              v-model="keyWord" 
              @keyup.enter.native="getDataList"
              >
            </el-input>
        </el-col>
    </el-row>    

    <el-table
      :data="dataList"
      :border="true"
      style="margin-top:30px">
        <el-table-column
          prop="Title"
          label="产品名称"
          width="150">
        </el-table-column>

        <el-table-column
          prop="Description"
          label="产品描述"
          show-overflow-tooltip
          >
        </el-table-column>

        <el-table-column
          prop="address"
          label="操作"
          width="200"
          >
          <template slot-scope="scope">
            <el-button
              size="small"
              type="primary"
              @click="toApiList(scope.row.Id)">API列表</el-button>  
            <el-button
              size="small"
              type="success"
              v-show="isSuperAdmin"
              @click="openProductDialog(2,scope.$index, scope.row)">修改</el-button>   
<!--             <el-button
              size="small"
              type="danger"
              @click="handleDelete(scope.$index, scope.row)">删除</el-button> -->
            
          </template>
        </el-table-column>
    </el-table>


    <!-- 分页 -->
     <div class="block" style="text-align: right;margin-top:10px">
        <el-pagination 
          @size-change="handleSizeChange" 
          @current-change="handleCurrentChange" 
          :current-page="cp" 
          :page-sizes="[10, 20, 30, 40]" 
          :page-size="ps" 
          layout="total, sizes, prev, pager, next" 
          :total="totalCount">
       </el-pagination>
     </div>

     
     <!-- 弹出框 -->
     <ProductModal
        :dialogVisible="dialogVisible"
        :pid="pid"
        @closeDialog="closeDialog"
      />
  </div>
</template>

<script>
   import ProductModal from '../modal/ProductModal.vue';

   export default {
     data(){
      return {
            dataList: [],
            dialogVisible:false,
            keyWord:'',
            ps: 10,
            cp: 1,
            totalCount: 0,
            pid:null,
            isSuperAdmin:JSON.parse(sessionStorage.userInfo).UserType == 3 ? true : false,
        }
     },

     components:{
       ProductModal
     },

     methods:{
       /**
        * [getDataList 获取管理端列表数据]
        * @Author   罗文
        * @DateTime 2017-10-19
        * @return   {[type]}     [description]
        */
       getDataList() {
          this.apiTransfer('get','/product/productList',{
               ps:this.ps,
               cp:this.cp,
               keywords:this.keyWord
            },(res)=>{
               if (res.data.code == 200) {
                   this.dataList = res.data.data;
                   this.totalCount = res.data.recordCount;
                }else {
                   this.$message({
                      message: res.data.description,
                      type: 'error'
                   });
                }
            })
       },

       /**
        * [openProductDialog 打开新增产品框]
        * @Author   罗文
        * @DateTime 2017-11-13
        * @param    {[Number]}   type  [操作类型 1 - 新增 2-修改]
        * @param    {[Number]}   index [修改时传入，修改行索引]
        * @param    {[Object]}   row   [修改时传入，修改行数据]
        * @return   {[type]}         [description]
        */
       openProductDialog(type,index,row) {
          if(type == 1) {
            this.pid = null;
          }else if(type == 2) {
            this.pid = row.Id;
          }
          this.dialogVisible = true;
       },

       /**
        * [closeDialog 关闭弹出框]
        * @param  {[Boolean]} needUpdateList [是否更新产品列表]
        * @return {[type]}                [description]
        */
       closeDialog(needUpdateList) {
         this.dialogVisible = false;
         if(needUpdateList) this.getDataList();
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
        this.ps = val;
        this.cp = 1;
        this.getDataList()
      },
      //点击页数，请求第几页
      handleCurrentChange(val) {
        this.cp = val;
        console.log('in')
        this.getDataList()
      },

     },
     mounted() {
        this.setWindow(window.innerWidth,window.innerHeight);
        this.getDataList();
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


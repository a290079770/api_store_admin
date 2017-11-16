<template>
  <div style="margin:30px auto;width:92%;">
     <div class="table-page-title">
       <h3>
         首页
       </h3>
       <span class="yellow-place"></span>
     </div>


     <el-row style="margin:30px 0 10px 0">
        今日登陆用户
     </el-row>


     <el-table
      :data="tableData"
      :border="true"
      >
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

  </div>
</template>

<script>
   export default {
     data(){
      return {
            tableData: [],
            pageCount: 10,
            currentPage: 1,
            totalCount: 0,
        }
     },
     methods:{
       /**
        * [getExplicitWordList 获取管理端列表数据]
        * @Author   罗文
        * @DateTime 2017-10-19
        * @param    {[Number]}   investType [1 - 一审  2 - 二审]
        * @param    {[Number]}   state [0-待处理 1-通过 2-驳回]
        * @return   {[type]}     [description]
        */
       getExplicitWordList() {
          
          
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
        this.setWindow(window.innerWidth,window.innerHeight);
        this.getExplicitWordList();
        window.onresize = ()=>{
           this.setWindow(window.innerWidth,window.innerHeight);
        }
     },

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


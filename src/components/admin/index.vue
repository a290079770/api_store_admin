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
      :data="dataList"
      :border="true"
      >
        <el-table-column
          prop="Id"
          label="ID"
          width="80"
          >
        </el-table-column>

        <el-table-column
          prop="NickName"
          label="昵称"
          >
        </el-table-column>

        <el-table-column
          prop="LastTime"
          label="上次登录时间"
          show-overflow-tooltip
          >
        </el-table-column>

        <el-table-column
          prop="LastIp"
          label="上次登录IP"
          >
        </el-table-column>

        <el-table-column
          prop="ThisTime"
          label="本次登录时间"
          show-overflow-tooltip
          >
        </el-table-column>

        <el-table-column
          prop="ThisIp"
          label="本次登录IP"
          >
        </el-table-column>


         <el-table-column
          label="用户类型"
          >
          <template slot-scope="scope">
              <el-tag type="success" v-if="scope.row.UserType == 3">超级管理员</el-tag>
              <el-tag type="info" v-if="scope.row.UserType == 1">普通用户</el-tag>
              <el-tag type="warning" v-if="scope.row.UserType == 2">管理员</el-tag>
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
          :total="recordCount">
       </el-pagination>
     </div>

  </div>
</template>

<script>
   export default {
     data(){
      return {
            dataList: [],
            ps: 10,
            cp: 1,
            recordCount: 0,
        }
     },
     methods:{
       /**
        * [getDataList 获取今日活跃用户列表]
        * @return {[type]} [description]
        */
       getDataList() {
          this.$http.get('/user/activeUserList',{
            params:{
              ps:this.ps,
              cp:this.cp,
            }
          })
          .then((res)=>{
              this.loading = false;

              if(res.data.code == 200) {
                  //永久存储用于记录密码
                  this.dataList = res.data.data;
                  this.recordCount = res.data.recordCount;
              }else {
                  this.$message({
                    message: res.data.description,
                    type: 'error'
                  });
              }
          })
       },

      //切换每页的条数
      handleSizeChange(val) {
        this.ps = val;
        this.cp = 1;
        this.getDataList();
      },
      //点击页数，请求第几页
      handleCurrentChange(val) {
        this.cp = val;
        this.getDataList();
      },
     },
     created() {
        this.getDataList();
     },
     mounted() {
        this.setWindow(window.innerWidth,window.innerHeight);
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


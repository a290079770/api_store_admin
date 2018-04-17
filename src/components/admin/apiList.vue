<template>
  <div class="index-cont" :style="{height:winHeight +'px',width: '92%',margin:'30px auto'}">
    <div class="table-page-title">
       <h3>
         API列表
       </h3>
       <span class="yellow-place"></span>
     </div>
    <el-row>
        <el-col :span="16" >
          <el-button
          size="success"
          v-if="isSuperAdmin"
          @click="createOrUpdateApi(1)" icon="el-icon-plus">新增API</el-button>
          <span v-else>&nbsp;</span>
        </el-col>

        <el-col :span="8" >
            <el-input 
              placeholder="请输入中文名称/接口名查找" 
              suffix-icon="el-icon-search"
              v-model="keyWord" 
              @keyup.enter.native="getDataList"
              >
            </el-input>
        </el-col>
    </el-row>    
    
    <div v-for="(item,index) in dataList">
      <h3 class="apilist-title">{{item.Title}}</h3>
      <el-table
        :data="item.ItemList"
        :border="true"
        >
          <el-table-column
            label="编号"
            prop="Id"
            width="100">
          </el-table-column>

          <el-table-column
            label="接口名称"
            width="150"
            prop="Title"
            >
          </el-table-column>

          <el-table-column
            label="中文说明"
            prop="ApiTitle"
            >
          </el-table-column>

           <el-table-column
            label="请求方式"
            align="center"
            prop="Methods"
            width="150"
            >
          </el-table-column>


          <el-table-column
            prop="address"
            label="操作"
            width="200">
            <template slot-scope="scope">
              <el-button
                size="small"
                type="primary"
                @click="handleViewApiDetail(scope.row,scope.$index)">查看</el-button>   
              <el-button
                size="small"
                type="success"
                v-show="isSuperAdmin"
                @click="createOrUpdateApi(2,scope.row)">修改</el-button>
              
            </template>
          </el-table-column>

      </el-table>
    </div>


  </div>
</template>

<script>
   export default {
     data(){
      return {
            winHeight:window.innerHeight,
            dataList: [],
            dialogVisible:false,
            keyWord:'',
            isSuperAdmin:JSON.parse(sessionStorage.userInfo).UserType == 3 ? true : false,
        }
     },
     methods:{
       /**
        * [getDataList 获取管理端列表数据]
        * @Author   罗文
        * @DateTime 2017-10-19
        * @param    {[Boolean]}   isshenhe [传入''，获取所有  true - 已审核  false - 未审核]
        * @return   {[type]}     [description]
        */
       getDataList() {
          this.$http.get('/api/apiList',{
            params:{
              ProductId:this.$route.query.proId,
              keywords:this.keyWord
            }
          }).then((res) => {
            if (res.data.code == 200) {
               this.dataList = res.data.data;
            }else {
               this.$message.error(res.data.description);
            }
          })
       },
      /**
       * [createOrUpdateApi 新增或修改api]
       * @Author   罗文
       * @DateTime 2017-11-13
       * @param    {[Number]}   type [操作类型 1 - 新增 2- 修改]
       * @param    {[Object]}   row [修改时传入，修改行数据]
       * @return   {[type]}        [description]
       */
      createOrUpdateApi(type,row) {
         let query = {
             proId:this.$route.query.proId
          }
         let path = type == 1 ? '/admin/apiCreate' : '/admin/apiUpdate';
         
         //如果是修改，需要带apiId
         if(type == 2) {
            query.apiId = row.Id;
         }

         this.$router.push({
            path,
            query
         })
      }, 
      
      /**
       * [handleViewApiDetail 查看api详情]
       * @param  {[Object]} item  [操作的对象]
       * @param  {[Number]} index [操作的元素索引]
       * @return {[type]}       [description]
       */
      handleViewApiDetail(item,index) {
        this.$router.push({
          path:'/admin/apiDetail',
          query:{
            apiId:item.Id,
            proId:this.$route.query.proId
          }
        })
      },

      //切换每页的条数
      handleSizeChange(val) {
        this.pageCount = val;
        this.currentPage = 1;
        this.getDataList()
      },
      //点击页数，请求第几页
      handleCurrentChange(val) {
        this.currentPage = val;
        this.getDataList()
      },
     },

     mounted() {
        if(!this.$route.query.proId) {
          this.$alert('获取产品ID失败，请检查!', '提示', {
            confirmButtonText: '确定',
            type: 'error',
            callback: action => {
              this.$router.push('/admin/products');
            }
          });
        }


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


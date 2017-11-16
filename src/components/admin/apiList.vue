<template>
  <div class="index-cont" :style="{height:winHeight +'px',width: '92%',margin:'30px auto'}">
    <div class="table-page-title">
       <h3>
         API列表 / <span class="apilist-product-title">KOI知识关系生成工具</span>
       </h3>
       <span class="yellow-place"></span>
     </div>
    <el-row>
        <el-col :span="18" >
          <el-button
          size="success"
          @click="createOrUpdateApi(1)" icon="el-icon-plus">新增API</el-button>
        </el-col>

        <el-col :span="6" >
            <el-input 
              placeholder="请输入中文名称/接口名查找" 
              suffix-icon="el-icon-search"
              v-model="keyWord" 
              @keyup.enter.native="handleIconClick"
              >
            </el-input>
        </el-col>
    </el-row>    
    
    <h3 class="apilist-title">资源</h3>
    <el-table
      :data="tableData"
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
          >
          <template slot-scope="scope">
             {{scope.row.UserName ? scope.row.UserName : '暂无信息'}}
          </template>
        </el-table-column>

         <el-table-column
          label="请求方式"
          width="100"
          align="center"
          >
          <template slot-scope="scope">
             POST
          </template>
        </el-table-column>

        <el-table-column
          label="中文说明"
          prop="CreateTime"
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
              @click="handleViewApiDetail(scope.$index, scope.row)">查看</el-button>   
            <el-button
              size="small"
              type="success"
              @click="createOrUpdateApi(2,scope.row)">修改</el-button>
            
          </template>
        </el-table-column>

    </el-table>


  </div>
</template>

<script>
   export default {
     data(){
      return {
            winHeight:window.innerHeight,
            tableData: [],
            dialogVisible:false,
            keyWord:'',
        }
     },
     methods:{
       /**
        * [getExplicitWordList 获取管理端列表数据]
        * @Author   罗文
        * @DateTime 2017-10-19
        * @param    {[Boolean]}   isshenhe [传入''，获取所有  true - 已审核  false - 未审核]
        * @return   {[type]}     [description]
        */
       getExplicitWordList() {
          this.$http.get('/History/List',{
            params:{
              ps:5,
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
         
         //如果是修改，需要带apiId
         if(type == 2) {
            query.apiId = row.Id;
         }

         this.$router.push({
            path:'/admin/apiDetail',
            query:query
          })
      }, 
      
      /**
       * [handleViewApiDetail 查看api详情]
       * @Author   罗文
       * @DateTime 2017-11-13
       * @return   {[type]}   [description]
       */
      handleViewApiDetail() {
      
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
        this.getExplicitWordList()
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


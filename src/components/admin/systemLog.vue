<template>
  <div class="index-cont" :style="{height:winHeight +'px',width: '92%',margin:'30px auto'}">
    <el-row>
        <el-col :span="18" >&nbsp;</el-col>

        <el-col :span="6" >
            <el-input 
              placeholder="请输入名称/KOI编码" 
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
          prop="Id"
          label="Id"
          width="180">
        </el-table-column>
        <el-table-column
          label="操作人"
          width="180"
          align="center"
          >
          <template slot-scope="scope">
             {{scope.row.UserName ? scope.row.UserName : '暂无信息'}}
          </template>
        </el-table-column>
        <el-table-column
          label="操作类型"
          width="180"
          align="center"
          >
          <template slot-scope="scope">
             {{renderActionType(scope.row.ActionType)}}
          </template>
        </el-table-column>
        <el-table-column
          label="操作时间"
          prop="CreateTime"
          align="center">
        </el-table-column>
        <el-table-column
          label="操作内容"
          prop="Title"
          align="center"
          >
        </el-table-column>

    </el-table>

    <!-- 分页 -->
     <div class="block" style="text-align: right;margin-top:10px">
        <el-pagination 
          @size-change="handleSizeChange" 
          @current-change="handleCurrentChange" 
          :current-page="currentPage" 
          :page-sizes="[15, 20, 30, 40]" 
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
           winWidth:window.innerWidth,
           winHeight:window.innerHeight,
           toolsShow:false,
            tableData: [],
            dialogVisible:false,
            aa:'',
            shenhe:'全部',
            selectType:'全部',
            keyWord:'',
            pageCount: 10,
            currentPage: 1,
            totalCount: 0,
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
       getExplicitWordList() {
          this.$http.get('/History/List',{
            params:{
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
      //搜索
      handleIconClick() {  
//        if(!this.keyWord) return;
          
          let obj = {};
                    
          this.$http.get('/History/List',{
             params:{
             	UserName:this.keyWord
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
      background: rgb(238,241,236);
   }

   .el-table__body-wrapper {
      overflow: hidden !important;
   }
</style>


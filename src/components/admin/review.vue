<template>
  <div class="index-cont" :style="{width: '92%',margin:'30px auto'}">
    <el-row>
        <el-col :span="18" >&nbsp;</el-col>
<!--         <el-col :span="12" >
          <el-select v-model="selectType" >
            <el-option label="全部" value="全部"></el-option>
            <el-option label="知识元" value="知识元"></el-option>
            <el-option label="知识簇" value="知识簇"></el-option>
            <el-option label="知识链" value="知识链"></el-option>
          </el-select>

          <el-select v-model="shenhe" >
            <el-option label="全部" value="全部"></el-option>
            <el-option label="正在审核" value="正在审核"></el-option>
            <el-option label="待审核" value="待审核"></el-option>
          </el-select>
        </el-col> -->
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
          label="ID"
          width="180">
        </el-table-column>
        <el-table-column
          prop="Title"
          label="名称"
          width="180">
        </el-table-column>
        <el-table-column
          label="类型"
          width="180">
          <template scope="scope">
             {{scope.row.ObjectType ? (scope.row.ObjectType == 1 ? '知识元':(scope.row.ObjectType == 2 ? '知识簇' :'知识链')): '暂无信息' }}
          </template>
        </el-table-column>
        <el-table-column
          label="审核状态">
          <template scope="scope">
             {{'已审核'}}
          </template>
        </el-table-column>
        <el-table-column
          prop="KoiNumber"
          label="KOI编码">
          <template scope="scope">
              {{scope.row.KoiNumber ? scope.row.KoiNumber : '未通过审核'}}
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
           winWidth:window.innerWidth,
           winHeight:window.innerHeight,
           toolsShow:false,
            tableData: [],
            tableData1: [],
            tableData2: [],
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
        * @return   {[type]}     [description]
        */
       getExplicitWordList() {
          this.$http.get('/KoiNumber/List',{
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
       handleOpen(key, keyPath) {
        console.log(typeof key);

       },
       handleClose(key, keyPath) {
        console.log(key, keyPath);
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
          this.$confirm('确认驳回?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            this.$message({
              type: 'success',
              message: '已驳回(功能演示)！'
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


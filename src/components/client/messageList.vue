<template>
  <div :style="{width: '92%',margin:'30px auto'}">
     <div class="table-page-title">
       <h3>
         消息列表
       </h3>
       <span class="yellow-place"></span>
     </div>
     <el-row>
        <el-col :span="18" >&nbsp;</el-col>
        <!--<el-col :span="4" >
          <el-select v-model="shenhe" >
            <el-option label="全部" value="全部"></el-option>
            <el-option label="正在审核" value="正在审核"></el-option>
            <el-option label="待审核" value="待审核"></el-option>
          </el-select>
        </el-col>-->
        <el-col :span="6" >
            <el-input 
              placeholder="请输入搜索关键字" 
              v-model="keyWord" 
              suffix-icon="el-icon-search"
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
          label="消息内容">
        </el-table-column>
        <el-table-column
          prop="CreateTime"
          label="创建时间">
           <!--<template scope="scope">
             {{scope.row.KoiNumber ? scope.row.KoiNumber : '未通过审核'}}
          </template>-->
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

           dialogFormVisible: false,
           updateDialogFormVisible:false,
           pageCount: 10,
           currentPage: 1,
           totalCount: 0,
//         form: {
//            Title: '',
//            Category: '',
//            Description: '',
//            Reference:'',
//         },
//         updateForm: {
//            Title: '',
//            Category: '',
//            Description: '',
//            Reference:'',
//         },
//         formLabelWidth: '120px',
//         shenhe:'全部',
           keyWord:'',
//         listType:'request'
        }
     },
     methods:{
       setWindow() {
           this.winWidth = window.innerWidth;
           this.winHeight = window.innerHeight;
       },
       //获取消息列表
       getExplicitWordList() {
          this.$http.get('/Message/List',{
            params:{
              UserId:100,
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
       //搜索
       handleIconClick() {
//     		alert(this.keyWord);
//        if(!this.keyWord) return;
         
          this.$http.get('/Message/List',{
             params:{
               KOITitle:this.keyWord
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
       handleOpen(key, keyPath) {
         switch(key) {
           case '1':

             break;
           case '2':

             break;
           default:
             break;
         }
       },
       handleClose(key, keyPath) {
         console.log(key, keyPath);
       },
       handleEdit(index, row) {
         console.log(index, row);
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
        this.listType = this.$route.query.listType;

        this.setWindow();
        this.getExplicitWordList();
        window.onresize = ()=>{
           this.setWindow();
        }
     },
     watch:{
      '$route':function(nv,ov) {
         this.listType = nv.query.listType;
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


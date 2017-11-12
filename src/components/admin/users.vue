<template>
  <div class="index-cont" :style="{height:winHeight +'px',width: '92%',margin:'30px auto'}">
    <div class="table-page-title">
       <h3>
         用户管理
       </h3>
       <span class="yellow-place"></span>
     </div>
    <el-row>
        <el-col :span="18" >&nbsp;</el-col>

        <el-col :span="6" >
            <el-input 
              placeholder="请输入用户名查找" 
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
          width="80">
        </el-table-column>
        <el-table-column
        	prop='RealName'
          label="用户名"
          width="180"
          align="center"
          >
        </el-table-column>
        <el-table-column
          label="帐号"
          prop="MobileNumber"
          align="center">
        </el-table-column>
        <el-table-column
          label="用户类型"
          width="180"
          align="center"
          >
          <template slot-scope="scope">
             {{scope.row.UserType == 2 ? "专家" :""}}
             {{scope.row.UserType == 3 ? "管理员" :""}}
             {{scope.row.UserType == 4 ? "用户" :""}}
          </template>
        </el-table-column>
                <el-table-column
                  prop="address"
                  label="操作">
                  <template slot-scope="scope">
                    <el-button
                      size="small"
                      @click="handleUpdateUser(scope.$index, scope.row)">修改</el-button>  
                    <el-button
                      size="small"
                      :type="scope.row.State == 1 ? 'danger':'success'"
                      @click="handleDelete(scope.$index, scope.row)">{{scope.row.State == 1 ? '停用':'启用'}}</el-button>
                  </template>
                </el-table-column>
    </el-table>
    
    
     <el-dialog
        title="编辑用户信息"
        :visible.sync="dialogVisible"
        width="60%"
        >
        <el-form :label-position="labelPosition" label-width="80px" :model="formLabelAlign">
          <el-form-item label="用户名">
            <el-input v-model="formLabelAlign.RealName" placeholder="请输入用户名"></el-input>
          </el-form-item>

          <el-form-item label="密码">
            <el-input v-model="formLabelAlign.Password" type="password" placeholder="请输入帐号/手机号"></el-input>
          </el-form-item>

          <el-form-item label="用户类型">
            <el-select v-model="formLabelAlign.UserType">
              <el-option label="专家" value="2"></el-option>
              <el-option label="管理员" value="3"></el-option>
              <el-option label="用户" value="4"></el-option>
            </el-select>
          </el-form-item>

        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="handleUpdate">确 定</el-button>
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
           winWidth:window.innerWidth,
           winHeight:window.innerHeight,
           toolsShow:false,
            tableData: [],
            dialogVisible:false,
            aa:'',
            shenhe:'全部',
            selectType:'全部',
            keyWord:'',
            labelPosition: 'right',
            formLabelAlign: {
              UserId:100,
              RealName: '',
              Password: '',
              UserType: '专家'    //用户类别:2-专家,3-管理员,4-用户
            },
            state:1, //用户状态，1--正常，2--已锁定，3-没有激活
            pageCount: 10,
            currentPage: 1,
            totalCount: 0
        }
     },
     methods:{
       setWindow() {
           this.$store.dispatch('setWindow',{
              winWidth:window.innerWidth,
              winHeight:window.innerHeight
           });
       },
       handleUpdateUser(index,row){
           this.dialogVisible = true;
           this.formLabelAlign = {
                UserId:row.Id,
                RealName: row.RealName,
                Password: '',
                UserType: row.UserType == 2 ?"专家":(row.UserType == 3 ? "管理员":'用户')
           }
       },

       /**
        * [getExplicitWordList 获取管理端列表数据]
        * @Author   罗文
        * @DateTime 2017-10-19
        * @return   {[type]}     [description]
        */
       getExplicitWordList() {
          this.$http.get('/User/List',{
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
       
       /**
        * [handleDelete 停用或解锁]
        * @Author   罗文
        * @DateTime 2017-10-30
        * @param    {[type]}   index [行索引]
        * @param    {[type]}   row   [行数据]
        * @return   {[type]}         [description]
        */
       handleDelete(index,row) {
            let state = 1;

            switch (row.State) {
              case 1:
                state = 2;
                break;
              case 2:
                state = 1;
                break;
              default:
                // statements_def
                break;
            }

            this.$http.post('/User/Update',{
              UserId:row.Id,
              State:state,
              UserType:row.UserType
            }).then((res) => {
              if (res.data.Code == 200) {
                 this.getExplicitWordList();
                 this.$message({
                    message: '修改成功！',
                    type: 'success'
                  });
                 this.dialogVisible = false;
              }else {
                 this.$message({
                    message: res.data.Description,
                    type: 'error'
                  });
                }
             })
       },

       /**
        * [handleUpdate 修改用户]
        * @Author   罗文
        * @DateTime 2017-10-30
        * @return   {[type]}   [description]
        */
       handleUpdate(){
            this.formLabelAlign.Password = hex_sha1(this.formLabelAlign.Password);
            switch (this.formLabelAlign.UserType) {
              case '专家':
                this.formLabelAlign.UserType = 2;
                break;
              case '管理员':
                this.formLabelAlign.UserType = 3;
                break;
              case '用户':
                this.formLabelAlign.UserType = 4;
                break;    
              default:
                // statements_def
                break;
            }

          	this.$http.post('/User/Update',this.formLabelAlign).then((res) => {
              if (res.data.Code == 200) {
                 this.getExplicitWordList();
                 this.$message({
                    message: '修改成功！',
                    type: 'success'
                  });
                 this.dialogVisible = false;
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
//    	alert('被点了');
          this.$http.get('/User/List',{
            params:{
              RealName:this.keyWord
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
        this.setWindow();
        this.getExplicitWordList('');
        this.getExplicitWordList(true);
        this.getExplicitWordList(false);
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
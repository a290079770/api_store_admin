<template>
  <div class="index-cont" :style="{height:winHeight +'px',width: '92%',margin:'30px auto'}">
    <div class="table-page-title">
       <h3>
         用户管理
       </h3>
       <span class="yellow-place"></span>
     </div>
    <el-row>
        <el-col :span="18" >
          <el-button
          size="success"
          @click="openAddUsersDialog" icon="el-icon-plus">新增用户</el-button>
        </el-col>

        <el-col :span="6" >
            <el-input 
              placeholder="请输入用户账号或昵称查找" 
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
              @click="handleResetPwd(scope.$index, scope.row)">重置密码</el-button>   
            <el-button
              size="small"
              :type="scope.row.State == 1 ? 'danger':'success'"
              @click="handleChangeState(scope.$index, scope.row)">{{scope.row.State == 1 ? '停用':'启用'}}</el-button>
            
          </template>
        </el-table-column>
    </el-table>
    
    
     <el-dialog
        title="新增用户"
        :visible.sync="dialogVisible"
        top="20vh"
        width="60%"
        >
        <el-form :label-position="labelPosition" ref="addUsers" label-width="120px" :model="formLabelAlign">
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
          <el-button type="primary" @click="openAddUsersDialog">确 定</el-button>
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

       handleResetPwd(index,row){
           this.$confirm('是否将该用户密码重置为 123456 ?', '提示', {
              confirmButtonText: '确定',
              cancelButtonText: '取消',
              type: 'warning'
            }).then(() => {
              
            }).catch(() => {
                       
            });
       },

       /**
        * [getExplicitWordList 获取用户列表数据]
        * @Author   罗文
        * @DateTime 2017-10-19
        * @return   {[type]}     [description]
        */
       getExplicitWordList() {
          this.apiTransfer('get','/User/List',{
             ps:this.pageCount,
             cp:this.currentPage,
             keyword:this.keyword
          },res => {
             if (res.data.Code == 200) {
               this.tableData = res.data.Data.ItemList;
               this.totalCount = res.data.Data.RecordCount;
             }else {
               this.$message({
                  message: res.data.Description,
                  type: 'error'
               });
            }
          }); 
       },
       
       /**
        * [handleChangeState 停用或解锁]
        * @Author   罗文
        * @DateTime 2017-10-30
        * @param    {[type]}   index [行索引]
        * @param    {[type]}   row   [行数据]
        * @return   {[type]}         [description]
        */
       handleChangeState(index,row) {
          let text = row.State == 1 ? '停用':'启用';
          this.$confirm('确定 '+text+' 该用户?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
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
          }).catch(() => {
        
          });
       },

       /**
        * [openAddUsersDialog 打开新增用户框]
        * @Author   罗文
        * @DateTime 2017-10-30
        * @return   {[type]}   [description]
        */
       openAddUsersDialog(){
        this.dialogVisible = true;
    
       },

       /**
        * [handleAddUsers 新增用户]
        * @Author   罗文
        * @DateTime 2017-10-30
        * @return   {[type]}   [description]
        */
       handleAddUsers(){
        this.dialogVisible = true;
    
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
        this.getExplicitWordList();
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
</style>
<template>
  <div class="index-cont" :style="{width:winWidth +'px',height:winHeight +'px',position:'relative'}">
     <div class="place-holder" :style="{width:winWidth +'px'}">
       
     </div>
     <el-row>
        <el-col :span="4" >
            <div class="cover-img">
              <div>
                 <img src="../../assets/images/n1.png" alt="">
              </div>
              <p><i class="el-icon-edit"></i>&nbsp;张三</p>
              <p><i class="el-icon-setting"></i>&nbsp;系统管理员</p>
            </div>
           <div class="side-bar" :style="{height:winHeight +'px'}">
             <el-menu default-active="1" class="el-menu-vertical-demo" @open="handleOpen" @close="handleClose">
              <el-menu-item index="1"><i class="el-icon-menu"></i>知识元</el-menu-item>
              <el-menu-item index="2"><i class="el-icon-setting"></i>知识簇</el-menu-item>
              <el-menu-item index="3"><i class="el-icon-search"></i>知识链</el-menu-item>
            </el-menu>
           </div>
        </el-col>
        <el-col :span="20">
           <el-row>
                <el-tabs type="border-card">
                   <el-tab-pane label="我的申请">
                     <el-button
                     size="small"
                     type="primary"
                      @click="dialogFormVisible = true">新增知识元</el-button>

                     <el-button
                     size="small"
                      @click="toAdmin">跳转后台(演示用)</el-button>  
                     <el-table
                      :data="tableData"
                      style="width: 100%;margin-top:15px">
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
                          prop="address"
                          label="审核状态">
                          <template scope="scope">
                             {{scope.row.ApplyLog ? '正在审核...' : '未审核'}}
                          </template>
                        </el-table-column>
                        <el-table-column
                          prop="KoiNumber"
                          label="KOI编码">
                           <template scope="scope">
                             {{scope.row.KoiNumber ? scope.row.KoiNumber : '未通过审核'}}
                          </template>
                        </el-table-column>
                        <el-table-column
                          prop="address"
                          label="操作">
                          <template scope="scope">
                            <el-button
                              size="small"
                              type="primary"
                              :disabled="scope.row.ApplyLog ? true:false"
                              @click="handleSubmitEdit(scope.$index, scope.row)">{{scope.row.ApplyLog ? '正在审核':'点击审核'}}</el-button>
                            <el-button
                              size="small"
                              @click="handleUpdateEdit(scope.$index, scope.row)">修改</el-button>  
                            <el-button
                              size="small"
                              type="danger"
                              @click="handleDelete(scope.$index, scope.row)">删除</el-button>
                          </template>
                        </el-table-column>
                    </el-table>
                </el-tab-pane>
                <el-tab-pane label="所有申请">
                     <el-table
                      :data="tableData"
                      style="width: 100%">
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
                          prop="address"
                          label="审核状态">
                          <template scope="scope">
                             {{scope.row.ApplyLog ? '正在审核...' : '未审核'}}
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
                </el-tab-pane>
              </el-tabs>
           </el-row>
        </el-col>
     </el-row>

     <el-dialog title="新增知识元" :visible.sync="dialogFormVisible">
        <el-form :model="form" style="width:90%">
          <el-form-item label="知识元名称" :label-width="formLabelWidth">
            <el-input v-model="form.Title" auto-complete="off"></el-input>
          </el-form-item>

          <el-form-item label="所属分类" :label-width="formLabelWidth">
            <el-select v-model="form.Category" placeholder="请选择活动区域">
              <el-option label="科学" value="科学"></el-option>
              <el-option label="建筑" value="建筑"></el-option>
              <el-option label="历史" value="历史"></el-option>
            </el-select>
          </el-form-item>

          <el-form-item label="参考资料" :label-width="formLabelWidth">
            <el-input v-model="form.Reference" auto-complete="off"></el-input>
          </el-form-item>

          <el-form-item label="知识元描述" :label-width="formLabelWidth">
            <el-input v-model="form.Description" type="textarea" auto-complete="off"></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="dialogFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="addNewExplicit">确 定</el-button>
        </div>
      </el-dialog>


      <el-dialog title="修改知识元" :visible.sync="updateDialogFormVisible">
        <el-form :model="updateForm" style="width:90%">
          <el-form-item label="知识元名称" :label-width="formLabelWidth">
            <el-input v-model="updateForm.Title" auto-complete="off"></el-input>
          </el-form-item>

          <el-form-item label="所属分类" :label-width="formLabelWidth">
            <el-select v-model="updateForm.Category" placeholder="请选择活动区域">
              <el-option label="科学" value="科学"></el-option>
              <el-option label="建筑" value="建筑"></el-option>
              <el-option label="历史" value="历史"></el-option>
            </el-select>
          </el-form-item>

          <el-form-item label="参考资料" :label-width="formLabelWidth">
            <el-input v-model="updateForm.Reference" auto-complete="off"></el-input>
          </el-form-item>

          <el-form-item label="知识元描述" :label-width="formLabelWidth">
            <el-input v-model="updateForm.Description" type="textarea" auto-complete="off"></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="dialogFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="updateExplicit">确 定</el-button>
        </div>
      </el-dialog>
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
           form: {
              Title: '',
              Category: '',
              Description: '',
              Reference:'',
           },
           updateForm: {
              Title: '',
              Category: '',
              Description: '',
              Reference:'',
           },
           formLabelWidth: '120px'
        }
     },
     methods:{
       setWindow() {
           this.winWidth = window.innerWidth;
           this.winHeight = window.innerHeight;
       },
       //获取知识元列表
       getExplicitWordList() {
          this.$http.get('/ExplicitWord/List',{
            params:{
              isFormal:''
            }
          }).then((res) => {
            if (res.data.Code == 200) {
               console.log(res.data)
               this.tableData = res.data.Data.ItemList;
            }else {
               this.$message({
                  message: res.data.Description,
                  type: 'error'
                });
            }
          })
       },
       //新增知识元
       addNewExplicit() {
          this.form.UserId = 100;

          this.$http.post('/ExplicitWord/Create',this.form).then((res) => {
            if (res.data.Code == 200) {
               this.$message({
                  message: '申请知识元成功！',
                  type: 'success'
                });
               this.dialogFormVisible = false;
               this.getExplicitWordList();
            }else {
               this.$message({
                  message: res.data.Description,
                  type: 'error'
                });
             }
          })

       },
       //修改知识元
       handleUpdateEdit(index,item) {
         this.updateDialogFormVisible = true;
         this.updateForm = {
              Title: item.Title,
              Category: item.Category,
              Description: item.Description,
              Reference:item.Reference
         }
       },
       //确认修改知识元
       updateExplicit() {
        this.updateDialogFormVisible = false;
          //  this.$http.post('/ExplicitWord/Create',this.form).then((res) => {
          //   if (res.data.Code == 200) {
          //      this.$message({
          //         message: '申请知识元成功！',
          //         type: 'success'
          //       });
          //      this.dialogFormVisible = false;
          //      this.getExplicitWordList();
          //   }else {
          //      this.$message({
          //         message: res.data.Description,
          //         type: 'error'
          //       });
          //   }
          // })
       },
       //提交审核
       handleSubmitEdit(index,item) {
         let data = {
            UserId:100,
            ObjectId:item.Id,
            ObjectType:1
         }

        this.$http.post('/ApplyLog/Create',data).then((res) => {
          if (res.data.Code == 200) {
             this.$message({
                message: '提交审核成功！',
                type: 'success'
              });

             this.getExplicitWordList();
          }else {
             this.$message({
                message: res.data.Description,
                type: 'error'
              });
          }
        })
       },
       handleOpen(key, keyPath) {
         console.log(key, keyPath);
       },
       handleClose(key, keyPath) {
         console.log(key, keyPath);
       },
       handleEdit(index, row) {
         console.log(index, row);
       },
       //删除知识元
       handleDelete(index, row) {
          this.$confirm('确认删除知识元?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            this.$message({
              type: 'success',
              message: '删除成功(功能演示)！'
            });
          }).catch(() => {
        
          });
       },

       toAdmin() {
         this.$router.push('/admin')
       }
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


      .cover-img {
      width:100%;
      height:200px;
      overflow: hidden;
   }

   .cover-img img {
      display: flex;
      justify-content: center;
      align-items: center;
      width: 100px;
      height: 100px;
      /*background: green;*/
      border-radius: 50%;
      margin: 20px 30px 0;
   }

/*   .cover-img div img {
      width: 100%;
      height: 100%;
   }
*/
   .cover-img p {
      margin: 10px 25px;
      color:#337ab7;
   }

   .place-holder {
      border:1px solid #eee;
      position:fixed;
      left:0;
      top:0;
      z-index: 999;
   }
</style>


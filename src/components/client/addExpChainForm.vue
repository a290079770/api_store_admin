<template>
  <div >
     <div class="add-exp-form">
        <div class="table-page-title add-form">
           <h3>
             知识链
           </h3>
           <span class="yellow-place"></span>
         </div>
        <el-form :model="form" style="width:90%;margin-top:40px;">
        <el-form-item label="知识链名称" :label-width="formLabelWidth">
          <el-input v-model="form.Title" placeholder="请输入知识链名称" auto-complete="off"></el-input>
        </el-form-item>

        <el-form-item label="所属分类" :label-width="formLabelWidth">
          <el-select v-model="form.Category" placeholder="请选择所属分类">
            <el-option label="科学" value="科学"></el-option>
            <el-option label="建筑" value="建筑"></el-option>
            <el-option label="历史" value="历史"></el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="参考资料" :label-width="formLabelWidth">
          <el-input v-model="form.Reference" placeholder="请输入参考资料" auto-complete="off"></el-input>
        </el-form-item>

        <el-form-item label="知识链描述" :label-width="formLabelWidth">
          <el-input v-model="form.Description" placeholder="请输入知识链描述" type="textarea" auto-complete="off"></el-input>
        </el-form-item>

        <el-form-item label="编辑语言" :label-width="formLabelWidth">
          <el-select v-model="form.Language" placeholder="请选择知识链编辑时使用的语言">
            <el-option label="汉语" value="汉语"></el-option>
            <el-option label="英语" value="英语"></el-option>
            <el-option label="法语" value="法语"></el-option>
            <el-option label="德语" value="德语"></el-option>
            <el-option label="阿拉伯语" value="阿拉伯语"></el-option>
          </el-select>
        </el-form-item>


       <el-form-item label="科学名称语言" :label-width="formLabelWidth">
          <el-select v-model="form.ScientificLanguage" placeholder="请选择科学名称语言">
            <el-option label="汉语" value="汉语"></el-option>
            <el-option label="英语" value="英语"></el-option>
            <el-option label="法语" value="法语"></el-option>
            <el-option label="德语" value="德语"></el-option>
            <el-option label="阿拉伯语" value="阿拉伯语"></el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="科学名称" :label-width="formLabelWidth">
          <el-input v-model="form.ScientificName" placeholder="请输入知识链科学名称" type="input" auto-complete="off"></el-input>
        </el-form-item>

        <el-form-item label="编辑知识链" :label-width="formLabelWidth">
          <el-button size="small" @click="openChainDialog">编 辑</el-button>
        </el-form-item> 

        <el-form-item label="修改信息" :label-width="formLabelWidth" v-show="$route.query.isUpdate">
          <el-input v-model="form.updateDescription" placeholder="请输入知识链修改描述" type="textarea" auto-complete="off"></el-input>
        </el-form-item>
      </el-form>

      <div>
         <el-button type="warning"  style="margin-left: 100px" @click="addNewExplicit">{{$route.query.isUpdate ? '修 改':'确 定'}}</el-button>
         <el-button @click="dialogFormVisible = false">取 消</el-button>
      </div>

      <el-dialog
        title="创建知识链路"
        :visible.sync="dialogVisible"
        width="60%"
        top="30px"
        >
          <div style="width:90%;margin:30px auto">
            知识列表
          </div>

         <div class="ex-chain">
           <ul>
             <li v-for="(item,index) in tableData" @click="fullText(item)">{{item.Title}}</li>
             
           </ul>
         </div>

         <div style="width:90%;margin:30px auto">
            <el-button size="small" @click="addOneChain">+ 新增链路</el-button>
         </div>
         <ul class="chain-list">
           <li v-for="(item,index) in chainList">
             开始： <el-input v-model="item.start" placeholder="请选择开始" style="width:150px;margin-right:30px" @keydown.native="forbidInput($event)" @focus="inputWillFullText(index,1)"></el-input>
             结束： <el-input v-model="item.end" placeholder="请选择结束" style="width:150px" @keydown.native="forbidInput($event)" @focus="inputWillFullText(index,2)"></el-input>
           </li>
         </ul>


          <div style="width:90%;margin:0 auto;padding:30px 0 2px;border-top:1px solid #ddd">
            <el-button size="small" @click="renderEcharts">生成知识链</el-button>
          </div>


          <div ref="explicitWordSet" class="exp-content">
            
          </div>

        <span slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="warning" @click="getSelectKoi">确 定</el-button>
        </span>
      </el-dialog>

    </div>

  </div>
</template>

<script>
   import echarts from 'echarts';
   export default {
     data(){
      return {
           winWidth:window.innerWidth,
           winHeight:window.innerHeight,
           toolsShow:false,
           form: {
              Title: '',
              Category: '科学',
              Description: '',
              Reference:'',
              Language:'汉语',
              ScientificLanguage:'汉语',
              ScientificName:'',
              KoiNumber:null,
              Relations:'',
              updateDescription:''
           },
           formLabelWidth: '100px',
           dialogVisible:false,
           tableData: [],
           importances:0,
           multipleSelection: [],
           echartsOptions:null,
           inputBox:{
            row:0,
            which:1,
           }, //用于设置应该填充哪一行哪一个input
           chainList:[
             {
              start:'',
              end:'',
             }
           ],
           chainListKoiNum:[
             {
              FirstKoi:'',
              SecondKoi:'',
              IsStartPoint:false
             }
           ],


        }
     },
     methods:{
        forbidInput(e) {
           e.preventDefault();
        },
        setWindow() {
           this.winWidth = window.innerWidth;
           this.winHeight = window.innerHeight;
       },
       //获取KOI列表
       getExplicitWordList() {
          this.$http.get('/KoiNumber/List',{
            params:{
              
            }
          }).then((res) => {
            if (res.data.Code == 200) {
               this.tableData = res.data.Data.ItemList;
               this.tableData.forEach((item,index)=>{
                 item.weight = 1;
               })
            }else {
               this.$message({
                  message: res.data.Description,
                  type: 'error'
                });
            }
          })
       },

       /**
        * [getFormData 修改KOI时获取数据]
        * @Author   罗文
        * @DateTime 2017-10-26
        * @param    {[String]}   data [KOI编码或Id]
        * @param    {[Number]}   type [1 - 通过KOI修改 2- 通过Id修改]
        * @return   {[type]}             [description]
        */
       getFormData(data,type) {
          let params = {};
          let apiName = '';
          if(type == 1) {
            params = {
               KoiNumber:data
             }
            apiName = '/KoiNumber/Detail';
          }else if(type == 2){
            params = {
               Id:data
             }

            apiName = '/ExplicitWordChain/Detail'; 
          }

          this.$http.get(apiName,{
             params:params
          }).then((res) => {
            if (res.data.Code == 200) {
                this.form = res.data.Data.ExplicitWordChain;
                this.form.updateDescription = '';
                //渲染链路
                this.renderExplicitWordChainForUpdate(this.form.Relations);
            }else {
               this.$message({
                  message: res.data.Description,
                  type: 'error'
                });
             }
          })

       },
       
       /**
        * [renderExplicitWordChainForUpdate 如果是修改则渲染知识链路]
        * @Author   罗文
        * @DateTime 2017-10-31
        * @param    {[Array]}   relations [链路关系数组]
        * @return   {[type]}             [description]
        */
       renderExplicitWordChainForUpdate(relations) {
          
          this.chainList = [];
          this.chainListKoiNum = [];
          
          relations.forEach((item,index)=>{
            this.chainList.push({
              start:item.FirstKoiName,
              end:item.SecondKoiName
            })

            this.chainListKoiNum.push({
              FirstKoi:item.FirstKoi,
              SecondKoi:item.SecondKoi,
              IsStartPoint:false
            })
          })

       },
      
       /**
        * [openChainDialog 打开模态框，如果是修改，则要渲染echats]
        * @Author   罗文
        * @DateTime 2017-10-31
        * @return   {[type]}   [description]
        */
       openChainDialog() {
          this.dialogVisible = true;
          this.$nextTick(()=>{
            if(this.$route.query.isUpdate) {
               this.renderEcharts();
            }
          })
       },

       addNewExplicit() {
          if(this.validateForm()) {
             this.form.UserId = 100;

             if(this.form.Relations instanceof Array) {
                this.getSelectKoi();
             }else if(this.chainList[0].start === '') {
                this.$message({
                        message: '请填写知识链！',
                        type: 'error'
                      })
                return;
             }

             //如果是修改
             if(this.$route.query.isUpdate) {
                this.form.KoiNumber = this.$route.query.koiNumber;
             }

             this.$http.post('/ExplicitWordChain/CreateOrUpdate',this.form).then((res) => {
              if (res.data.Code == 200) {
                 this.$message({
                    message: this.$route.query.isUpdate ?'修改知识链成功，已提交审核！':'新增知识链成功，已提交审核！',
                    type: 'success'
                  });

                 let actionType = this.$route.query.isUpdate ? 2: 1;

                 this.submitApplyLog(res.data.Data,3,actionType);

                 //不管是新增还是修改，都需要提交审核


              }else {
                 this.$message({
                    message: res.data.Description,
                    type: 'error'
                  });
                }
             })
          }
       },
       
       /**
        * [getSelectKoi 获取选中的KOI]
        * @Author   罗文
        * @DateTime 2017-10-27
        * @return   {[type]}   [description]
        */
       getSelectKoi() {
          if(this.chainList[0].start === '') {
            this.$message({
                    message: '请填写知识链！',
                    type: 'error'
                  })
            return;
          }

          this.form.Relations = JSON.stringify(this.chainListKoiNum);

          this.dialogVisible = false;
       },

       
       toggleSelection(rows) {
          if (rows) {
            rows.forEach(row => {
              this.$refs.multipleTable.toggleRowSelection(row);
            });
          } else {
            this.$refs.multipleTable.clearSelection();
          }
        },

        handleSelectionChange(val) {
          this.multipleSelection = val;
        },
       
       /**
        * [submitApplyLog 提交审核]
        * @Author   罗文
        * @DateTime 2017-10-26
        * @return   {[type]}   [description]
        */
       submitApplyLog(objectId,objectType,actionType) {
           this.$http.post('/ApplyLog/Create',{
              ObjectId:objectId,
              ObjectType:objectType,
              ActionType:actionType,
              UserId:100,
              Description:actionType == 2 ? this.form.updateDescription :''
           }).then((res) => {
            if (res.data.Code == 200) {
               setTimeout(()=>{
                 let listType = this.$route.query.isUpdate ? 'update':'create';
                 this.$router.push({
                    path:'/wrap/updateList',
                    query:{
                      listType:listType
                    }
                 })
               }, 1000)
            }else {
             this.$message({
                message: res.data.Description,
                type: 'error'
              });
            }
         })
       },
       /**
        * [validateForm 表单验证]
        * @Author   罗文
        * @DateTime 2017-10-25
        * @return   {[Boolean]}   [返回验证通过还是失败]
        */
       validateForm() {
          //验证知识链名
          if(this.form.Title === '' || /[^a-zA-Z0-9_\u4e00-\u9fa5]/g.test(this.form.Title)) {
              this.$message({
                type: 'error',
                message: '知识链名称不能为空，或含有特殊字符！'
              });
             return false;
          } 

          //验证参考资料
          /*if(this.form.Reference === '' ||this.form.Reference.indexOf('《') === -1 || this.form.Reference.indexOf('》') === -1) {
              this.$message({
                type: 'error',
                message: '参考资料不能为空，或格式不正确！'
              });
             return false;
          } */

          //验证描述
          if(this.form.Description === '') {
              this.$message({
                type: 'error',
                message: '知识链描述不能为空，或格式不正确！'
              });
             return false;
          } 


          //验证是否有关联关系
          if(this.form.Relations === '') {
              this.$message({
                type: 'error',
                message: '请编辑知识链！'
              });
             return false;
          } 


          //如果是修改，则还必须验证修改描述
          if(this.$route.query.isUpdate) {
              if(this.form.updateDescription == '') {
                  this.$message({
                    type: 'error',
                    message: '修改描述不能为空！'
                  });
                 return false;
              } 
          }
          

          return true;
       },
       
       /**
        * [addOneChain 新增一条链路]
        * @Author   罗文
        * @DateTime 2017-10-30
        */
       addOneChain() {
         this.chainList.push({
          start:'',
          end:''
         });

         this.chainListKoiNum.push({
           FirstKoi:'',
           SecondKoi:'',
           IsStartPoint:false
         });

       },
 
       /**
        * [inputWillFullText 保存即将填入数据的input]
        * @Author   罗文
        * @DateTime 2017-10-30
        * @param    {[Number]}   index [哪一行的索引]
        * @param    {[Number]}     which    [开始还是结束框 1 - 开始 2- 结束]
        * @return   {[type]}         [description]
        */
       inputWillFullText(index,which) {
          this.inputBox = {
            row:index,
            which:which,
            koiNumber:''
          }
       },
       
       /**
        * [fullText 对输入框填充数据]
        * @Author   罗文
        * @DateTime 2017-10-30
        * @param    {[type]}   item [description]
        * @return   {[type]}        [description]
        */
       fullText(item) {
         let which = this.inputBox.which == 1?'start':'end';
         let times = this.inputBox.which == 1?'FirstKoi':'SecondKoi';
         this.$set(this.chainList[this.inputBox.row],which,item.Title);
         this.$set(this.chainListKoiNum[this.inputBox.row],times,item.KoiNumber);
       },

       /**
        * [renderEcharts 绘制echarts,知识链图]
        * @Author   罗文
        * @DateTime 2017-10-27
        * @return   {[type]}   [description]
        */
       renderEcharts() {
          //这里需要去重，保留节点唯一
          let hash = [];
          let links = [];

          this.chainList.forEach((item,index)=>{
              if(hash.indexOf(item.start) == -1) {
                 hash.push(item.start);
              }

              if(hash.indexOf(item.end) == -1) {
                 hash.push(item.end);
              }

              //处理关系links
              links.push({
                source: item.start,
                target: item.end
              })

          })

          if(hash.join('') === '') return; 
          
          //渲染节点
          let arr = [];
          hash.forEach((item,index)=>{
              arr.push({
                  name:item,
                  // x: index * 300,
                  // y: 300
                  x: Math.floor(Math.random()*300),
                  y: Math.floor(Math.random()*300)
              })

          })


          this.echartsOption(arr,links);
          
          let myChart = echarts.init(this.$refs.explicitWordSet);
          
          myChart.setOption(this.echartsOptions);
       },

       echartsOption(arr,links) {
         let _this = this;
         this.echartsOptions = {
              title: {
                  text: _this.form.title
              },
              tooltip: {},
              animationDurationUpdate: 1500,
              animationEasingUpdate: 'quinticInOut',
              series : [
                  {
                      type: 'graph',
                      layout: 'none',
                      symbolSize: 50,
                      roam: true,
                      label: {
                          normal: {
                              show: true
                          }
                      },
                      edgeSymbol: ['circle', 'arrow'],
                      edgeSymbolSize: [4, 10],
                      edgeLabel: {
                          normal: {
                              textStyle: {
                                  fontSize: 20
                              }
                          }
                      },
                      data: [...arr],
                      // links: [],
                      links: [...links],
                      lineStyle: {
                          normal: {
                              opacity: 0.9,
                              width: 2,
                              curveness: 0
                          }
                      }
                  }
              ]
          };
       },

     },
     mounted() {
        this.setWindow(); 
        //如果是修改，则获取数据
        if(this.$route.query.isUpdate) {
            if(this.$route.query.koiNumber) {
               this.getFormData(this.$route.query.koiNumber,1);
            }else if(this.$route.query.id) {
               this.getFormData(this.$route.query.id,2);
            }else {
               this.$message({
                  type: 'error',
                  message: '未获取到修改数据！'
                });
            }
        }

        this.getExplicitWordList();

        window.onresize = ()=>{
           this.setWindow();
        }
     }
   }
</script>
<style lang="css" scoped>
    .add-exp-form {
      margin: 0 auto;
      width: 90%;
    }


    .exp-content {
      margin: 30px auto;
      width: 90%;
      height: 300px;
      border: 1px solid #337ab7;
    }

    .ex-chain {
      margin: 0 auto;
      width: 90%;
      min-height: 100px;
      max-height: 400px;
      border: 1px solid #337ab7;
      overflow-y: scroll;
      
    }

    .ex-chain li {
        display: flex;
        justify-content: center;
        align-items: center;
        float: left;
        margin: 10px;
        border: 1px solid #337ab7;
        border-radius: 5px;
        width: 120px;
        height: 30px;
        overflow: hidden;
        text-overflow: ellipsis;
        cursor: pointer;

      }

      .ex-chain li:hover {
        background: #337ab7;
        color:white;
      }

      .chain-list {
        width:90%;
        margin:30px auto
      }

      .chain-list li {
        display: flex;
        justify-content: flex-start;
        align-items: center;
        margin: 10px 0
      }
</style>


<template>
	<div :style="{width: '92%',margin:'30px auto'}">
		<div class="table-page-title">
	       <h3>
	         我的{{listType=="create"?'申请':(listType=="update"?'修改':'注销')}}
	       </h3>
	       <span class="yellow-place"></span>
	     </div>
		<el-row>
			<el-col :span="5">&nbsp;</el-col>
			<el-col :span="12">
				<el-select v-model="expType" @change="getExplicitWordList"  placeholder="选择KOI类型" style="width:200px">
					<el-option label="全部" value="0"></el-option>
					<el-option label="知识元" value="1"></el-option>
					<el-option label="知识簇" value="2"></el-option>
					<el-option label="知识链" value="3"></el-option>
				</el-select> 

				<el-select v-model="shenhe" @change="getExplicitWordList"  placeholder="选择审核状态" style="width:200px">
					<el-option label="全部" value="3"></el-option>
					<el-option label="正在审核" value="0"></el-option>
					<el-option label="审核通过" value="1"></el-option>
					<el-option label="驳回" value="2"></el-option>
				</el-select>
			</el-col>
			<el-col :span="1">&nbsp;</el-col>
			<el-col :span="6">
				<el-input placeholder="名称关键字" suffix-icon="el-icon-search" v-model="keyWord"  @keyup.enter.native="handleIconClick">
				</el-input>
			</el-col>
		</el-row>
		<el-table :data="tableData" style="margin-top:30px" :border="true">
			<el-table-column prop="Id" label="ID" width="80">
			</el-table-column>
			<el-table-column prop="Title" label="名称" width="180">
			</el-table-column>
			<el-table-column label="类型" width="180">
				<template scope="scope">
					{{renderType(scope.row.ObjectType)}}
				</template>
			</el-table-column>
			<el-table-column prop="address" label="一审状态">
				<template scope="scope">
					{{scope.row.FirstAuditState == 0 ? '正在审核...':(scope.row.FirstAuditState == 1 ? '审核通过':'') }} 
					<el-button size="small" type="danger" v-if="scope.row.FirstAuditState == 2" @click="showUnAcceptDescription(scope.row.FirstAuditDescription)" >已驳回</el-button>
				</template>
			</el-table-column>
			<el-table-column prop="secondAuditState" label="二审状态">
				<template scope="scope">
					{{scope.row.SecondAuditState == 0 ? '正在审核...':(scope.row.SecondAuditState == 1 ? '审核通过':'')}} 
					<el-button size="small" type="danger" v-if="scope.row.SecondAuditState == 2" @click="showUnAcceptDescription(scope.row.SecondAuditDescription)" >已驳回</el-button>
				</template>
			</el-table-column>
			<el-table-column prop="KoiNumber" label="KOI编码">
				<template scope="scope">
					{{scope.row.KoiNumber ? scope.row.KoiNumber : '未通过审核'}}
				</template>
			</el-table-column>
			<el-table-column prop="address" label="操作" align="center">
				<template scope="scope">
					<el-button v-if="scope.row.SecondAuditState == 2 || scope.row.FirstAuditState == 2" size="small" @click="handleUpdateEdit(scope.$index, scope.row)">修改元数据</el-button>
					<el-button
                      size="small"
                      type="primary"
                      v-else
                      @click="handleKoiDetail(scope.$index,scope.row)">查看详情</el-button>
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


	    <el-dialog :title="itemTitle" top="30px" :visible.sync="dialogFormVisible">
		  <koi-detail :formData="formData" ></koi-detail>

		  <div slot="footer" class="dialog-footer">
		    <el-button @click="dialogFormVisible = false">关 闭</el-button>
		  </div>
		</el-dialog>
	</div>
</template>

<script>
    import KoiDetail from './koiDetail.vue';
	export default {
		data() {
			return {
				winWidth: window.innerWidth,
				winHeight: window.innerHeight,
				toolsShow: false,
				tableData: [],

				dialogFormVisible: false,
		        formLabelWidth: '120px',
				shenhe: '',
				expType: '',
				keyWord: '',
				listType: 'create',
				pageCount: 10,
                currentPage: 1,
                totalCount: 0,
                formData:{},
                itemTitle:''
			}
		},
		components:{
	      'koi-detail':KoiDetail,
	     },
		methods: {
			setWindow() {
				this.winWidth = window.innerWidth;
				this.winHeight = window.innerHeight;
			},
			showUnAcceptDescription(description){				
				this.$alert('驳回理由：'+description, {
		          confirmButtonText: '确定',
		          center: true,
		          type:'warning'
		        });
			}
			,
			//获取知识元列表
			getExplicitWordList() {
				let ActionType = 0;

				switch(this.listType) {
					case 'create':
						ActionType = 1;
						break;
					case 'update':
						ActionType = 2;
						break;
					case 'delete':
						ActionType = 3;
						break;
					default:
						// statements_def
						break;
				}
				let shenhe = this.shenhe || 3;
				let expType = this.expType || 0;

				this.$http.get('/ApplyLog/List', {
					params: {
						UserId: 100,
						ActionType: ActionType,
						ps:this.pageCount,
		                cp:this.currentPage,
		                keyword:this.keyword,
		                ObjectType:expType,
		                SecondAuditState:shenhe,
					}
				}).then((res) => {
					console.log(res.data.Data)
					if(res.data.Code == 200) {
						this.tableData = res.data.Data.ItemList;
						this.totalCount = res.data.Data.RecordCount;
					} else {
						this.$message({
							message: res.data.Description,
							type: 'error'
						});
					}
				})
			},

			handleKoiDetail(index,row) {
                this.dialogFormVisible = true;
                this.itemTitle = row.Title;

				let apiName = '/ExplicitWord/Detail';

				switch(row.ObjectType) {
					case 1:
						apiName = '/ExplicitWord/Detail';
						break;
					case 2:
						apiName = '/ExplicitWordSet/Detail';
						break;
					case 3:
						apiName = '/ExplicitWordChain/Detail';
						break;
					default:
						// statements_def
						break;
				}

				this.$http.get(apiName, {
					params: {
						Id:row.ObjectId
					}
				}).then((res) => {
					if(res.data.Code == 200) {
						 this.formData = res.data.Data
					} else {
						this.$message({
							message: res.data.Description,
							type: 'error'
						});
					}
				})
			},

			//修改知识元
	       handleUpdateEdit(index,item) {
	         let path = '/wrap/addExpForm';
	         item.ObjectType = parseInt(item.ObjectType);

	          switch (item.ObjectType) {
	            case 1:
	              path = '/wrap/addExpForm';
	              break;
	            case 2:
	              path = '/wrap/addExpSetForm';
	              break;
	            case 3:
	              path = '/wrap/addExpChainForm';
	              break;  
	            default:
	              // statements_def
	              break;
	          }
	         
	         this.$router.push({
	            path:path,
	            query:{
	             isUpdate:true,
	             id:item.ObjectId
	           }
	         });
	        
	       },

			//搜索
			handleIconClick() {
				let ActionType = 0;
				switch(this.listType) {
					case 'create':
						ActionType = 1;
						break;
					case 'update':
						ActionType = 2;
						break;
					case 'delete':
						ActionType = 3;
						break;
					default:
						// statements_def
						break;
				}
				this.$http.get('/ApplyLog/List', {
					params: {
						UserId: 100,
						ActionType: ActionType,
						ps:this.pageCount,
		                cp:this.currentPage,
		                Title:this.keyWord
					}
				}).then((res) => {
					console.log(res.data.Data)
					if(res.data.Code == 200) {
						this.tableData = res.data.Data.ItemList;
						this.totalCount = res.data.Data.RecordCount;
					} else {
						this.$message({
							message: res.data.Description,
							type: 'error'
						});
					}
				})
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

			toAdmin() {
				this.$router.push('/admin')
			}
		},
		mounted() {
			this.listType = this.$route.query.listType;

			this.setWindow();
			this.getExplicitWordList();
			window.onresize = () => {
				this.setWindow();
			}
		},
		watch: {
			'$route': function(nv, ov) {
				this.listType = nv.query.listType;
				this.getExplicitWordList();
			}
		}
	}
</script>
<style lang="css">
/*	.side-bar {
		background: rgb(238, 241, 236);
	}*/
	
	.el-table__body-wrapper {
		overflow: hidden !important;
	}
</style>
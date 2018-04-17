<?php
namespace app\admin\controller;
use think\Controller;
use think\request;
use think\Db;

use lib\response;

class Api extends Controller
{
	private $response = null;

	private $errorInfo = array(
       0 => '标题不能为空！',
       1 => '中文描述不能为空！',
       2 => '所属分类不能为空',
       3 => '请求方式不能为空！',
       4 => '必须是post请求',
	);

	public function __construct() {
        $this->response = new Response();
	}

    /**
     * [apiList 获取该产品的api列表]
     * @Author   罗文
     * @DateTime 2018-04-16
     * @return   [type]     [description]
     */
    public function apiList()
    {
    	if(!request()->get('ProductId')) {
       	  $this->response->setResponse(21,'所属产品编号不能为空！');
       	  return;
        }

        $cateList = array();

        if(request()->get('keywords') && request()->get('keywords') !== '') {
           //先查找该产品下所有该关键字的api，再遍历api查找对应的分类
           $apis = Db::name('apis')
           ->where('ProductId',request()->get('ProductId'))
           ->where('Title|ApiTitle','like','%'.request()->get('keywords').'%')
           ->select();

           $cateList = array();

           if(count($apis) > 0) {
           	  //先push一条进去，才能进行后面的foreach循环
              $cate = Db::name('category')
		        	 ->where('Id',$apis[0]['CateId'])
		        	 ->select();
		      $cate = $cate[0];
		      
		      $cate['ItemList'] = array();
		      $cate['ItemList'][] = $apis[0];

		      array_push($cateList,$cate);	

		      array_splice($apis,0,1);

		      foreach ($apis as $k => $v) {
           	    foreach ($cateList as $ck => $cv) {

                   if($cv['Id'] == $v['CateId']) {
                   	  //如果匹配成功，则说明分类数组里已经有这个分类，此时只需要将该api push到这个分类数组中
                   	  array_push($cateList[$k]['ItemList'],$v);
                   	  break;
                   }

                   if($ck >= count($cateList) - 1) {
                   	  //已经到最后一项，还没匹配成功，就需要去数据库取对应的category信息，并创建一个itemlist
                   	  $cate = Db::name('category')
				        	 ->where('Id',$v['CateId'])
				        	 ->select();
				      $cate = $cate[0];
				      
				      $cate['ItemList'] = array();
				      $cate['ItemList'][] = $v;

				      array_push($cateList,$cate);	 
                   } 
           	    }
	          }
           }

           

        }else {
            //先获取所有的分类
	        $cateList = Db::name('category')->where('ProductId',request()->get('ProductId'))->select();
	        foreach ($cateList as $k => $v) {
	        	$cateList[$k]['ItemList'] = Db::name('apis')
	        	->where('CateId',$v['Id'])
	        	->select();
	        }
        }

        

	    $this->response->setResponse(200,'成功！',$cateList);
	}

    /**
     * [createOrUpdate 新增或修改api]
     * @Author   罗文
     * @DateTime 2018-04-16
     * @return   [type]     [description]
     */
    public function createOrUpdate()
    {   
        //必须post访问
        if(request()->isGet()) {
          $this->response->setResponse(21,$this->errorInfo[4]);
          return;
        }

        //验证必备字段，api名称、中文说明、所属分类、请求方式
        $neccess = ['Title','ApiTitle','CateId','Methods'];
        
        foreach ($neccess as $k => $v) {
           if(!request()->post($v)) {
           	  $this->response->setResponse(21,$this->errorInfo[$k]);
           	  return;
           }
        }
        //提取输入参数和输出参数
       $inputs = request()->post('InputParams/a') ? request()->post('InputParams/a') : array();
       $outputs = request()->post('OutputParams/a') ? request()->post('OutputParams/a') : array();  // /a表示接受一個數組
       foreach ($inputs as $k => $v) {
       	  $v['IsNecessary'] = $v['IsNecessary'] === 'true'? 1 : 0;
          $inputs[$k] = $v;
	   }

	   foreach ($outputs as $k => $v) {
          $v['IsNecessary'] = $v['IsNecessary'] === 'true'? 1 : 0;
          $outputs[$k] = $v;
	   }


       $arr = array(
         'Title' => request()->post('Title'),
	     'Description' => request()->post('Description'),
	     'ApiTitle' => request()->post('ApiTitle'),
	     'CateId' => request()->post('CateId'),
	     'Methods' => request()->post('Methods'),
	     'ProductId' => request()->post('ProductId')
       );
        // 提交新增和修改接口
        //如果传入了Id参数，则是修改，否则为新增
        if(request()->post('Id')) {
           //这里是删除操作，需要先清空参数表中已有的关联参数，再新增现有的参数
           $arr['Id'] = request()->post('Id');

           // 启动事务
		    Db::startTrans();
			try{
			    //更新api
	           $res = Db::name('apis')
	           ->where('Id',request()->post('Id'))
	           ->update($arr);

	           // if($res === 1) {
	             //修改api成功，更新输入输出参数
	             //首先将输入数组分为有id的和没id的
	             $inputHasId = array(); 
	             $inputNoId = array(); 
	             $inputIds = array();
	             $outputHasId = array(); 
	             $outputNoId = array(); 
	             $outputIds = array(); 
                 
                 //收集输入参数
	             foreach ($inputs as $k => $v) {
	             	if(isset($v['Id'])) {
	             	  $inputHasId[$k] = $v;
	             	  array_push($inputIds, $v['Id']);

	             	  Db::name('input_params')
	             	  ->where('Id',$v['Id'])
	             	  ->update($v);
	             	}else {
	             	  $inputNoId[$k] = $v;
	             	}
	             }
                 
                 //收集输出参数
	             foreach ($outputs as $k => $v) {
	             	if(isset($v['Id'])) {
	             	  $outputHasId[$k] = $v;
	             	  array_push($outputIds, $v['Id']);

	             	  Db::name('output_params')
	             	  ->where('Id',$v['Id'])
	             	  ->update($v);
	             	}else {
	             	  $outputNoId[$k] = $v;
	             	}
	             }

	             //先删除掉 not in Ids集合中的输入输出参数
	             Db::name('input_params')
	             ->where('ApiId',request()->post('Id'))
	             ->where('Id','not in',$inputIds)
	             ->delete();
	             Db::name('output_params')
	             ->where('ApiId',request()->post('Id'))
	             ->where('Id','not in',$outputIds)
	             ->delete();

                 //更新有id的
                 // Db::name('input_params')->saveAll($inputHasId);
                 // Db::name('output_params')->saveAll($outputHasId);

                 //新增没有id的
                 Db::name('input_params')->insertAll($inputNoId);
                 Db::name('output_params')->insertAll($outputNoId);

                 $this->response->setResponse(200,'修改成功！',request()->post('Id'));

	             Db::commit();  //提交事务
	           // }else {
	           //   $this->response->setResponse(21,'修改失败！');
	           //   Db::rollback();
	           // }
	           //更新输入输出参数
			} catch (\Exception $e) {
			    // 回滚事务
			    echo $e;
			    Db::rollback();
			}

           
        }else {
           //这里是新增操作，向api表写入api，将输入和输出参数分别写入对应的表
           
           //先写入api，获得ApiId
           $res = Db::name('apis')->insert($arr);

	       if($res == 1) {
	          $ApiId = Db::name('apis')->getLastInsID();

	          foreach ($inputs as $k => $v) {
	          	 $v['ApiId'] = $ApiId;
	          	 $inputs[$k] = $v;
	          }

	          foreach ($outputs as $k => $v) {
	          	 $v['ApiId'] = $ApiId;
	          	 $outputs[$k] = $v;
	          }

	          //再根据ApiId写入对应的输入参数和输出参数
	           if(count($inputs) > 0) {
		           $res = Db::name('input_params')->insertAll($inputs);

			       if($res !== count($inputs)) {
			       	 //表示没有完全插入进入，需要删除当前所有已插入，返回错误
			         $this->response->setResponse(21,'写入输入参数失败！');

			         //删除已经插入的数据
			         Db::name('input_params')
			         ->where('ApiId',request()->post('Id'))
			         ->delete();

			         Db::name('apis')
			         ->where('Id',request()->post('Id'))
			         ->delete();
			         return;
			       }
	           }


	           if(count($outputs) > 0) {
		           $res = Db::name('output_params')->insertAll($outputs);

			       if($res !== count($outputs)) {
			       	 //表示没有完全插入进入，需要删除当前所有已插入，返回错误
			         $this->response->setResponse(21,'写入输入参数失败！');

			         //删除已经插入的数据
			         Db::name('output_params')
			         ->where('ApiId',request()->post('Id'))
			         ->delete();

			         Db::name('apis')
			         ->where('Id',request()->post('Id'))
			         ->delete();
			         return;
			       }
	           }


	           $this->response->setResponse(200,'新增成功！',$ApiId);

	       }else {
	          $this->response->setResponse(21,'新增失败！');
	       }
        }
        
    }
    
    /**
     * [detail 获取api详情]
     * @Author   罗文
     * @DateTime 2018-04-16
     * @return   [type]     [description]
     */
    public function detail()
    {
       if(!request()->get('ApiId')) {
       	  $this->response->setResponse(21,'查询的ApiId为空！');
       	  return;
       }

       $res = Db::name('apis')
	       ->where('Id',request()->get('ApiId'))
	       ->select();

	   if(count($res) <= 0) {
           $this->response->setResponse(21,'未查询到该apiId相关信息');
	   }else {
           //获取输入输出参数
           $api = $res[0];

           $api['InputParams'] = Db::name('input_params')
	       ->where('ApiId',request()->get('ApiId'))
	       ->select();

	       $api['OutputParams'] = Db::name('output_params')
	       ->where('ApiId',request()->get('ApiId'))
	       ->select();
          
           $this->response->setResponse(200,'成功！',$api);
	   }    
    }
 

}

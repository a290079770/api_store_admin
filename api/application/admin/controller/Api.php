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

	public function index()
    {
        return 1;
    }

    public function apiList()
    {
        return 1;
    }


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
	             ->where('Id','not in',$inputIds)
	             ->delete();
	             Db::name('output_params')
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
 

}

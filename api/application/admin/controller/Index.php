<?php
namespace app\admin\controller;
use think\Controller;
use think\request;
use think\Db;

class Index extends Controller
{
    public function index()
    {
        return $this->fetch('../view/index');
    }

    public function design()
    {
        return $this->fetch('../view/Cate/design');
    }

}

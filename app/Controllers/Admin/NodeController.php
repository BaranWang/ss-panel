<?php

namespace App\Controllers\Admin;

use App\Controllers\AdminController;
use App\Models\Node;

class NodeController extends AdminController
{
    public function index($request, $response, $args)
    {
        $nodes = Node::all();
        return $this->view()->assign('nodes', $nodes)->display('admin/node/index.tpl');
    }

    public function create($request, $response, $args)
    {
        $method = Node::getCustomerMethod();
        return $this->view()->assign('method', $method)->display('admin/node/edit.tpl');
    }

    public function add($request, $response, $args)
    {
        $node = new Node();
        $node['attributes'] = $request->getParsedBody();
        if (!$node->save()) {
            $rs['ret'] = 0;
            $rs['msg'] = "添加失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "节点添加成功";
        return $response->getBody()->write(json_encode($rs));
    }

    public function edit($request, $response, $args)
    {
        $id = $args['id'];
        $node = Node::find($id);
        if ($node == null) {

        }
        $method = Node::getCustomerMethod();
        return $this->view()->assign('node', $node)->assign('method', $method)->display('admin/node/edit.tpl');
    }

    public function update($request, $response, $args)
    {
        $id = $args['id'];
        $node = Node::find($id);
        $node['attributes'] = $request->getParsedBody();
        if (!$node->save()) {
            $rs['ret'] = 0;
            $rs['msg'] = "修改失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "修改成功";
        return $response->getBody()->write(json_encode($rs));
    }


    public function delete($request, $response, $args)
    {
        $id = $args['id'];
        $node = Node::find($id);
        if (!$node->delete()) {
            $rs['ret'] = 0;
            $rs['msg'] = "删除失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "删除成功";
        return $response->getBody()->write(json_encode($rs));
    }

    public function deleteGet($request, $response, $args)
    {
        $id = $args['id'];
        $node = Node::find($id);
        $node->delete();
        return $this->redirect($response, '/admin/node');
    }
}

import datetime
import os
import re
import subprocess
from django.core.paginator import Paginator
from django.db.models import Count
from django.http import HttpResponseRedirect, HttpResponse, HttpResponseForbidden, JsonResponse
from django.shortcuts import render
from user.models import User
from .models import *
workdir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

face_status = ['愤怒','厌恶','恐惧','开心','自然','伤心','惊喜']

def login(req):
    """
    跳转登录
    :param req:
    :return:
    """
    return render(req, 'login.html')


def register(req):
    """
    跳转注册
    :param req:
    :return:
    """
    return render(req, 'register.html')


def index(req):
    """
    跳转首页
    :param req:
    :return:
    """
    username = req.session['username']
    total_user = len(User.objects.all())
    total_info = Pic.objects.count()
    date = datetime.datetime.today()
    month = date.month
    year = date.year
    return render(req, 'index.html', locals())


def login_out(req):
    """
    注销登录
    :param req:
    :return:
    """
    del req.session['username']
    return HttpResponseRedirect('/')


def personal(req):
    username = req.session['username']
    role_id = req.session['role']
    user = User.objects.filter(name=username).first()
    return render(req, 'personal.html', locals())


def upload_pic(request):
    if request.method == 'POST':
        form = ImageUploadForm(request.POST, request.FILES)  # 有文件上传要传如两个字段
        if form.is_valid():
            m = User.objects.get(pk=request.session['user_id'])
            m.image = form.cleaned_data['image']  # 直接在这里使用 字段名获取即可
            m.save()
            return HttpResponse('image upload success')
        return HttpResponseForbidden('allowed only via POST')



def get_data(request):
    """
    获取列表信息 | 模糊查询
    :param request:
    :return:
    """
    keyword = request.GET.get('name')
    page = request.GET.get("page", '')
    limit = request.GET.get("limit", '')
    role_id = request.GET.get('position','')
    response_data = {}
    response_data['code'] = 0
    response_data['msg'] = ''
    data = []
    if keyword is None:
        results_obj = Pic.objects.all()
    else:
        results_obj = Pic.objects.filter(name__contains=keyword).all()
    paginator = Paginator(results_obj, limit)
    results = paginator.page(page)
    if results:
        for user in results:
            record = {
                "id": user.id,
                "name": user.name,
                "face_status": user.face_status,
                "status": user.status,
                'create_time': user.create_time.strftime('%Y-%m-%d %H:%m:%S'),

            }
            data.append(record)
        response_data['count'] =len(results_obj)
        response_data['data'] = data

    return JsonResponse(response_data)


def data(request):
    """
    跳转页面
    """
    username = request.session['username']
    role = int(request.session['role'])
    user_id= request.session['user_id']
    return render(request, 'pics.html', locals())
def analysis(request):
    """
    跳转页面
    """

    username = request.session.get('username', 'admin')
    role = int(request.session.get('role', 3))
    user_id = request.session.get('user_id', 1)
    results = Pic.objects.values('face_status').annotate(myCount=Count('face_status'))  # 返回查询集合
    country = []
    count = []
    for i in results:
        country.append(i['face_status'])
        count.append(i['myCount'])
    result1 = Pic.objects.values('status').annotate(myCount=Count('status'))  # 返回查询集合
    values = []
    for i in result1:
        if i['status']:
            name = '不专注'
        else:
            name = '正常'
        values.append({'name':name,'value':i['myCount']})
    print(values)
    return render(request, 'analysis.html', locals())
def detection(request):
    """
    跳转页面
    """
    username = request.session['username']
    role = int(request.session['role'])
    user_id= request.session['user_id']
    return render(request, 'detection.html', locals())
def pics(request):
    """
    跳转页面
    """
    username = request.session['username']
    role = int(request.session['role'])
    user_id= request.session['user_id']
    return render(request, 'pics.html', locals())
def edit_data(request):
    """
    修改信息
    """
    response_data = {}
    user_id = request.POST.get('id')
    username = request.POST.get('username')
    phone = request.POST.get('phone')
    User.objects.filter(id=user_id).update(
        name=username,
        phone=phone)
    response_data['msg'] = 'success'
    return JsonResponse(response_data, status=201)


def del_data(request):
    """
    删除信息
    """
    user_id = request.POST.get('id')
    result = User.objects.filter(id=user_id).first()
    try:
        if not result:
            response_data = {'error': '删除失败！', 'message': '找不到id为%s' % user_id}
            return JsonResponse(response_data, status=403)
        result.delete()
        response_data = {'message': '删除成功！'}
        return JsonResponse(response_data, status=201)
    except Exception as e:
        response_data = {'message': '删除失败！'}
        return JsonResponse(response_data, status=403)

# 保存缓存文件
def save_file(file):
    if file is not None:
        file_name = os.path.join(workdir, 'static', 'uploadImg', file.name)
        with open(file_name, 'wb')as f:
            # chunks()每次读取数据默认 我64k
            for chunk in file.chunks():
                f.write(chunk)
            f.close()
        return file_name
    else:
        return None

def predict(request):
    image = request.FILES.get('image')
    file_name = save_file(image)
    file_path = os.path.join(workdir, 'static', 'uploadImg', image.name)
    if not os.path.exists(os.path.join(workdir, 'static', 'result')):
        os.mkdir(os.path.join(workdir, 'static', 'result'))
    result_path = os.path.join(workdir, 'static', 'result')
    print(print(f'python demo.py --image_dir {file_path} --out_dir {result_path}'))
    try:
        result = subprocess.run(f'python demo.py --image_dir {file_path} --out_dir {result_path}', shell=True, capture_output=True, text=True, encoding='utf-8')

        print(result.stdout)
        # 定义正则表达式模式
        pattern = r"pred_index:\[(.*?)\]"

        # 使用 re.findall() 方法查找匹配的内容
        try:
            matches = int(re.findall(pattern, result.stdout)[0][0])
        except:
            return JsonResponse({'result': '未检测到人脸'})
        if matches==4:
            status=0
        else:
            status=1
        Pic.objects.create(
            name=image.name,
            face_status=face_status[matches],
            status=status)
        return JsonResponse({'result': '检测结果为：'+face_status[matches]})
    except Exception as e:
        print(e)
        return JsonResponse({"error": 403})

def camera_open(request):
    # 在这里运行 demo.py 中相关的代码
    # ...
    os.system(f'python demo.py --video_file 0')

    return HttpResponse(status=204)

def camera(request):
    """
    跳转页面
    """
    username = request.session['username']
    role = int(request.session['role'])
    user_id= request.session['user_id']
    return render(request, 'camera.html', locals())
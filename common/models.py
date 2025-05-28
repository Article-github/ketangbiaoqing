from django.db import models


# Create your models here.

class Pic(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(verbose_name="图片名字", default='', max_length=100)
    face_status = models.CharField(verbose_name="表情", default='', max_length=100)
    status = models.BooleanField(verbose_name="是否存在危险", default=False)
    create_time = models.DateTimeField('创建时间', auto_now_add=True)
    def __str__(self):
        return self.name

    class Meta:
        db_table = 'pic'
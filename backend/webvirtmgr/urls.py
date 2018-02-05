from django.conf.urls import patterns, url
from django.conf import settings

urlpatterns = patterns('',
    url(r'^$', 'servers.views.index', name='index'),
    url(r'^login/$', 'django.contrib.auth.views.login', {'template_name': 'login.html'}, name='login'),
    url(r'^logout/$', 'django.contrib.auth.views.logout', {'template_name': 'logout.html'}, name='logout'),
    url(r'^servers$', 'servers.views.servers_list', name='servers_list'),
    url(r'^infrastructure$', 'servers.views.infrastructure', name='infrastructure'),
    url(r'^(\d+)/host$', 'hostdetail.views.overview', name='overview'),
    url(r'^(\d+)/create$', 'create.views.create', name='create'),
    url(r'^(\d+)/storages$', 'storages.views.storages', name='storages'),
    url(r'^(\d+)/storage/([\w\-\.]+)$', 'storages.views.storage', name='storage'),
    url(r'^(\d+)/networks$', 'networks.views.networks', name='networks'),
    url(r'^(\d+)/network/([\w\-\.]+)$', 'networks.views.network', name='network'),
    url(r'^(\d+)/interfaces$', 'interfaces.views.interfaces', name='interfaces'),
    url(r'^(\d+)/interface/([\w\.]+)$', 'interfaces.views.interface', name='interface'),
    url(r'^(\d+)/instance/([\w\-\.]+)$', 'instance.views.instance', name='instance'),
    url(r'^(\d+)/instances$', 'instance.views.instances', name='instances'),
    url(r'^(\d+)/secrets$', 'secrets.views.secrets', name='secrets'),
    url(r'^console/$', 'console.views.console', name='console'),
    url(r'^info/hostusage/(\d+)/$', 'hostdetail.views.hostusage', name='hostusage'),
    url(r'^info/insts_status/(\d+)/$', 'instance.views.insts_status', name='insts_status'),
    url(r'^info/instusage/(\d+)/([\w\-\.]+)/$', 'instance.views.instusage', name='instusage'),
)

urlpatterns += patterns('',
    (r'^static/(?P<path>.*)$', 'django.views.static.serve', {'document_root': settings.STATIC_ROOT}),
)
